<?php
require_once($_SERVER["STATIC"]."/settings.php");
require_once($_SERVER["STATIC"]."/assets.php");

// headers
Header("Content-Type:text/plain");

// set vars
$id = (int)$_GET["assetId"] ?? die(header("Location: /RobloxDefaultErrorPage.aspx?code=500"));;
$format = $_GET["format"] ?? die(header("Location: /RobloxDefaultErrorPage.aspx?code=500"));
$width = (int)$_GET["width"] ?? die(header("Location: /RobloxDefaultErrorPage.aspx?code=500"));
$height = (int)$_GET["height"] ?? die(header("Location: /RobloxDefaultErrorPage.aspx?code=500"));
$path = "../../content/thumbnails/assets/".$id.".".$format;
	
// asset info	
$asset = (new Asset($id))->GetAllAssetInfo();

switch(true)
{
	case file_exists($path) && $width && $height:
		
		// set up image + resizing
		$thumb = imagecreatetruecolor($width, $height);
        imagesetinterpolation($thumb,IMG_BICUBIC);
		
		// save transparency
		imagealphablending($thumb, false);
		imagesavealpha($thumb,true);
		
		// get image size
		$imagesize = getimagesize($path);
		
		// resize
		imagecopyresampled($thumb, imagecreatefrompng($path), 0, 0, 0, 0, $width, $height, $imagesize[0], $imagesize[1]);
		
		// return image
		if($width == $height)
			imagepng($thumb);
		else
			die(header("Location: /RobloxDefaultErrorPage.aspx?code=500"));
		
		break;
	case isset($asset->id) && $width && $height:
		
		// set up image + resizing
		$thumb = imagecreatetruecolor($width, $height);
        imagesetinterpolation($thumb,IMG_BICUBIC);
		
		// save transparency
		imagealphablending($thumb, false);
		imagesavealpha($thumb,true);
		
		// get image size
		$imagesize = getimagesize("./defaultimage.png");
		
		// resize
		imagecopyresampled($thumb, imagecreatefrompng("./defaultimage.png"), 0, 0, 0, 0, $width, $height, $imagesize[0], $imagesize[1]);
		
		// return image
		if($width == $height)
			imagepng($thumb);
		else
			die(header("Location: /RobloxDefaultErrorPage.aspx?code=500"));
		
		break;
	default:
		// decode the json from api
		$json = json_decode(file_get_contents("https://thumbnails.roblox.com/v1/assets?assetIds=".$id."&size=".$width."x".$height."&format=".$format."&isCircular=false"));
		
		// if the json returned is success
		if($json && $json->data[0]->imageUrl)
		{
			die(header("Location: ".$json->data[0]->imageUrl));
		}
		else
		{
			die(header("Location: /RobloxDefaultErrorPage.aspx?code=500"));
		}
}