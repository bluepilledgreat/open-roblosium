<?php
// ROBLOSIUM 2013

require_once($_SERVER["STATIC"]."/connection.php");
require_once($_SERVER["STATIC"]."/settings.php");

class Asset {
	private $assetInfo;
	public $exists;
	
	function __construct($input)
	{
		global $conn;
		$isId = is_numeric($input);
		// search for user in database
		$stmt = $conn->prepare("SELECT * FROM assets WHERE id=:input");
		$stmt->bindParam(":input", $input, PDO::PARAM_INT);
		$stmt->execute();
		if ($stmt->rowCount() === 1)
		{
			$this->assetInfo = (object)$stmt->fetch(PDO::FETCH_ASSOC);
			$this->exists = true;
		}
		else
			$this->exists = false;
	}
	
	function GetAssetInfo($v)
	{
		return @$this->assetInfo->$v;
	}
	
	function GetAllAssetInfo()
	{
		return $this->assetInfo;
	}
	
	function IsInInventory($v)
	{
		global $conn;
		// data exists?
		if($this->exists == false)
			return 0;
		
        $stmt = $conn->prepare("SELECT * FROM inventory WHERE item = :t1 AND owner = :t2");
        $stmt->bindParam(":t1", $this->assetInfo->id, PDO::PARAM_INT);
        $stmt->bindParam(":t2", $v, PDO::PARAM_INT);
        $stmt->execute();
        if ($stmt->rowCount() === 1)
        {
            return true;
        }
        return false;
	}
	
	function AddToInventory($v)
	{
		global $conn;
		// data exists?
		if($this->exists == false)
			return 0;
		
		// get amount sold and add onto it
		$stmt = $conn->prepare("SELECT * FROM inventory WHERE item = :t1");
        $stmt->bindParam(":t1", $this->assetInfo->id, PDO::PARAM_INT);
		$stmt->execute();
		$sold = (int)$stmt->rowCount();
		
        // insert into inventory
		$stmt = $conn->prepare("INSERT INTO inventory (item, sold, owner, date) VALUES (:t1, :t2, :t3, :t4)");
		$stmt->bindParam(":t1", $this->assetInfo->id, PDO::PARAM_INT);
		$stmt->bindValue(":t2", $sold + 1, PDO::PARAM_INT);
		$stmt->bindValue(":t3", $userAuth->GetUserInfo("id"), PDO::PARAM_INT);
		$stmt->bindValue(":t4", time(), PDO::PARAM_INT);
		$stmt->execute();
		return true;
	}
	
	function RemoveFromInventory($v)
	{
		global $conn;
		// data exists?
		if($this->exists == false)
			return false;
		
        $stmt = $conn->prepare("DELETE FROM inventory WHERE item = :t1 AND owner = :t2");
        $stmt->bindParam(":t1", $this->assetInfo->id, PDO::PARAM_INT);
        $stmt->bindParam(":t2", $v, PDO::PARAM_INT);
        $stmt->execute();
        return true;
	}
	
	function GetAmountSold()
    {
        global $conn;
		// data exists?
		if($this->exists == false)
			return 0;
		
        // get amount sold
		$stmt = $conn->prepare("SELECT * FROM inventory WHERE item = :t1");
        $stmt->bindParam(":t1", $this->assetInfo->id, PDO::PARAM_INT);
		$stmt->execute();
		return $stmt->rowCount();
    }
	
	function BuyItem($currency)
	{
		global $conn, $userAuth;
		// data exists?
		if($this->exists == false)
			return 0;
		
		// get currency string
		$currency = ($currency == 1) ? "robux" : "tickets";
		
		// get amount sold and add onto it
		$stmt = $conn->prepare("SELECT * FROM inventory WHERE item = :t1");
        $stmt->bindParam(":t1", $this->assetInfo->id, PDO::PARAM_INT);
		$stmt->execute();
		$sold = (int)$stmt->rowCount();
		
		// does the user have sufficient currency
		if((int)$this->assetInfo->$currency < $userAuth->GetUserInfo($currency))
		{
			if(!$this->IsInInventory($userAuth->GetUserInfo("id")))
			{
				// insert into inventory
				$stmt = $conn->prepare("INSERT INTO inventory (item, sold, owner, date) VALUES (:t1, :t2, :t3, :t4)");
				$stmt->bindParam(":t1", $this->assetInfo->id, PDO::PARAM_INT);
				$stmt->bindValue(":t2", $sold + 1, PDO::PARAM_INT);
				$stmt->bindValue(":t3", $userAuth->GetUserInfo("id"), PDO::PARAM_INT);
				$stmt->bindValue(":t4", time(), PDO::PARAM_INT);
				$stmt->execute();
				
				// take currency from balance of the buyer
				$stmt = $conn->prepare("UPDATE users SET $currency = $currency - :t1 WHERE id = :t2");
				$stmt->bindValue(":t1", round($this->assetInfo->$currency), PDO::PARAM_INT);
				$stmt->bindValue(":t2", $userAuth->GetUserInfo("id"));
				$stmt->execute();
				
				// add 70% of item price to balance of the seller
				$stmt = $conn->prepare("UPDATE users SET $currency = $currency + :t1 WHERE id = :t2");
				$stmt->bindValue(":t1", round($this->assetInfo->$currency * 0.7, 0), PDO::PARAM_INT);
				$stmt->bindParam(":t2", $this->assetInfo->uid);
				$stmt->execute();
				
				return 1; // return success
			}
			else
			{
				return 2; // return that it is already owned
			}
		}
		return false; // ERROR WE'RE GOING OVERBOARD HELP US
	}

	function Fix() // compatibility
	{
		if (!$this->exists)
			return false;
		return $this;
	}
}