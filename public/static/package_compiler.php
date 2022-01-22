<?php
// ROBLOSIUM 2013

require_once($_SERVER["STATIC"]."/settings.php");

class PackageCompiler {
	static function CompilePackage($packageName, $packageItems, $packageItemsTrackers)
	{
		global $_S;
		$package = ["package" => $packageName, "items" => []];
		$package["items"] = array_merge($package["items"], $packageItems);
		if ($_S->TrackersEnabled && is_array($packageItemsTrackers))
			$package["items"] = array_merge($package["items"], $packageItemsTrackers);
		return $package;
	}
}

// default packages: css
define("CSS_DEFAULT_PACKAGE", PackageCompiler::CompilePackage("main", [
	"/CSS/Base/CSS/Roblox.css",
	"/CSS/RBXCommon.css",
	"/CSS/Base/CSS/AdFormatClasses.css",
	"/CSS/Base/CSS/Ads.css",
	"/CSS/Base/CSS/AgeUpEmailVerifyPage.css",
	"/CSS/Base/CSS/Asset.css",
	"/CSS/Base/CSS/Badges.css",
	"/CSS/Base/CSS/BCModal.css",
	"/CSS/Base/CSS/Billing.css",
	"/CSS/Base/CSS/carouselpager.css",
	"/CSS/Base/CSS/Catalog.css",
	"/CSS/Base/CSS/CharacterCustomization.css",
	"/CSS/Base/CSS/CharacterSelectAndInstallInstructions.css",
	"/CSS/Base/CSS/CommonForms.css",
	"/CSS/Base/CSS/ContentAdapters.css",
	"/CSS/Base/CSS/ContentBuilder.css",
	"/CSS/Base/CSS/Contest.css",
	"/CSS/Base/CSS/CreditCardExpireModal.css",
	"/CSS/Base/CSS/CuratedGames.css",
	"/CSS/Base/CSS/CurrencyExchange.css",
	"/CSS/Base/CSS/Games.css",
	"/CSS/Base/CSS/GenericModal.css",
	"/CSS/Base/CSS/GroupRoleSetMembersPane.css",
	"/CSS/Base/CSS/Groups.css",
	"/CSS/Base/CSS/Help.css",
	"/CSS/Base/CSS/iFrameLogin.css",
	"/CSS/Base/CSS/Install.css",
	"/CSS/Base/CSS/Item.css",
	"/CSS/Base/CSS/LandingGames.css",
	"/CSS/Base/CSS/Language.css",
	"/CSS/Base/CSS/ManageAccount.css",
	"/CSS/Base/CSS/MediaThumb.css",
	"/CSS/Base/CSS/Membership.css",
	"/CSS/Base/CSS/MenuRedesign.css",
	"/CSS/Base/CSS/Message.css",
	"/CSS/Base/CSS/MyAccount.css",
	"/CSS/Base/CSS/MyItem.css",
	"/CSS/Base/CSS/MyMoney.css",
	"/CSS/Base/CSS/NewToolBox.css",
	"/CSS/Base/CSS/Parents.css",
	"/CSS/Base/CSS/party.css",
	"/CSS/Base/CSS/PersonalServerAccessPrivilegesRoleSet.css",
	"/CSS/Base/CSS/Place.css",
	"/CSS/Base/CSS/PlaceItem.css",
	"/CSS/Base/CSS/PlaceLauncher.css",
	"/CSS/Base/CSS/Profile.css",
	"/CSS/Base/CSS/RevisedCharacterSelectModal.css",
	"/CSS/Base/CSS/Sets.css",
	"/CSS/Base/CSS/ShadowedStandardBox.css",
	"/CSS/Base/CSS/ShareRoblox.css",
	"/CSS/Base/CSS/Signup.css",
	"/CSS/Base/CSS/tipsy.css",
	"/CSS/Base/CSS/Toolbox.css",
	"/CSS/Base/CSS/Trade.css",
	"/CSS/Base/CSS/UnifiedModal.css",
	"/CSS/Base/CSS/Upgrades.css",
	"/CSS/Base/CSS/Upload.css",
	"/CSS/Base/CSS/User.css",
	"/CSS/Base/CSS/Utility.css",
	"/CSS/Base/CSS/VideoPreRoll.css",
	"/CSS/Base/CSS/StyleGuide.css",
	"/CSS/RBX2/CSS/DarkGradientBox.css",
	"/CSS/RBX2/CSS/Item.css",
	"/CSS/RBX2/CSS/Roblox.css",
	"/CSS/RBX2/CSS/Utility.css"
], null));
// js:
define("JS_DEFAULT_PACKAGE", PackageCompiler::CompilePackage("master", [
	"/js/roblox.js",
	"/js/jquery.json-2.2.js",
	"/js/jquery.simplemodal-1.3.5.js",
	"/js/jquery.tipsy.js",
	"/js/AjaxAvatarThumbnail.js",
	"/js/extensions/string.js",
	"/js/StringTruncator.min.js",
	"/js/json2.min.js",
	"/js/webkit.js",
	"/js/MasterPageUI.js",
	"/js/jquery.cookie.js",
	"/js/jquery.jsoncookie.js",
	"/js/JSErrorTracker.js",
	"/js/RobloxEventManager.js",
	"/js/RobloxEventListener.js",
	"/js/SiteTouchEvent.js",
	"/js/jPlayer/2.4.0/jquery.jplayer.min.js",
	"/js/XsrfToken.js",
	"/js/jquery.ba-postmessage.min.js",
	"/js/parentFrameLogin.js",
	"/js/DropDownNav.js"
], [ // external trackers:
	"/js/GoogleAnalytics/GoogleAnalyticsEvents.js",
	"/js/GoogleEventListener.js",
	"/js/MongoEventListener.js"
]));
define("JS_SIMPLE_PACKAGE", PackageCompiler::CompilePackage("simple", [
	"/js/jquery.simplemodal-1.3.5.js",
	"/js/jquery.tipsy.js",
	"/js/json2.min.js",
	"/js/jquery.cookie.js",
	"/js/jquery.jsoncookie.js",
	"/js/DropDownNav.js",
	"/js/JSErrorTracker.js",
	"/js/RobloxEventManager.js",
	"/js/RobloxEventListener.js",
	"/js/SiteTouchEvent.js",
	"/js/GenericConfirmation.js",
], [ // external trackers:
	"/js/GoogleAnalytics/GoogleAnalyticsEvents.js",
	"/js/GoogleEventListener.js",
	"/js/MongoEventListener.js"
]));
define("JS_CHAT_PACKAGE", PackageCompiler::CompilePackage("chat", [
	"/js/jquery.cookies.2.2.0.1.js",
	"/js/blockUI.js",
	"/js/chat_v1.js",
	"/js/jquery-extensions.js",
	"/js/jPlayer/1.2.0/jquery.jplayer.min.js",
	"/js/party.js"
], null));
?>