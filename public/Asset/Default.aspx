<?php
require_once($_SERVER["STATIC"]."/settings.php");
require_once($_SERVER["STATIC"]."/assets.php");
require_once($_SERVER["STATIC"]."/authentication.php");

// headers
header("Content-type: binary/octet-stream; content-encoding: gzip");

// set vars
$id = (int)$_GET["id"];
		
$asset = (new Asset($id))->GetAllAssetInfo();

switch(true)
{
	case file_exists("../../content/assets/" . $id) && $asset->assettype == 5:
		//sign cs
		$script = file_get_contents("../../content/assets/" . $id); // no compression for ease of access
		$script = "\n--rbxassetid%".$id."%\n".$script; // add asset id to the start
		$sig; // hold signature for later use
		openssl_sign($script, $sig, file_get_contents("../../content/private/rbxPrivate.blob")); // sign the script
		$script = "--rbxsig%".base64_encode($sig)."%".$script; // add sig
		echo $script;
		break;
	case file_exists("../../content/assets/" . $id): // if the file is a ROBLOSIUM asset
		// is the user authorized to access this asset?
		if($asset->copylocked === false || $userAuth->GetUserInfo("id") == $asset->uid) 
		{
			// decompresses file
			echo gzdecode(file_get_contents("../../content/assets/" . $id));
		} 
		else
		{
			Header("Location: /RobloxDefaultErrorPage.aspx?code=500");
			die();
		}
		break;
	default: // redirects to asset on ROBLOX
		Header("Location: https://assetdelivery.roblox.com/v1/asset/?id=".$id);
		break;
}