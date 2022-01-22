<?php
// ROBLOSIUM 2013
require_once($_SERVER["STATIC"]."/settings.php");
require_once($_SERVER["STATIC"]."/authentication.php");
require_once($_SERVER["STATIC"]."/package_compiler.php");
require_once($_SERVER["STATIC"]."/friends.php");
if ($_PS->ChatEnabled)
	AddJS(JS_CHAT_PACKAGE);
// logged in stuff:
if ($userAuth !== false)
{
	if ($userAuth->GetUserInfo("membershiptype") == "OutrageousBuildersClub" && $_PS->AutomaticallyGiveOBCUsersTheme)
		$_PS->EnableOBCTheme = true;
	// last online update
	$stmt = $conn->prepare("UPDATE users SET lastonline=:time WHERE id=:id");
	$stmt->bindValue(":id", $userAuth->GetUserInfo("id"));
	$stmt->bindValue(":time", time());
	$stmt->execute();
	$friendRequestCount = (new Friends(0, $userAuth->GetUserInfo("id")))->GetCount(1); // fr count
}

// 0 = not friends, 1 = friend request sent, 2 = friends, 3 = best friends
if ($userAuth)
	$friendRequestCount = (new Friends(0, $userAuth->GetUserInfo("id")))->GetCount(1);
?>


<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml" xml:lang="en" xmlns:fb="http://www.facebook.com/2008/fbml">
<!-- MachineID: WEB1 -->
<head id="ctl00_Head1"><meta http-equiv="X-UA-Compatible" content="IE=edge,requiresActiveX=true" /><title>
	<?php echo $_PS->Title; ?>
</title>
<?php
// CSS packages
foreach($_PS->CSS as $p)
{
	foreach($p["items"] as $css)
		echo "<link rel='stylesheet' href='".$css."' />\n";
	echo "\n";
}
?>
<link rel="icon" type="image/vnd.microsoft.icon" href="/favicon.ico" /><?php echo ($_PS->UseForumCSS ? "<link rel=\"stylesheet\" href=\"/Forum/skins/default/style/default.css\" type=\"text/css\" />" : ""); ?><meta http-equiv="Content-Type" content="text/html; charset=utf-8" /><meta http-equiv="Content-Language" content="en-us" /><meta name="author" content="ROBLOX Corporation" /><meta id="ctl00_metadescription" name="description" content="User-generated MMO gaming site for kids, teens, and adults. Players architect their own worlds. Builders create free online games that simulate the real world. Create and play amazing 3D games. An online gaming cloud and distributed physics engine." /><meta id="ctl00_metakeywords" name="keywords" content="free games, online games, building games, virtual worlds, free mmo, gaming cloud, physics engine" />	<script type="text/javascript">
		<?php if ($_S->TrackersEnabled) { ?>
		var _gaq = _gaq || [];
		_gaq.push(['_setAccount', 'UA-11419793-1']);
		_gaq.push(['_setCampSourceKey', 'rbx_source']);
		_gaq.push(['_setCampMediumKey', 'rbx_medium']);
		_gaq.push(['_setCampContentKey', 'rbx_campaign']);
		_gaq.push(['_setDomainName', 'roblox.com']);

		_gaq.push(['b._setAccount', 'UA-486632-1']);
		_gaq.push(['b._setCampSourceKey', 'rbx_source']);
		_gaq.push(['b._setCampMediumKey', 'rbx_medium']);
		_gaq.push(['b._setCampContentKey', 'rbx_campaign']);
		_gaq.push(['b._setDomainName', 'roblox.com']);
		_gaq.push(['c._setAccount', 'UA-26810151-2']);
		_gaq.push(['c._setDomainName', 'roblox.com']);

		(function() {
			var ga = document.createElement('script');
			ga.type = 'text/javascript';
			ga.async = true;
			ga.src = ('https:' == document.location.protocol ? 'https://ssl' : 'http://www') + '.google-analytics.com/ga.js';
			var s = document.getElementsByTagName('script')[0];
			s.parentNode.insertBefore(ga, s);
		})();
		<?php } ?>
	</script>
