<?php
require_once($_SERVER["STATIC"]."/connection.php");
require_once($_SERVER["STATIC"]."/authentication.php");
require_once($_SERVER["STATIC"]."/profanity_filter.php");
$status = $_POST["status"];
if (!$userAuth)
	header("Location: /NewLogin");
elseif (empty($status))
	die();
header("Content-Type: application/json");
$status = ProfanityFilter::Censor($status);
$stmt = $conn->prepare("INSERT INTO statuses (uid, status, date) VALUES (:uid, :status, :date)");
$stmt->bindValue(":uid", $userAuth->GetUserInfo("id"));
$stmt->bindParam(":status", $status);
$stmt->bindValue(":date", time());
$stmt->execute();
$stmt = $conn->prepare("UPDATE users SET status=:status WHERE id=:id");
$stmt->bindValue(":id", $userAuth->GetUserInfo("id"));
$stmt->bindParam(":status", $status);
$stmt->execute();
die(json_encode(["success" => true, "message" => $status]));
?>