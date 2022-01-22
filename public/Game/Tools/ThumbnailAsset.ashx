<?php
// disable error reporting
error_reporting(0);

// defaults format to png
if(isset($_GET["fmt"]))
	$format = $_GET["fmt"];
else
	$format = "png";

$json = json_decode(file_get_contents("https://thumbnails.roblox.com/v1/assets?assetIds=".$_GET["aid"]."&size=".$_GET["wd"]."x".$_GET["ht"]."&format=".$format."&isCircular=false"));
die(header("Location: ".$json->data[0]->imageUrl));
?>