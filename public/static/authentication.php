<?php
// ROBLOSIUM 2013

// TODO: move outside db, do encrypting and decrypting using **SPECIAL KEY**, currently, we are encrypting with SPECIAL KEY but not decrypting
require_once($_SERVER["STATIC"]."/connection.php");
require_once($_SERVER["STATIC"]."/settings.php");
require_once($_SERVER["STATIC"]."/encryption.php");
define("AUTHTOKEN_PREFIX", "_|WARNING:-DO-NOT-SHARE-THIS.--Sharing-this-will-allow-someone-to-log-in-as-you-and-to-steal-your-ROBUX-and-items.|_");

function isTimeConsideredOnline($time)
{
	return $time + 180 - time() > 0;
}

// https://stackoverflow.com/a/3776832
function calculateAge($date)
{
	$tz = new DateTimeZone('America/New_York');
	return DateTime::createFromFormat('d/m/Y', $date, $tz)
     ->diff(new DateTime('now', $tz))
     ->y;
}

// ROBLOSECURITY should start with "_|WARNING:-DO-NOT-SHARE-THIS.--Sharing-this-will-allow-someone-to-log-in-as-you-and-to-steal-your-ROBUX-and-items.|_"
// and should be 680 characters long (with prefix, 796)
class UserAuthentication {
	private $userInfo;
	public $exists;
	
	function __construct($input)
	{
		global $conn;
		$isId = is_numeric($input);
		// search for user in database
		$stmt = $conn->prepare("SELECT * FROM users WHERE ".($isId ? "id=" : "username=").":input");
		$stmt->bindParam(":input", $input, ($isId ? PDO::PARAM_INT : PDO::PARAM_STR));
		$stmt->execute();
		if ($stmt->rowCount() === 1)
		{
			$this->userInfo = (object)$stmt->fetch(PDO::FETCH_ASSOC);
			$this->exists = true;
		}
		else
			$this->exists = false;
	}
	
	//https://stackoverflow.com/a/4356295
	private function generateRandomString($length = 10) {
		global $_S;
		srand(crc32("UserAuthenticationToken-".$_S->SpecialKey."-Roblosium-UID:".$this->userInfo->id));
		$characters = 'ABCDEF0123456789';
		$charactersLength = strlen($characters);
		$randomString = '';
		for ($i = 0; $i < $length; $i++) {
			$randomString .= $characters[rand(0, $charactersLength - 1)];
		}
		srand(); // reset seed
		return $randomString;
	}
	
	function GetAuthenticationToken($prefix = true)
	{
		global $_S;
		if (!$this->exists)
			return false;
		try {
			return ($prefix ? AUTHTOKEN_PREFIX : "").strtoupper(bin2hex(Encryption::encrypt($this->userInfo->id, $_S->EncryptionKey)));
		} catch (Exception $e) {
			throw new Exception('Failed to generate cookie');
		}
	}
	
	function GetUserInfo($v)
	{
		return @$this->userInfo->$v;
	}
	
	function GetAllUserInfo()
	{
		return $this->userInfo;
	}
	
	function IsOnline()
	{
		return isTimeConsideredOnline($this->userInfo->lastonline);
	}
	
	function GetUserAge()
	{
		return calculateAge($this->userInfo->birthday);
	}
	
	function IsOver13()
	{
		return $this->GetUserAge() >= 13;
	}	

	function Fix() // for compatibility, deprecated, do not use in newer work
	{
		if (!$this->exists)
			return false;
		return $this;
	}
	
	static function GetInstanceFromCookie($cookie, $checkForPrefix = true)
	{
		global $_S;
		if ($checkForPrefix && !str_starts_with($cookie, AUTHTOKEN_PREFIX))
			return false;
		$authTokenEncrypted = strtolower(str_replace(AUTHTOKEN_PREFIX, "", $cookie));
		// lets try decrypting the cookie
		$authToken;
		try {
			$authToken = Encryption::decrypt(@hex2bin($authTokenEncrypted), $_S->EncryptionKey);
		} catch(Exception $e) {
			return false; // nope, bad cookie
		}
		if (is_numeric($authToken)) // nice!!!
			return (new static($authToken))->Fix();
		return false; // ...
	}
}

$userAuth = false;
if (!empty($_COOKIE["_ROBLOSECURITY"]))
	$userAuth = UserAuthentication::GetInstanceFromCookie($_COOKIE["_ROBLOSECURITY"]);
?>