<?php
require_once($_SERVER["STATIC"]."/connection.php");
require_once($_SERVER["STATIC"]."/profanity_filter.php");
header("Content-Type: application/json");
if (!isset($_GET["username"])) die();
// profanity filter
$username = $_GET["username"];
if (!ProfanityFilter::IsAppropriateForSignup($_GET["username"]))
	die(json_encode(["data" => 2]));
// length check
if (strlen($username) < 3 || strlen($username) > 20)
	die(json_encode(["data" => 2]));
// username ownership check
$stmt = $conn->prepare("SELECT * FROM users WHERE username=:username");
$stmt->bindParam(":username", $username);
$stmt->execute();
if ($stmt->rowCount() >= 1)
	die(json_encode(["data" => 1]));
die(json_encode(["data" => 0]));
?>