<script type='text/javascript' src='//ajax.aspnetcdn.com/ajax/jQuery/jquery-1.7.2.min.js'></script>
<script type='text/javascript'>window.jQuery || document.write("<script type='text/javascript' src='/js/jquery/jquery-1.7.2.min.js'><\/script>")</script>
<script type='text/javascript' src='//ajax.aspnetcdn.com/ajax/4.0/1/MicrosoftAjax.js'></script>
<script type='text/javascript'>window.Sys || document.write("<script type='text/javascript' src='/js/Microsoft/MicrosoftAjax.js'><\/script>")</script>
<?php if ($_PS->UseJQueryUILib) { ?>
<script type='text/javascript' src='//ajax.aspnetcdn.com/ajax/jquery.ui/1.9.2/jquery-ui.min.js'></script>
<script type='text/javascript'>window.jQuery.ui || document.write("<script type='text/javascript' src='/js/jquery/jquery-ui-1.9.2.min.js'><\/script>")</script>
<?php } ?>

<?php
// JS packages
// first package has to go before other packages
if (!empty($_PS->JS))
{
	foreach($_PS->JS[0]["items"] as $js)
		echo "<script type='text/javascript' src='".$js."'></script>\n";
}
?>
<script type='text/javascript'>Roblox.config.externalResources = ['/js/jquery/jquery-1.7.2.min.js','/js/json2.min.js'];Roblox.config.paths['jQuery'] = 'https://s3.amazonaws.com/js.roblox.com/29cf397a226a92ca602cb139e9aae7d7.js';Roblox.config.paths['Pagelets.BestFriends'] = 'https://s3.amazonaws.com/js.roblox.com/c8acaba4214074ed4ad6f8b4a9647038.js';Roblox.config.paths['Pages.Catalog'] = 'https://s3.amazonaws.com/js.roblox.com/c8f61a230e6ad34193b40758f1499a3d.js';Roblox.config.paths['Pages.Messages'] = 'https://s3.amazonaws.com/js.roblox.com/34e0d4ef92076cd06d46b61bd94bc8a2.js';Roblox.config.paths['Resources.Messages'] = 'https://s3.amazonaws.com/js.roblox.com/fb9cb43a34372a004b06425a1c69c9c4.js';Roblox.config.paths['Widgets.AvatarImage'] = 'https://s3.amazonaws.com/js.roblox.com/a404577733d1b68e3056a8cd3f31614c.js';Roblox.config.paths['Widgets.DropdownMenu'] = 'https://s3.amazonaws.com/js.roblox.com/d83d02dd89808934b125fa21c362bcb9.js';Roblox.config.paths['Widgets.GroupImage'] = 'https://s3.amazonaws.com/js.roblox.com/3e692c7b60e1e28ce639184f793fdda9.js';Roblox.config.paths['Widgets.HierarchicalDropdown'] = 'https://s3.amazonaws.com/js.roblox.com/e8b579b8e31f8e7722a5d10900191fe7.js';Roblox.config.paths['Widgets.ItemImage'] = 'https://s3.amazonaws.com/js.roblox.com/6d374381f268432a466e8b8583414b49.js';Roblox.config.paths['Widgets.PlaceImage'] = 'https://s3.amazonaws.com/js.roblox.com/08e1942c5b0ef78773b03f02bffec494.js';Roblox.config.paths['Widgets.Suggestions'] = 'https://s3.amazonaws.com/js.roblox.com/a63d457706dfbc230cf66a9674a1ca8b.js';Roblox.config.paths['Widgets.SurveyModal'] = 'https://s3.amazonaws.com/js.roblox.com/d6e979598c460090eafb6d38231159f6.js';</script><script type="text/javascript">
    $(function () {
        Roblox.JSErrorTracker.initialize({'internalEventListenerPixelEnabled': true});
    });
