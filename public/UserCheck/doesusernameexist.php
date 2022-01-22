<?php
require_once($_SERVER["STATIC"]."/connection.php");
if (!isset($_GET["username"])) die();
header("Content-Type: application/json");
$username = $_GET["username"];
$stmt = $conn->prepare("SELECT * FROM users WHERE username=:username");
$stmt->bindParam(":username", $username);
$stmt->execute();
if ($stmt->rowCount() >= 1)
	die(json_encode(["success" => true]));
die(json_encode(["success" => false]));
?>