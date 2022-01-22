<?php
// ROBLOSIUM 2013
require_once($_SERVER["STATIC"]."/friends.php");
require_once($_SERVER["STATIC"]."/package_compiler.php");
require_once($_SERVER["STATIC"]."/authentication.php");

// initiate Friends class
$Friends = new Friends($userAuth->GetUserInfo("id"), $_POST["targetUserID"]);

if($Friends->GetStatus())
	$Friends->SetStatus(2);