</script>
<?php
foreach($_PS->JS as $k => $p)
{
	if ($k != 0)
	{
		foreach($p["items"] as $js)
			echo "<script type='text/javascript' src='".$js."'></script>\n";
		echo "\n";
	}
}
if ($_PS->HeaderTipsy) { ?>
	<script type="text/javascript">
	    $(function () {
	        $('.tooltip').tipsy();
	        $('.tooltip-top').tipsy({ gravity: 's' });
	        $('.tooltip-right').tipsy({ gravity: 'w' });
	        $('.tooltip-left').tipsy({ gravity: 'e' });
	        $('.tooltip-bottom').tipsy({ gravity: 'n' });
	        $('.tooltip-right-html').tipsy({ gravity: 'w', html: true, delayOut: 1000 });
	        $('.tooltip-left-html').tipsy({ gravity: 'e', html: true, delayOut: 1000 });
	    });
    </script>
<?php } ?>
</head>
<body>

    <script type="text/javascript">Roblox.XsrfToken.setToken('');</script>
 
    <script type="text/javascript">
        if (top.location != self.location) {
            top.location = self.location.href;
        }
    </script>
  
<style type="text/css">
    <style type="text/css">
</style>
<?php
if ($_PS->EnableOBCTheme)
{ ?>
<style type="text/css">
    <style type="text/css">
        
            html {
                background: none;
            }
            .site-header { 
                background:url(http://images.rbxcdn.com/225cbfb387f1d0309fd46c9bee52b979.png);
              }
              #navigation-container a.btn-logo,#navigation-container a.btn-logo:visited {
                background:url(http://images.rbxcdn.com/ef92ea9a7745b7e31c22e4c6c52e8ef6.png);
              }
              #navigation-container a.btn-logo:hover { background:url(http://images.rbxcdn.com/ef92ea9a7745b7e31c22e4c6c52e8ef6.png);
                background-position:0 -35px;
              }
              #navigation-container .HeaderDivider {
                border-left: 1px solid #878988;
              }
              body {
                background: url(http://images.rbxcdn.com/e208d803544730688da1791aab218da9.jpg) top center repeat-x black; 
              }
              #Footer.LanguageRedesign {
                color:#555;
                background: none;
              }
              #Footer.LanguageRedesign div.legal { 
                border-color:white;
              } 
              #Footer.LanguageRedesign p.Legalese {
                color: #555;
              }
        
</style>
<?php }
// holiday css!
switch ($_S->HolidayType)
{
	case HOLIDAY_HALLOWEEN:
		echo '<link rel="Stylesheet" href="/CSS/Themes/Halloween2013/Halloween2013.css" />';
		break;
	case HOLIDAY_THANKSGIVING:
		echo '<link rel="Stylesheet" href="/CSS/Themes/Thanksgiving2013/Thanksgiving2013.css" />';
		break;
	case HOLIDAY_CHRISTMAS:
		echo '<link rel="Stylesheet" href="/CSS/Themes/Holiday2013/Holiday2013.css" />';
		break;
}
?>

</style>
<?php if ($_PS->ASPNetFormTagEnabled) { ?>
<form name="aspnetForm" method="post" action="<?php echo $_SERVER["REQUEST_URI"]; ?>" id="aspnetForm">
<div>
<input type="hidden" name="__VIEWSTATE" id="__VIEWSTATE" value="/" />
</div>


<script src="/ScriptResource.axd?d=-ewL1UA2ciP6OBToUKCtI5US41-xb7NlFijIvSRh0KoWxDJY17-_EyhRTvWww-_SbtB_99EcNujDw9mFgcPnOkqfKj6WRTBXvISqWl2Z2e-557kVTvHelILClKDV85MZfPlREptCzZjBLopFMsNu4E8Rfi7j7iT-iiQLniVvhbaivs9kHF166OiaYMPDE8vRnisyRqwGM_EPxddqiuipD6ENKbKsoD3RD1_XvC-FMrzgd9ezo0nCiOmAmbf3fiDx3PNVc10cNMCipDl9GAl0phlFpHO7UXleobTkLuvzahpn7j9s3JhzCKAVKp_P7sTj_OzRbaBwkjgAZWmNRSRYtDmlPwRxRaBjiEJWAqCls0zQbTIL7uvs16n8K-MdrO9w0M6XyJWcJk_aJr4QyHiEktzyBIp5lnno4HcuUSV65z5-Zf3hGwL4CWUSoiBLoJe-yURtBg2" type="text/javascript"></script>
<div>
	<input type="hidden" name="__EVENTTARGET" id="__EVENTTARGET" value="" />
	<input type="hidden" name="__EVENTARGUMENT" id="__EVENTARGUMENT" value="" />
	<input type="hidden" name="__EVENTVALIDATION" id="__EVENTVALIDATION" value="/" />
</div>
<script type="text/javascript">
//<![CDATA[
var theForm = document.forms['aspnetForm'];
if (!theForm) {
    theForm = document.aspnetForm;
}
function __doPostBack(eventTarget, eventArgument) {
    if (!theForm.onsubmit || (theForm.onsubmit() != false)) {
        theForm.__EVENTTARGET.value = eventTarget;
        theForm.__EVENTARGUMENT.value = eventArgument;
        theForm.submit();
    }
}
//]]>
</script>
<?php } ?>
    <div id="fb-root">
    </div>
    
    
         
    

    <div id="MasterContainer">
                   


