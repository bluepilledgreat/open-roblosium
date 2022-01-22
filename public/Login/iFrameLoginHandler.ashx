<?php
// ROBLOSIUM 2013
// TODO: remove this once LoginService is finished
require_once($_SERVER["STATIC"]."/authentication.php");
header("Content-Type: application/json");
if ($userAuth)
	die();
$userAuth = (new UserAuthentication($_POST["userName"]))->Fix();
if ($userAuth === false)
	die(json_encode(["IsValid" => false, "ErrorCode" => "7", "Message" => ""]));
if (!password_verify($_POST["password"], $userAuth->GetUserInfo("password")))
	die(json_encode(["IsValid" => false, "ErrorCode" => "7", "Message" => ""]));
setrawcookie(".ROBLOSECURITY", $userAuth->GetAuthenticationToken(), 2147483647, "/", $_SERVER['HTTP_HOST']);
die(json_encode(["IsValid" => true, "ErrorCode" => "0", "Message" => ""]));
?>