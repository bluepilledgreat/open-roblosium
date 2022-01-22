<?php
// ROBLOSIUM 2013

require_once($_SERVER["STATIC"]."/connection.php");
require_once($_SERVER["STATIC"]."/settings.php");

class Friends {
    private $friendInfo;
	private $user1;
	private $user2;
    public $exists;
    
    function __construct($user1, $user2) // must be ids
    {
        global $conn;
		$this->user1 = $user1;
		$this->user2 = $user2;
        
        // search for friend data
        $stmt = $conn->prepare("SELECT * FROM friends WHERE (sender = :t1 AND receiver = :t2) OR (sender = :t3 AND receiver = :t4)");
        $stmt->bindParam(":t1", $user1, PDO::PARAM_INT);
        $stmt->bindParam(":t2", $user2, PDO::PARAM_INT);
		$stmt->bindParam(":t3", $user2, PDO::PARAM_INT);
        $stmt->bindParam(":t4", $user1, PDO::PARAM_INT);
        $stmt->execute();
        
        if ($stmt->rowCount() === 1)
        {
            // provide friend data
            $this->friendInfo = $stmt->fetch(PDO::FETCH_OBJ);
            $this->exists = true;
        }
        else
            $this->exists = false;
    }
    
    function GetFriendshipInfo()
    {
        return $this->friendInfo;
    }
    
	// friend counts
    function GetCount($status=2, $all=false)
    {
        global $conn;
        
        // get friend data
		if($status == 1)
		{
			$stmt = $conn->prepare("SELECT * FROM friends WHERE (receiver = :t2) AND status = :i");
			$stmt->bindParam(":i", $status, PDO::PARAM_INT);
			$stmt->bindParam(":t2", $this->user2, PDO::PARAM_INT);
		}
		else if($all) // get the count for all friends
		{
			$stmt = $conn->prepare("SELECT * FROM friends WHERE ((sender = :t1) OR (receiver = :t2)) AND ((status=2) OR (status=3))");
			$stmt->bindParam(":t1", $this->user2, PDO::PARAM_INT);
			$stmt->bindParam(":t2", $this->user2, PDO::PARAM_INT);
		} 
		else
		{
			$stmt = $conn->prepare("SELECT * FROM friends WHERE ((sender = :t1) OR (receiver = :t2)) AND status = :i");
			$stmt->bindParam(":i", $status, PDO::PARAM_INT);
			$stmt->bindParam(":t1", $this->user2, PDO::PARAM_INT);
			$stmt->bindParam(":t2", $this->user2, PDO::PARAM_INT);
		}
		
        $stmt->execute();
        
        // return friend count
        return $stmt->rowCount();
    }
	
	function GetStatus()
    {
        global $conn;
		// data exists?
		if($this->exists == false)
			return 0;
		
        $stmt = $conn->prepare("SELECT status FROM friends WHERE ((sender = :t1 AND receiver = :t2) OR (sender = :t3 AND receiver = :t4))");
        $stmt->bindParam(":t1", $this->user1, PDO::PARAM_INT);
        $stmt->bindParam(":t2", $this->user2, PDO::PARAM_INT);
        $stmt->bindParam(":t3", $this->user2, PDO::PARAM_INT);
        $stmt->bindParam(":t4", $this->user1, PDO::PARAM_INT);
        $stmt->execute();
        if ($stmt->rowCount() === 1)
        {
            return $stmt->fetch(PDO::FETCH_ASSOC)["status"];
        }
        return false;
    }
    
	// request friend
    function AddAsFriend() {
        global $conn;
        $stmt = $conn->prepare("INSERT INTO `friends` (`sender`, `receiver`, `status`) VALUES (:t1, :t2, '1');");
        $stmt->bindParam(":t1", $this->user1, PDO::PARAM_INT);
        $stmt->bindParam(":t2", $this->user2, PDO::PARAM_INT);
        $stmt->execute();
    }
	
	// accepting, declining friends, removing friends
	function SetStatus($input) {
		global $conn;
        $stmt = $conn->prepare("UPDATE friends SET status = :i WHERE (sender = :t1 AND receiver = :t2) OR (sender = :t3 AND receiver = :t4)");
        $stmt->bindParam(":i", $input, PDO::PARAM_INT);
		$stmt->bindParam(":t1", $this->user1, PDO::PARAM_INT);
        $stmt->bindParam(":t2", $this->user2, PDO::PARAM_INT);
        $stmt->bindParam(":t3", $this->user2, PDO::PARAM_INT);
        $stmt->bindParam(":t4", $this->user1, PDO::PARAM_INT);
        $stmt->execute();
	}
    
    function RevokeFriend() {
        global $conn;
        $stmt = $conn->prepare("DELETE FROM friends WHERE (sender = :t1 AND receiver = :t2) OR (sender = :t3 AND receiver = :t4)");
        $stmt->bindParam(":t1", $this->user1, PDO::PARAM_INT);
        $stmt->bindParam(":t2", $this->user2, PDO::PARAM_INT);
        $stmt->bindParam(":t3", $this->user2, PDO::PARAM_INT);
        $stmt->bindParam(":t4", $this->user1, PDO::PARAM_INT);
        $stmt->execute();
    }
}