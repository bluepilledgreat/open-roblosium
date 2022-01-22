<?php

define("HOLIDAY_NONE", 0);
define("HOLIDAY_HALLOWEEN", 1);
define("HOLIDAY_THANKSGIVING", 2);
define("HOLIDAY_CHRISTMAS", 3);

// INCLUDES:
require_once($_SERVER["STATIC"]."/logging.php");

$_S = (object)[
	"IsProduction" => false,
	"RootFolder" => "CHANGE_THIS",
	"DBUser" => "root",
	"DBPass" => "",
	"HolidayType" => HOLIDAY_NONE,
	"TrackersEnabled" => false,
	"SiteURL" => "localhost",
	"Emails" => (object)[
		"CustomerSupport" => "info@roblox.com"
	],
	"SpecialKey" => "CHANGE_THIS", // used for generating and authenticating items
	"EncryptionKey" => hex2bin('015893876940948576903987df78f9789689faaa385093885959938ffffff749'), // CHANGE THIS! used for encryption
	"AnimatedLandingRedirect" => false // /Default.aspx -> /Landing/Animated
];

$_PS = (object)[
	"Title" => "ROBLOX.com",
	"AllowHolidayThemes" => true,
	"CSS" => [],
	"JS" => [],
	"HeaderAds" => true,
	"NavigationOptions" => true,
	"HeaderTipsy" => true,
	"ASPNetFormTagEnabled" => true,
	"UseJQueryUILib" => false,
	"SubmenuEnabled" => true,
	"UseForumCSS" => false,
	"FooterJS" => "",
	"AutomaticallyGiveOBCUsersTheme" => false,
	"EnableOBCTheme" => false,
	"ChatEnabled" => true
];

$_S->AssetTypes = [
1 => ["id" => 1, "name" => "Image", "hidden" => true],
2 => ["id" => 2, "name" => "T-Shirt", "hidden" => false],
3 => ["id" => 3, "name" => "Audio", "hidden" => false],
4 => ["id" => 4, "name" => "Mesh", "hidden" => true],
5 => ["id" => 5, "name" => "Lua", "hidden" => true],
6 => ["id" => 6, "name" => "HTML", "hidden" => true],
7 => ["id" => 7, "name" => "Text", "hidden" => true],
8 => ["id" => 8, "name" => "Hat", "hidden" => false],
9 => ["id" => 9, "name" => "Place", "hidden" => false],
10 => ["id" => 10, "name" => "Model", "hidden" => false],
11 => ["id" => 11, "name" => "Shirt", "hidden" => false],
12 => ["id" => 12, "name" => "Pants", "hidden" => false],
13 => ["id" => 13, "name" => "Decal", "hidden" => false],
16 => ["id" => 16, "name" => "Avatar", "hidden" => true],
17 => ["id" => 17, "name" => "Head", "hidden" => false],
18 => ["id" => 18, "name" => "Face", "hidden" => false],
19 => ["id" => 19, "name" => "Gear", "hidden" => false],
21 => ["id" => 21, "name" => "Badge", "hidden" => true],
22 => ["id" => 22, "name" => "Group Emblem", "hidden" => true],
24 => ["id" => 24, "name" => "Animation", "hidden" => true],
25 => ["id" => 25, "name" => "Arms", "hidden" => true],
26 => ["id" => 26, "name" => "Legs", "hidden" => true],
27 => ["id" => 27, "name" => "Torso", "hidden" => true],
28 => ["id" => 28, "name" => "Right Arm", "hidden" => true],
29 => ["id" => 29, "name" => "Left Arm", "hidden" => true],
30 => ["id" => 30, "name" => "Left Leg", "hidden" => true],
31 => ["id" => 31, "name" => "Right Leg", "hidden" => true],
32 => ["id" => 32, "name" => "Package", "hidden" => false],
33 => ["id" => 33, "name" => "YouTube Video", "hidden" => true],
34 => ["id" => 34, "name" => "Game Pass", "hidden" => true],
0 => ["id" => 0, "name" => "Product", "hidden" => true],
];

$_S->CatalogCategories = [
1 => ["id" => 1, "name" => "All Categories", "subcategories" => [2,8,11,12,17,18,19,32], "limited" => false],
0 => ["id" => 0, "name" => "Featured", "subcategories" => [8], "limited" => false],
// 2 => ["id" => 2, "name" => "Collectibles", "subcategories" => [8,32], "limited" => true],
3 => ["id" => 3, "name" => "Clothing", "subcategories" => [2,11,12,8], "limited" => false],
4 => ["id" => 4, "name" => "Body Parts", "subcategories" => [32], "limited" => false],
5 => ["id" => 5, "name" => "Gear", "subcategories" => [19], "limited" => false],
6 => ["id" => 6, "name" => "Models", "subcategories" => [10], "limited" => false],
7 => ["id" => 7, "name" => "Decals", "subcategories" => [13], "limited" => false],
8 => ["id" => 8, "name" => "Audio", "subcategories" => [3], "limited" => false],
];

$_S->Genres = [
0 => ["id" => 0, "name" => "All", "cssname" => "All", "hidden" => true],
1 => ["id" => 1, "name" => "Town and City", "cssname" => "Town City", "hidden" => false],
2 => ["id" => 2, "name" => "Medieval", "cssname" => "Fantasy", "hidden" => false],
3 => ["id" => 3, "name" => "Sci-Fi", "cssname" => "Sci-Fi", "hidden" => false],
4 => ["id" => 4, "name" => "Fighting", "cssname" => "Ranged", "hidden" => false],
5 => ["id" => 5, "name" => "Horror", "cssname" => "Scary", "hidden" => false],
6 => ["id" => 6, "name" => "Naval", "cssname" => "War", "hidden" => false],
7 => ["id" => 7, "name" => "Adventure", "cssname" => "Adventure", "hidden" => false],
8 => ["id" => 8, "name" => "Sports", "cssname" => "Sports", "hidden" => false],
9 => ["id" => 9, "name" => "Comedy", "cssname" => "Funny", "hidden" => false],
10 => ["id" => 10, "name" => "Western", "cssname" => "Wild West", "hidden" => false],
11 => ["id" => 11, "name" => "Military", "cssname" => "War", "hidden" => false],
12 => ["id" => 12, "name" => "Skate Park", "cssname" => "Skate Park", "hidden" => true],
13 => ["id" => 13, "name" => "Building", "cssname" => "Building", "hidden" => false],
14 => ["id" => 14, "name" => "FPS", "cssname" => "Ranged", "hidden" => false],
15 => ["id" => 15, "name" => "RPG", "cssname" => "Adventure", "hidden" => false],
];

function AddCSS($arr)
{
	global $_PS;
	if (!is_array($arr))
		Logging::Log("Page Settings", "A non-array given to function AddCSS inside of ".$_SERVER["PHP_SELF"], LOGGING_WARNING, "pagesettings");
	array_push($_PS->CSS, $arr);
}

function AddJS($arr)
{
	global $_PS;
	if (!is_array($arr))
		Logging::Log("Page Settings", "A non-array given to function AddJS inside of ".$_SERVER["PHP_SELF"], LOGGING_WARNING, "pagesettings");
	array_push($_PS->JS, $arr);
}

if (!$_S->IsProduction)
{
	ini_set('display_errors', 1);
	ini_set('display_startup_errors', 1);
	error_reporting(E_ALL);
}
?>