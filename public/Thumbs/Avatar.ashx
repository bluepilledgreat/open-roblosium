<?php
// disable error reporting
error_reporting(0);

// defaults format to png
if(isset($_GET["format"]))
	$format = $_GET["format"];
else
	$format = "png";

$json = json_decode(file_get_contents("https://thumbnails.roblox.com/v1/users/avatar?userIds=".$_GET["userId"]."&size=".$_GET["x"]."x".$_GET["y"]."&format=".$format."&isCircular=false"));
die(header("Location: ".$json->data[0]->imageUrl));
?>