<script type="text/javascript">
$(function(){
    function trackReturns() {
	    function dayDiff(d1, d2) {
		    return Math.floor((d1-d2)/86400000);
	    }

	    var cookieName = 'RBXReturn';
	    var cookieOptions = {expires:9001};
        var cookie = $.getJSONCookie(cookieName);

	    if (typeof cookie.ts === "undefined" || isNaN(new Date(cookie.ts))) {
	        $.setJSONCookie(cookieName, { ts: new Date().toDateString() }, cookieOptions);
		    return;
	    }

	    var daysSinceFirstVisit = dayDiff(new Date(), new Date(cookie.ts));
	    if (daysSinceFirstVisit == 1 && typeof cookie.odr === "undefined") {
		    RobloxEventManager.triggerEvent('rbx_evt_odr', {});
		    cookie.odr = 1;
	    }
	    if (daysSinceFirstVisit >= 1 && daysSinceFirstVisit <= 7 && typeof cookie.sdr === "undefined") {
		    RobloxEventManager.triggerEvent('rbx_evt_sdr', {});
		    cookie.sdr = 1;
	    }
	
	    $.setJSONCookie(cookieName, cookie, cookieOptions);
    }

    
        RobloxListener.restUrl = window.location.protocol + "//" + "roblox.com/Game/EventTracker.ashx";
        RobloxListener.init();
    
    <?php if($_S->TrackersEnabled)
        echo "GoogleListener.init()"; ?> 
    
    
    
    
        RobloxEventManager.initialize(true);
        RobloxEventManager.triggerEvent('rbx_evt_pageview');
        trackReturns();
    
    
    
        RobloxEventManager._idleInterval = 450000;
        RobloxEventManager.registerCookieStoreEvent('rbx_evt_initial_install_start');
        RobloxEventManager.registerCookieStoreEvent('rbx_evt_ftp');
        RobloxEventManager.registerCookieStoreEvent('rbx_evt_initial_install_success');
        RobloxEventManager.registerCookieStoreEvent('rbx_evt_fmp');
        RobloxEventManager.startMonitor();
    

});

</script>


        

        <script type="text/javascript">Roblox.FixedUI.gutterAdsEnabled=false;</script>
        

        <div id="Container">
            
                
                                                            
