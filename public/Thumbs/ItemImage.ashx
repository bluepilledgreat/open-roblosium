<?php
require_once($_SERVER["STATIC"]."/settings.php");
require_once($_SERVER["STATIC"]."/assets.php");

// headers
Header("Content-Type:text/plain");

// set vars
$Params = json_decode($_GET["params"]);
$ItemImageArr = [];

// for each item requested by the ItemImage API
foreach((object)$Params as $Item) 
{
	$Asset = (object)(new Asset($Item->assetId))->GetAllAssetInfo(); // initialize Asset class
	if(!empty($Asset->id)) 
	{
		// provide item data
		$ItemImageArr[] = [
		"id" => $Asset->id,
		"name" => $Asset->title,
		"url" => "/Item.aspx?ID=".$Asset->id,
		"thumbnailFinal" => true,
		"thumbnailUrl" => "/Thumbs/RawAsset.ashx?assetId=".$Asset->id."&format=PNG&width=110&height=110",
		"bcOverlayurl" => null,
		"limtedOverlayUrl" => null,
		"limitedAltText" => null,
		"newOverlayUrl" => null,
		"imageSize" => "small",
		"saleOverlayUrl" => null,
		"iosOverlayUrl" => null,
		"transparentBackground" => false,
		];
	}
}
?>
<?php echo $_GET["jsoncallback"]; ?>(<?php echo json_encode($ItemImageArr, JSON_UNESCAPED_SLASHES); ?>)
