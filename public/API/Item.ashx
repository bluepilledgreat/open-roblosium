<?php
// ROBLOSIUM 2013
require_once($_SERVER["STATIC"]."/assets.php");
require_once($_SERVER["STATIC"]."/package_compiler.php");
require_once($_SERVER["STATIC"]."/authentication.php");

// headers
header("Content-Type:application/json");

// initiate Asset class
$AssetClass = new Asset((int)$_GET["productID"]);
$Asset = $AssetClass->GetAllAssetInfo();

// initiate UserAuth class for getting creator info
$Creator = (object)(new UserAuthentication($Asset->uid))->GetAllUserInfo();

if($userAuth)
{
	if($_GET["rqtype"] == "purchase")
	{
		$expectedCurrency = $_GET["expectedCurrency"]; // 1 = robux, 2 = tickets
		$expectedPrice = $_GET["expectedPrice"];
		// $expectedSellerID = $_GET["expectedSellerID"];
		
		$purchaseStatus = $AssetClass->BuyItem($expectedCurrency);
		$currencyStr = ($expectedCurrency == 1) ? "robux" : "tickets";
		
		if($purchaseStatus == 1) 
		{
			http_response_code(200);
			die(json_encode([
			"TransactionVerb" => "purchased",
			"AssetName" => $Asset->title,
			"AssetType" => $_S->AssetTypes[$Asset->assettype]["name"],
			"Price" => $Asset->$currencyStr,
			"Currency" => $expectedCurrency,
			"SellerName" => $Creator->username,
			"AssetID" => $Asset->id,
			"expectedCurrency" => $expectedCurrency,
			"currentCurrency" => $expectedCurrency,
			]));
		} 
		else if($purchaseStatus == 2)
		{
			http_response_code(400);
			die(json_encode([
			"title" => "Error",
			"errorMsg" => "You already own this item.",
			"showDivID" => "TransactionFailureView"
			]));
		}
		else if($expectedPrice != $Asset->$currencyStr)
		{
			http_response_code(400);
			die(json_encode([
			"title" => "Item Price Has Changed",
			"errorMsg" => "While you were shopping, the price of this item had changed.",
			"showDivID" => "TransactionFailureView",
			]));
		}
		else
		{
			http_response_code(400);
			die(json_encode([
			"title" => "Error",
			"errorMsg" => "Sorry, an error occurred. Please try again later.",
			"showDivID" => "TransactionFailureView"
			]));
		}
	}
}
else
{
	http_response_code(500);
	die(require_once("../RobloxDefaultErrorPage.aspx"));
}