<div class="site-header" >
    <div id="navigation-container">
        <a href="/Default.aspx" class="btn-logo" data-se="nav-logo"></a>
		<?php if ($_PS->NavigationOptions) { ?>
        <div id="navigation-menu">
            <ul>
                <li><a href="/home" ref="nav-myroblox" data-se="nav-myhome">Home</a></li>
                <li><a data-se="nav-games" href="/games" ref="nav-games" title="Games">Games</a> </li>
                <li><a data-se="nav-catalog" href="/Catalog" ref="nav-catalog" title="Catalog">Catalog</a></li>
                
                    <li><a data-se="nav-develop" href="/develop" title="Develop" ref="nav-develop">Develop</a></li>
                
                <li><a data-se="nav-upgrade" href="/Upgrades/BuildersClubMemberships.aspx" title="Upgrade" ref="nav-buildersclub">Upgrade</a></li>
                <li><a data-se="nav-forum" onclick=''  href="/Forum/Default.aspx" style='' title="Forum" ref="nav-forum">Forum</a></li>
                <li class="more-list-item" drop-down-nav-button="more-list-item">
                    <div class="more-link-container">
                        <a id="nav-more" title="More" data-se="nav-more" ref="nav-more">More<span id="more-menu-toggle" ></span></a> 
                    </div>
                    <div class="dropdownnavcontainer" style="display:none;" drop-down-nav-container="more-list-item">
                        <div class="dropdownmainnav" style="z-index:1023">
                            <a class="dropdownoption" data-se="nav-more-browse" href="/Browse.aspx" title="People" ref="nav-people"><span>People</span></a>
                            <a class="dropdownoption roblox-interstitial" data-se="nav-more-blog" href="http://blog.roblox.com" title="Blog" ref="nav-news"><span>Blog</span></a>
                                   <a class="dropdownoption" data-se="nav-more-sponsoredpage" href="/event/halloween" title="halloween" ref="nav-sponsoredpage">
                                       <span style="display:block;">
                                          <img src="https://s3.amazonaws.com/images.roblox.com/44cec51462e43a3de2bca5cd99df89e1" />
                                       </span>
                                   </a>
                            <a class="dropdownoption" data-se="nav-more-help" href="/Help/Builderman.aspx" title="Help" ref="nav-help"><span>Help</span></a>
                            <div style="clear:both;"></div>
                        </div>
                    </div>
                </li>
            </ul>
        </div>
		<?php if ($userAuth !== false) { ?>
<div id="AlertSpace">
    <div class="AlertItem" style="max-width: 50px;text-align:center;">
        <a id="lsLoginStatus" data-se="nav-logout" class="logoutButton">Logout</a>
    </div>
    <div class="HeaderDivider"></div>
    
    <a data-se="nav-tickets" href="/My/Money.aspx?tab=MyTransactions">
    <div id="TicketsWrapper" class="TicketsAlert AlertItem tooltip-bottom" title="Tickets">
        <div class="icons tickets_icon">
        </div>
        <div id="TicketsAlertCaption" class="AlertCaption"><?php echo number_format($userAuth->GetUserInfo("tickets")); ?></div>
    </div>
    </a>

    <a data-se="nav-robux" href="/My/Money.aspx?tab=MyTransactions">
    <div id="RobuxWrapper" class="RobuxAlert AlertItem tooltip-bottom"title="Robux" >
        <div class="icons robux_icon">
        </div>
        <div id="RobuxAlertCaption" class="AlertCaption" ><?php echo number_format($userAuth->GetUserInfo("robux")); ?></div>
    </div>
    </a>

    <div class="HeaderDivider"></div>
    
    <a data-se="nav-friends" href="/My/EditFriends.aspx" >
    <span id="FriendsTextWrapper" class="FriendsAlert AlertItem tooltip-bottom"  title="<?php echo ($friendRequestCount > 0) ? $friendRequestCount . " " : ""; ?>Friend Requests">
		<?php if($friendRequestCount > 0) { ?>
		<div id="FriendsBubble" class="AlertTextWrapper" runat="server">
			<div class="AlertBox Left" style=""></div>
			<div class="AlertBox Right" style="background-position:right; padding-right:3px; ">
			<div class="AlertText"><?php echo $friendRequestCount; ?></div>
			</div>
		</div>
		<?php } ?>
        <div class="icons friends_icon" style="float:none;">
        </div>    
    </span>
    </a>

    <a data-se="nav-messages" href="/my/messages">
    <span id="MessagesTextWrapper" class="MessageAlert AlertItem tooltip-bottom" title="Messages">
        <div class="icons message_icon" style="float:none;">
        </div>
    </span>
    </a>
    <a data-se="nav-login" href="/User.aspx">
        <div id="AuthenticatedUserNameWrapper">
            <div id="AuthenticatedUserName">
                
                <span class="login-span notranslate">
					<img id="over13icon" src="https://images.rbxcdn.com/8ed6b064a35786706f738c0858345c11.png" alt="" style="vertical-align:middle;padding-right:5px;padding-left:0px;" original-title="This is a 13+ account.">
                    <?php echo $userAuth->GetUserInfo("username"); ?>
                </span>
            </div>
        </div> 

    </a>

    <script type="text/javascript">
        ;$(function () {
            $('#over13icon').tipsy({ gravity: 'n' });

            $("#lsLoginStatus").click(
                    function () {
                        var form = $(this).closest('form');
                        if (form.length == 0) {
                            form = $("<form></form>").appendTo("body");
                        }
                        form.attr('action', '/authentication/logout');
                        form.attr('method', 'post');
                        form.submit();
                    }
                );
        });

    </script> 
</div>
		<?php } else { ?>
                <div id="header-login-container">
                    <div id="header-login-wrapper" class="iframe-login-signup" data-display-opened="">
                        <a id="header-signup" href="/Login/NewAge.aspx">Sign Up</a>
                        <span id="header-or">or</span>
                        <span id="login-span">
                            <a id="header-login" class="btn-control btn-control-large">Login <span class="grey-arrow">▼</span></a>
                        </span>
                        <div id="iFrameLogin"  style="display:none">
                            <iframe class="login-frame" src="http://<?php echo $_SERVER["HTTP_HOST"]; ?>/Login/iFrameLogin.aspx?loginRedirect=False&amp;parentUrl=<?php echo urlencode("http://".$_SERVER["HTTP_HOST"].$_SERVER["REQUEST_URI"]); ?>" scrolling="no" frameborder="0"></iframe>
                        </div>
                    </div>
                </div>
		<?php } } ?>
    </div>
</div>
<script type="text/javascript">
    $(function () {
        $('.more-list-item').bind('showDropDown', function () {
            var maxWidth = $('#navigation-menu .dropdownnavcontainer').width();
            $('a.dropdownoption span').each(function (index, elem) {
                elem = $(elem);
                if (elem.outerWidth() > maxWidth) {
                    maxWidth = elem.outerWidth();
                }
            });
            maxWidth = maxWidth + 5;
            $('#navigation-menu .dropdownoption').each(function (index, elem) {
                elem = $(elem);
                if (elem.width() < maxWidth) {
                    elem.width(maxWidth);
                }
            });
        });
    });
    
    
</script>

        </div>

        
            
<?php if ($_PS->SubmenuEnabled) { ?>
<div class="mySubmenuFixed Redesign">
    <div id="subMenu" class="subMenu">
        <ul>
            <li><a data-se="subnav-profile" href="http://<?php echo $_SERVER['SERVER_NAME']; ?>/User.aspx?submenu=true">Profile</a></li>
            <li><a data-se="subnav-character" href="http://<?php echo $_SERVER['SERVER_NAME']; ?>/My/Character.aspx">Character</a></li>
            <li><a data-se="subnav-friends" href="http://<?php echo $_SERVER['SERVER_NAME']; ?>/My/EditFriends.aspx">Friends</a></li>
            <li><a data-se="subnav-groups" href="http://<?php echo $_SERVER['SERVER_NAME']; ?>/My/Groups.aspx">Groups</a></li>
            <li><a data-se="subnav-inventory" href="http://<?php echo $_SERVER['SERVER_NAME']; ?>/My/Stuff.aspx">Inventory</a></li>
                <li><a data-se="subnav-sets" href="http://<?php echo $_SERVER['SERVER_NAME']; ?>/My/Sets.aspx">Sets</a></li>
            <li><a data-se="subnav-trade" href="http://<?php echo $_SERVER['SERVER_NAME']; ?>/My/Money.aspx?tab=TradeItems">Trade</a></li>
            <li><a data-se="subnav-money" href="http://<?php echo $_SERVER['SERVER_NAME']; ?>/My/Money.aspx?tab=MyTransactions">Money</a></li>
            <li><a data-se="subnav-advertising" href="http://<?php echo $_SERVER['SERVER_NAME']; ?>/develop?Page=ads">Advertising</a></li>
            <li><a data-se="subnav-account" href="http://<?php echo $_SERVER['SERVER_NAME']; ?>/My/Account.aspx">Account</a></li>
        </ul>
    </div>
</div>
<div class="forceSpaceUnderSubmenu">&nbsp;</div> 
<?php } ?>
        <div class="forceSpace">&nbsp;</div>
            <?php if($_PS->HeaderAds) { ?>
            <div id="AdvertisingLeaderboard">
                
            <iframe
    allowtransparency="true"
    frameborder="0"
    height="110"
    scrolling="no"
    src="/userads/1"
    width="828"
    data-js-adtype="iframead"></iframe>
			<?php } ?>
            </div>
        

        <noscript><div class="SystemAlert"><div class="SystemAlertText">Please enable Javascript to use all the features on this site.</div></div></noscript>