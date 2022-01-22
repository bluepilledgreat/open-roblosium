<?php
// ROBLOSIUM 2013
require_once($_SERVER["STATIC"]."/connection.php");
require_once($_SERVER["STATIC"]."/settings.php");
require_once($_SERVER["STATIC"]."/package_compiler.php");
require_once($_SERVER["STATIC"]."/authentication.php");
require_once($_SERVER["STATIC"]."/profanity_filter.php");
require_once($_SERVER["STATIC"]."/friends.php");
// POST REQUESTS
/// STATUS MESSAGE CHANGE
if (isset($_POST['ctl00$cphRoblox$rbxHeaderPane$txtStatusMessage']) && $userAuth !== false)
{
	$stmt = $conn->prepare("INSERT INTO statuses (uid, status, date) VALUES (:uid, :status, :date)");
	$stmt->bindValue(":uid", $userAuth->GetUserInfo("id"));
	$stmt->bindValue(":status", ProfanityFilter::Censor($_POST['ctl00$cphRoblox$rbxHeaderPane$txtStatusMessage']));
	$stmt->bindValue(":date", time());
	$stmt->execute();
}
// FRONTEND:
AddCSS(CSS_DEFAULT_PACKAGE);
AddCSS(PackageCompiler::CompilePackage("page", ["/CSS/Pages/RobloxUI.css", "/CSS/PartialViews/Navigation.css", "/CSS/Base/CSS/AdFormatClasses.css"], null));
AddJS(JS_DEFAULT_PACKAGE);
AddJS(PackageCompiler::CompilePackage("page", ["/js/jquery.simplemodal-1.3.5.js", "/js/GenericModal.js", "/js/DataPager.js", "/js/Sets/SetsPane.js", "/js/extensions/string.js", "/js/accordion.js", "/js/UserPlacesPane.js", "/js/ItemPurchase.js", "/js/modules/Widgets/ItemImage.js", "/js/UserAssetsPane.js", "/js/CreateSetPanel.js", "/js/GenericConfirmation.js"], ["/js/GPTAdScript.js"]));
// VARIABLES:
$_GET = array_change_key_case($_GET, CASE_LOWER); // fix case sensitivity
$id = (isset($_GET["id"]) ? (int)$_GET["id"] : ($userAuth !== false ? $userAuth->GetUserInfo("id") : 0));
$publicView = !($userAuth && $userAuth->GetUserInfo("id") == $id && (!isset($_GET["forcepublicview"]) || $_GET["forcepublicview"] == "false"));
// SETTINGS
$_PS->UseJQueryUILib = true;
$_PS->SubmenuEnabled = $userAuth !== false;
/// GET USER'S INFO
$uinfo = null;
if ($userAuth !== false && $id == $userAuth->GetUserInfo("id"))
{
	$uinfo = $userAuth->GetAllUserInfo();
}
else
{
	$uinfo = (new UserAuthentication($id))->Fix();
	if ($uinfo === false)
		die("invalid user"); // proper error page please
	$uinfo = $uinfo->GetAllUserInfo();
}
$_PS->Title = $uinfo->username." - ROBLOX";
$status = $uinfo->status;
// DETERMINE CORRECT ICON FOR USER + IF TO ENABLE OBC THEME
$icon = null;
switch ($uinfo->membershiptype)
{
	case "BuildersClub":
		$icon = "overlay_bcOnly.png";
		break;
	case "TurboBuildersClub":
		$icon = "overlay_tbcOnly.png";
		break;
	case "OutrageousBuildersClub":
		$icon = "overlay_obcOnly.png";
		$_PS->EnableOBCTheme = true;
		break;
}
// FRIENDS
if($userAuth)
{
	$Friends = new Friends($userAuth->GetUserInfo("id"), $uinfo->id);
	$friendStatus = $Friends->GetStatus($userAuth->GetUserInfo("id"));
	
	// check if unfriended
	if(isset($_POST['__EVENTTARGET']) && $_POST['__EVENTTARGET'] == 'ctl00$cphRoblox$rbxUserPane$rbxPublicUser$ctl02' && $Friends->GetStatus())
	{
		$Friends->RevokeFriend();
		$friendStatus = 0;
	}
}
else
{
	$Friends = new Friends(0, $uinfo->id);
	$friendStatus = 0;
}

// 0 = not friends, 1 = friend request sent, 2 = friends, 3 = best friends
$friendCount = $Friends->GetCount(2, true);
$online = isTimeConsideredOnline($uinfo->lastonline);

// HEADER
require_once($_SERVER["STATIC"]."/header.php");
?>
        <div id="BodyWrapper">
            <div id="RepositionBody"><div id="Body" style='width:970px;'>
                
    <style type="text/css">
        #Body {
            padding: 10px;
        }
    </style>
    <div>
        
<div style="width:900px;height:30px;clear:both; display:none;">
    <span id="ctl00_cphRoblox_rbxHeaderPane_nameRegion" style="font-size:20px; font-weight:bold;"><?php echo (!$publicView ? "Hi, " : "").$uinfo->username; ?></span>
</div>


<?php if ($friendStatus >= 2 && !empty($status) || !$publicView) { ?>
<div id="ctl00_cphRoblox_rbxHeaderPane_statusBox" class="blank-box" style="width:951px; padding: 8px;word-wrap: break-word;display:block;">
        <span style="font-size:12px;color: #888;word-wrap: normal;">
        Right now I'm: 
        </span> &nbsp;&nbsp;
        
        <span id="ctl00_cphRoblox_rbxHeaderPane_statusRegion" style="font-size:14px;" class="notranslate"><i>"<?php echo htmlspecialchars($status); ?>"</i></span>&nbsp;&nbsp;
<?php if (!$publicView) { ?>        
        <a href="UserControls/#" id="ctl00_cphRoblox_rbxHeaderPane_updateStatusLink" style="font-size:14px;word-wrap:normal;display:block;" onclick="document.getElementById(&#39;updateStatusBox&#39;).style.display=&#39;block&#39;;document.getElementById(&#39;ctl00_cphRoblox_rbxHeaderPane_updateStatusLink&#39;).style.display=&#39;none&#39;; return false;">> Update My Status</a>
        
        <div id="updateStatusBox" style="display:none;">
            <input type="text" style="visibility:hidden;position:absolute">
            <span style="position:relative">
                
                <input name="ctl00$cphRoblox$rbxHeaderPane$txtStatusMessage" type="text" id="ctl00_cphRoblox_rbxHeaderPane_txtStatusMessage" style="margin-bottom:5px;width:560px;height:17px;" maxlength="254" value="<?php echo htmlspecialchars($status); ?>" />&nbsp;&nbsp;
            </span>    
            
        
            <input type="submit" name="ctl00$cphRoblox$rbxHeaderPane$btnUpdateStatus" value="Save" onclick="javascript:WebForm_DoPostBackWithOptions(new WebForm_PostBackOptions(&quot;ctl00$cphRoblox$rbxHeaderPane$btnUpdateStatus&quot;, &quot;&quot;, true, &quot;&quot;, &quot;&quot;, false, false))" id="ctl00_cphRoblox_rbxHeaderPane_btnUpdateStatus" class="translate" />&nbsp<input type="button" value="Cancel" onclick="document.getElementById('updateStatusBox').style.display='none';document.getElementById('ctl00_cphRoblox_rbxHeaderPane_updateStatusLink').style.display='inline';"<br />
        </div>
<?php } else { ?>
        <div id="ctl00_cphRoblox_rbxHeaderPane_ReportAbuse_AbuseReportPanel" class="ReportAbuse">
	
    <span class="AbuseIcon"><a id="ctl00_cphRoblox_rbxHeaderPane_ReportAbuse_ReportAbuseIconHyperLink" href="abuseReport/userprofile?id=54554575&amp;RedirectUrl=http%3a%2f%2fweb.roblox.com%2fuser.aspx%3fid%3d54554575"><img src="images/abuse.PNG?v=2" alt="Report Abuse" style="border-width:0px;" /></a></span>
    <span class="AbuseButton"><a id="ctl00_cphRoblox_rbxHeaderPane_ReportAbuse_ReportAbuseTextHyperLink" href="abuseReport/userprofile?id=54554575&amp;RedirectUrl=http%3a%2f%2fweb.roblox.com%2fuser.aspx%3fid%3d54554575">Report Abuse</a></span>
</div>
<?php } ?>
</div>
<?php } ?>

        <?php if ($publicView && $uinfo->membershiptype == "OutrageousBuildersClub" && !$friendStatus) { ?>
        <div id="ctl00_cphRoblox_OBCmember" class="blank-box" style="margin-top: 10px; width: 951px; float: left; padding: 8px">
            <div style="float: left; margin-right: 10px;">
                <img src=http://images.rbxcdn.com/9cb3b66f03c1129835cc9f78d6e4c423.png border="0" alt="OBC" title="OBC member" /></div>
            <div style="float: left; line-height: 30px;">
                You are viewing the profile of an <a href="Upgrades/BuildersClubMemberships.aspx">Outrageous Builders
                    Club</a> member.</div>
        </div>
		<?php } ?>
        <div style="clear: both; margin: 0; padding: 0;">
        </div>
        <!--[if IE 6]>
      <table><tr><td width="450px" valign="top">
      <![endif]-->
        <div class="divider-right" style="width: 484px; float: left">
            

<h2 class="title">
    <span id="ctl00_cphRoblox_rbxUserPane_lUserRobloxURL"><?php echo ($publicView ? $uinfo->username."'s Profile" : "Your Profile"); ?></span></h2>
<div class="divider-bottom" style="position: relative;z-index:3;padding-bottom: 20px">
    <div style="width: 100%">
	<?php if ($publicView) { ?>
        <div id="ctl00_cphRoblox_rbxUserPane_onlineStatusRow">
            <div style="text-align: center;">
                
                <span id="ctl00_cphRoblox_rbxUserPane_lUserOnlineStatus" class="User<?php echo $online ? "Online" : "Offline"; ?>Message">[ <?php echo $online ? "Online: Website" : "Offline"; ?> ]</span>
                
            </div>
        </div>
	<?php } ?>
        <div>
            <div>
                <center>
                    <div style="margin-bottom: 10px;">
                        <?php if (!$publicView) { ?>
                        <div id="ctl00_cphRoblox_rbxUserPane_pnlViewPublic" style="font-size: 13px;">
                            <a href="User.aspx?ID=<?php echo $uinfo->id; ?>&ForcePublicView=true" id="ctl00_cphRoblox_rbxUserPane_lnkPublicView">(View Public Profile)</a>
                        </div>
						<?php } ?>
                    </div>
                    <a id="ctl00_cphRoblox_rbxUserPane_AvatarImage" disabled="disabled" class=" notranslate" title="<?php echo $uinfo->username; ?>" class=" notranslate" onclick="return false" style="display:inline-block;height:200px;width:150px;"><img src="/images/boy_guest.png" height="200" width="150" border="0" onerror="return Roblox.Controls.Image.OnError(this)" alt="<?php echo $uinfo->username; ?>" class=" notranslate" /><?php if ($icon != null) echo '<img src="/images/icons/'.$icon.'" align="left" style="position:relative;top:-19px;" />'; ?></a>
                    <br />
                    <!--<div id="ctl00_cphRoblox_rbxUserPane_PrimaryGroupContainer" style="margin-top:10px;font-size:10px">
                        <div>
                            <b>Primary Group:</b>
                            <br />
                            <a id="ctl00_cphRoblox_rbxUserPane_PrimaryGroupAssetImage" title="Nightfall Clan " href="/groups/group.aspx?gid=85654" style="display:inline-block;height:42px;width:42px;cursor:pointer;"><img src="http://t2.rbxcdn.com/91370de137b1964e4c702c049d00e8f3" height="42" width="42" border="0" onerror="return Roblox.Controls.Image.OnError(this)" alt="Nightfall Clan " /></a>
                            <br />
                            <a id="ctl00_cphRoblox_rbxUserPane_HyperLink1" href="groups/group.aspx?gid=85654">Nightfall Clan </a>
                        </div>
                    </div>-->
                    
<?php if ($publicView) { ?>
<div class="UserBlurb" style="margin-top: 10px; overflow-y: auto; max-height: 450px; ">
    <?php echo str_replace(array("\r\n", "\r", "\n"), "<br />", htmlspecialchars($uinfo->bio)); ?>
</div>
<div id="ProfileButtons" style="margin:10px auto;">
    
			<?php
			if($friendStatus === 2) 
			{ ?>
			<div id="FriendButton" class="GrayDropdown">
				<div class="Button">Friend Options</div>
				<div class="Menu" style="width: 130px; display: none;">
					<a class="Item" href="javascript:WebForm_DoPostBackWithOptions(new WebForm_PostBackOptions(&quot;ctl00$cphRoblox$rbxUserPane$rbxPublicUser$ctl00&quot;, &quot;&quot;, true, &quot;&quot;, &quot;&quot;, false, true))">Make Best Friend</a>
					<a class="Item" href="javascript:WebForm_DoPostBackWithOptions(new WebForm_PostBackOptions(&quot;ctl00$cphRoblox$rbxUserPane$rbxPublicUser$ctl02&quot;, &quot;&quot;, true, &quot;&quot;, &quot;&quot;, false, true))">Unfriend</a>
				</div>
			</div>
			<?php } else if($friendStatus === 3) 
			{ ?>
			<div id="FriendButton" class="GrayDropdown">
				<div class="Button">Friend Options</div>
				<div class="Menu" style="width: 130px; display: none;">
					<a class="Item" href="javascript:WebForm_DoPostBackWithOptions(new WebForm_PostBackOptions(&quot;ctl01$cphRoblox$rbxUserPane$rbxPublicUser$ctl01&quot;, &quot;&quot;, true, &quot;&quot;, &quot;&quot;, false, true))">Remove Best Friend</a>
					<a class="Item" href="javascript:WebForm_DoPostBackWithOptions(new WebForm_PostBackOptions(&quot;ctl00$cphRoblox$rbxUserPane$rbxPublicUser$ctl02&quot;, &quot;&quot;, true, &quot;&quot;, &quot;&quot;, false, true))">Unfriend</a>
				</div>
			</div>
			<?php } else { ?>
			<a id="FriendButton" data-target-user-id="<?php echo $uinfo->id; ?>" class="GrayButton <?php echo ($userAuth === false || $userAuth->GetUserInfo("id") == $uinfo->id || $friendStatus === 1) ? "Disabled" : "friend-request-button"; ?>"><?php echo $friendStatus === 1 ? "Friend Request Pending" : "Send Friend Request"; ?></a>
			<?php } ?>
			
    <div class="SendMessageProfileBtnDiv">
        
        <a  id="MessageButton" style="margin:0 5px" class="GrayButton "  href="/My/PrivateMessage.aspx?RecipientID=<?php echo $uinfo->id; ?>">Send Message</a>
    </div>
	
    <div class="clear"></div>
    <script type="text/javascript">
        function hideDropdowns() {
            $('.GrayDropdown .Button.Active').removeClass('Active').siblings('.Menu').hide();
        }

        $('#ProfileButtons').width($('#FriendButton').outerWidth() + $('#MessageButton').outerWidth() + $('#MoreButton').outerWidth() + 11); // + 10
        $('.GrayDropdown .Button').click(function () {
            var show = !$(this).hasClass('Active');
            hideDropdowns();
            if (show) {
                $(this).addClass('Active').siblings('.Menu').show();
            }

            return false;
        });
        $(document).click(function () {
            hideDropdowns();
        });
        $('#MoreButton [original-title]').tipsy();
        var friendRequestButton = $(".friend-request-button");
        
            friendRequestButton.click(function () {<?php if ($userAuth === false) echo 'window.location = "/Login/Signup.aspx";'; else { ?>
                if (!friendRequestButton.hasClass("Disabled")) {
                    var data = {
                        targetUserID: $(this).attr("data-target-user-id")
                    };
                    $.post("/friends/sendfriendrequest", data, function() {
                        friendRequestButton.addClass("Disabled");
                        friendRequestButton.text("Friend Request Pending");
                        $('#ProfileButtons').width($('#FriendButton').outerWidth() + $('#MessageButton').outerWidth() + $('#MoreButton').outerWidth() + 11); // 10
                    });
                }
			<?php } ?>
			});
        
		
    </script>
</div>
<?php } else echo "<br />"; ?>

                    <div class="ProfileAlertPanel" style='<?php echo ($publicView ? "display: none;" : ""); ?> margin: 15px auto 0px auto; width: 205px;'>
                        <?php if (!$publicView) { ?>
                        <div id="ctl00_cphRoblox_rbxUserPane_Alerts1_AlertSpacePanel">
	
    <div class="SmallHeaderAlertSpaceLeft">
        <div class="AlertSpace">
            <div class="MessageAlert">
                <a id="ctl00_cphRoblox_rbxUserPane_Alerts1_MessageAlertCaptionHyperLink" class="MessageAlertCaption tooltip-bottom" title="Inbox" href="/my/messages">0</a>
            </div>
            <div class="FriendsAlert">
                <a id="ctl00_cphRoblox_rbxUserPane_Alerts1_FriendsAlertCaptionHyperLink" class="FriendsAlertCaption tooltip-bottom" title="Friend Requests" href="Friends.aspx"><?php echo number_format($Friends->GetCount(1)); ?></a>
            </div>
            <div class="RobuxAlert">
                <a id="ctl00_cphRoblox_rbxUserPane_Alerts1_RobuxAlertCaptionHyperLink" class="RobuxAlertCaption tooltip-bottom" title="ROBUX" href="My/Money.aspx?tab=MyTransactions"><?php echo number_format($uinfo->robux); ?></a>
            </div>
            <div class="TicketsAlert">
                <a id="ctl00_cphRoblox_rbxUserPane_Alerts1_TicketsAlertCaptionHyperLink" class="TicketsAlertCaption tooltip-bottom" title="Tickets" href="My/Money.aspx?tab=MyTransactions"><?php echo number_format($uinfo->tickets); ?></a>
            </div>
        </div>
    </div>

</div>

						<?php } ?>
                        <br />
                    </div>
                    <div style="margin-right: 20px">
                        
                    </div>
                    
                    
                </center>
            </div>
        </div>
    </div>
</div>

            


<h2 class="title">
<span>ROBLOX Badges</span>
</h2>

<div class="divider-bottom" style="padding-bottom: 20px">
    <div style="display: inline-block">
	    <table id="ctl00_cphRoblox_rbxUserBadgesPane_dlBadges" cellspacing="0" align="Left" border="0" style="border-collapse:collapse;">
	<tr>
		<td>
			    <div class="Badge" class="notranslate">
				    <div class="BadgeImage"><a id="ctl00_cphRoblox_rbxUserBadgesPane_dlBadges_ctl00_hlHeader" href="Badges.aspx#Badge3"><img id="ctl00_cphRoblox_rbxUserBadgesPane_dlBadges_ctl00_iBadge" src="http://images.rbxcdn.com/d111059fca163b9824716cff2fe4aec5.png" alt="This badge is given to any player who has proven his or her combat abilities by accumulating 10 victories in battle. Players who have this badge are not complete newbies and probably know how to handle their weapons." style="height:75px;width:75px;border-width:0px;" /></a></div>
				    <div class="BadgeLabel"><a id="ctl00_cphRoblox_rbxUserBadgesPane_dlBadges_ctl00_HyperLink1" href="Badges.aspx#Badge3">Combat Initiation</a></div>
			    </div>
		    </td><td>
			    <div class="Badge" class="notranslate">
				    <div class="BadgeImage"><a id="ctl00_cphRoblox_rbxUserBadgesPane_dlBadges_ctl01_hlHeader" href="Badges.aspx#Badge4"><img id="ctl00_cphRoblox_rbxUserBadgesPane_dlBadges_ctl01_iBadge" src="http://images.rbxcdn.com/14652f1598ba5520515965b4038214c0.png" alt="This badge is given to the warriors of Robloxia, who have time and time again overwhelmed their foes in battle. To earn this badge, you must rack up 100 knockouts. Anyone with this badge knows what to do in a fight!" style="height:75px;width:75px;border-width:0px;" /></a></div>
				    <div class="BadgeLabel"><a id="ctl00_cphRoblox_rbxUserBadgesPane_dlBadges_ctl01_HyperLink1" href="Badges.aspx#Badge4">Warrior</a></div>
			    </div>
		    </td><td>
			    <div class="Badge" class="notranslate">
				    <div class="BadgeImage"><a id="ctl00_cphRoblox_rbxUserBadgesPane_dlBadges_ctl02_hlHeader" href="Badges.aspx#Badge2"><img id="ctl00_cphRoblox_rbxUserBadgesPane_dlBadges_ctl02_iBadge" src="http://images.rbxcdn.com/46c15f2030a8c68ab1ff4329765e515a.png" alt="This badge is given to players who have embraced the Roblox community and have made at least 20 friends. People who have this badge are good people to know and can probably help you out if you are having trouble." style="height:75px;width:75px;border-width:0px;" /></a></div>
				    <div class="BadgeLabel"><a id="ctl00_cphRoblox_rbxUserBadgesPane_dlBadges_ctl02_HyperLink1" href="Badges.aspx#Badge2">Friendship</a></div>
			    </div>
		    </td><td>
			    <div class="Badge" class="notranslate">
				    <div class="BadgeImage"><a id="ctl00_cphRoblox_rbxUserBadgesPane_dlBadges_ctl03_hlHeader" href="Badges.aspx#Badge5"><img id="ctl00_cphRoblox_rbxUserBadgesPane_dlBadges_ctl03_iBadge" src="http://images.rbxcdn.com/4cb4d69560f1f3478c314b24a52d2644.png" alt="Anyone who has earned this badge is a very dangerous player indeed. Those Robloxians who excel at combat can one day hope to achieve this honor, the Bloxxer Badge. It is given to the warrior who has bloxxed at least 250 enemies and who has tasted victory more times than he or she has suffered defeat. Salute!" style="height:75px;width:75px;border-width:0px;" /></a></div>
				    <div class="BadgeLabel"><a id="ctl00_cphRoblox_rbxUserBadgesPane_dlBadges_ctl03_HyperLink1" href="Badges.aspx#Badge5">Bloxxer</a></div>
			    </div>
		    </td><td>
			    <div class="Badge" class="notranslate">
				    <div class="BadgeImage"><a id="ctl00_cphRoblox_rbxUserBadgesPane_dlBadges_ctl04_hlHeader" href="Badges.aspx#Badge6"><img id="ctl00_cphRoblox_rbxUserBadgesPane_dlBadges_ctl04_iBadge" src="http://images.rbxcdn.com/26bdc9274d6c2520b3d72ebaa71e50f7.png" alt="The homestead badge is earned by having your personal place visited 100 times. Players who achieve this have demonstrated their ability to build cool things that other Robloxians were interested enough in to check out. Get a jump-start on earning this reward by inviting people to come visit your place." style="height:75px;width:75px;border-width:0px;" /></a></div>
				    <div class="BadgeLabel"><a id="ctl00_cphRoblox_rbxUserBadgesPane_dlBadges_ctl04_HyperLink1" href="Badges.aspx#Badge6">Homestead</a></div>
			    </div>
		    </td>
	</tr><tr>
		<td>
			    <div class="Badge" class="notranslate">
				    <div class="BadgeImage"><a id="ctl00_cphRoblox_rbxUserBadgesPane_dlBadges_ctl05_hlHeader" href="Badges.aspx#Badge8"><img id="ctl00_cphRoblox_rbxUserBadgesPane_dlBadges_ctl05_iBadge" src="http://images.rbxcdn.com/156b077267b7848d38df4471e2a2c540.png" alt="Robloxia is a vast uncharted realm, as large as the imagination. Individuals who invite others to join in the effort of mapping this mysterious region are honored in Robloxian society. Citizens who successfully recruit three or more fellow explorers via the Share Roblox with a Friend mechanism are awarded with this badge." style="height:75px;width:75px;border-width:0px;" /></a></div>
				    <div class="BadgeLabel"><a id="ctl00_cphRoblox_rbxUserBadgesPane_dlBadges_ctl05_HyperLink1" href="Badges.aspx#Badge8">Inviter</a></div>
			    </div>
		    </td><td>
			    <div class="Badge" class="notranslate">
				    <div class="BadgeImage"><a id="ctl00_cphRoblox_rbxUserBadgesPane_dlBadges_ctl06_hlHeader" href="Badges.aspx#Badge7"><img id="ctl00_cphRoblox_rbxUserBadgesPane_dlBadges_ctl06_iBadge" src="http://images.rbxcdn.com/4e483c695695b47c92591825929d1059.png" alt="The Bricksmith badge is earned by having a popular personal place. Once your place has been visited 1000 times, you will receive this award. Robloxians with Bricksmith badges are accomplished builders who were able to create a place that people wanted to explore a thousand times. They no doubt know a thing or two about putting bricks together." style="height:75px;width:75px;border-width:0px;" /></a></div>
				    <div class="BadgeLabel"><a id="ctl00_cphRoblox_rbxUserBadgesPane_dlBadges_ctl06_HyperLink1" href="Badges.aspx#Badge7">Bricksmith</a></div>
			    </div>
		    </td><td>
			    <div class="Badge" class="notranslate">
				    <div class="BadgeImage"><a id="ctl00_cphRoblox_rbxUserBadgesPane_dlBadges_ctl07_hlHeader" href="Badges.aspx#Badge12"><img id="ctl00_cphRoblox_rbxUserBadgesPane_dlBadges_ctl07_iBadge" src="http://images.rbxcdn.com/088451f70609387491bbf8e85f285065.png" alt="This decoration is awarded to all citizens who have played ROBLOX for at least a year. It recognizes stalwart community members who have stuck with us over countless releases and have helped shape ROBLOX into the game that it is today. These medalists are the true steel, the core of the Robloxian history ... and its future." style="height:75px;width:75px;border-width:0px;" /></a></div>
				    <div class="BadgeLabel"><a id="ctl00_cphRoblox_rbxUserBadgesPane_dlBadges_ctl07_HyperLink1" href="Badges.aspx#Badge12">Veteran</a></div>
			    </div>
		    </td><td>
			    <div class="Badge" class="notranslate">
				    <div class="BadgeImage"><a id="ctl00_cphRoblox_rbxUserBadgesPane_dlBadges_ctl08_hlHeader" href="Badges.aspx#Badge11"><img id="ctl00_cphRoblox_rbxUserBadgesPane_dlBadges_ctl08_iBadge" src="http://images.rbxcdn.com/049d72ade1586da1cfe2e48618cc3959.png" alt="Members of the illustrious Builders Club display this badge proudly. The Builders Club is a paid premium service. Members receive several benefits: they get ten places on their account instead of one, they earn a daily income of 15 ROBUX, they can sell their creations to others in the ROBLOX Catalog, they get the ability to browse the web site without external ads, and they receive the exclusive Builders Club construction hat." style="height:75px;width:75px;border-width:0px;" /></a></div>
				    <div class="BadgeLabel"><a id="ctl00_cphRoblox_rbxUserBadgesPane_dlBadges_ctl08_HyperLink1" href="Badges.aspx#Badge11">Builders Club</a></div>
			    </div>
		    </td><td></td>
	</tr>
</table>
	    
    </div>
</div>

            <div id="BadgesDisplayPane" class="divider-bottom" style="clear: both; padding-bottom: 20px">
                



<h2 class="title"><span>Player Badges</span></h2>
<div class="" style="min-height:300px;">
	    
    <div id="ctl00_cphRoblox_rbxBadgesDisplay_BadgesUpdatePanel" class="BadgesUpdatePanel">
	
            <div class="BadgesLoading_Container"></div>
            <div class="BadgesListView_Container">
                
                         
                        <div class="TileBadges">
                                <a id="ctl00_cphRoblox_rbxBadgesDisplay_BadgeListView_ctrl0_AssetThumbnailHyperLink" title="OstrichSized (Creator: Games)" href="/OstrichSized-item?id=132917568" style="display:inline-block;height:75px;width:75px;cursor:pointer;"><img src="http://t3.rbxcdn.com/63423f7240d4a7a17af9d0a5f7b4e2bf" height="75" width="75" border="0" onerror="return Roblox.Controls.Image.OnError(this)" alt="OstrichSized (Creator: Games)" /></a>
                        
                    
                            <div class="AssetDetails" style="display:none;" id="badgeInfo1567269713">
                                <div class="AssetName notranslate"><a id="ctl00_cphRoblox_rbxBadgesDisplay_BadgeListView_ctrl0_AssetNameHyperLink" title="click to view" href="/OstrichSized-item?id=132917568">OstrichSized</a></div>
                                <div class="AssetCreator"><span class="Label">Creator:</span> <span class="Detail notranslate" ><a id="ctl00_cphRoblox_rbxBadgesDisplay_BadgeListView_ctrl0_AssetCreatorHyperLink" href="User.aspx?ID=21557">Games</a></span></div>
                            </div>
                        </div>
                    
                        <div class="TileBadges">
                                <a id="ctl00_cphRoblox_rbxBadgesDisplay_BadgeListView_ctrl1_AssetThumbnailHyperLink" title="ChiefJustus (Creator: Games)" href="/ChiefJustus-item?id=132917372" style="display:inline-block;height:75px;width:75px;cursor:pointer;"><img src="http://t0.rbxcdn.com/02a6b9715fbfcc84a247d916b4527f06" height="75" width="75" border="0" onerror="return Roblox.Controls.Image.OnError(this)" alt="ChiefJustus (Creator: Games)" /></a>
                        
                    
                            <div class="AssetDetails" style="display:none;" id="badgeInfo1567267494">
                                <div class="AssetName notranslate"><a id="ctl00_cphRoblox_rbxBadgesDisplay_BadgeListView_ctrl1_AssetNameHyperLink" title="click to view" href="/ChiefJustus-item?id=132917372">ChiefJustus</a></div>
                                <div class="AssetCreator"><span class="Label">Creator:</span> <span class="Detail notranslate" ><a id="ctl00_cphRoblox_rbxBadgesDisplay_BadgeListView_ctrl1_AssetCreatorHyperLink" href="User.aspx?ID=21557">Games</a></span></div>
                            </div>
                        </div>
                    
                        <div class="TileBadges">
                                <a id="ctl00_cphRoblox_rbxBadgesDisplay_BadgeListView_ctrl2_AssetThumbnailHyperLink" title="StickMasterLuke (Creator: Games)" href="/StickMasterLuke-item?id=133893843" style="display:inline-block;height:75px;width:75px;cursor:pointer;"><img src="http://t6.rbxcdn.com/4bd6a6be278a0a16e6e6b884c613e53e" height="75" width="75" border="0" onerror="return Roblox.Controls.Image.OnError(this)" alt="StickMasterLuke (Creator: Games)" /></a>
                        
                    
                            <div class="AssetDetails" style="display:none;" id="badgeInfo1566902353">
                                <div class="AssetName notranslate"><a id="ctl00_cphRoblox_rbxBadgesDisplay_BadgeListView_ctrl2_AssetNameHyperLink" title="click to view" href="/StickMasterLuke-item?id=133893843">StickMasterLuke</a></div>
                                <div class="AssetCreator"><span class="Label">Creator:</span> <span class="Detail notranslate" ><a id="ctl00_cphRoblox_rbxBadgesDisplay_BadgeListView_ctrl2_AssetCreatorHyperLink" href="User.aspx?ID=21557">Games</a></span></div>
                            </div>
                        </div>
                    
                        <div class="TileBadges">
                                <a id="ctl00_cphRoblox_rbxBadgesDisplay_BadgeListView_ctrl3_AssetThumbnailHyperLink" title="Fusroblox (Creator: Games)" href="/Fusroblox-item?id=133893972" style="display:inline-block;height:75px;width:75px;cursor:pointer;"><img src="http://t6.rbxcdn.com/646b600467df02726fce5888807abd13" height="75" width="75" border="0" onerror="return Roblox.Controls.Image.OnError(this)" alt="Fusroblox (Creator: Games)" /></a>
                        
                    
                            <div class="AssetDetails" style="display:none;" id="badgeInfo1566846766">
                                <div class="AssetName notranslate"><a id="ctl00_cphRoblox_rbxBadgesDisplay_BadgeListView_ctrl3_AssetNameHyperLink" title="click to view" href="/Fusroblox-item?id=133893972">Fusroblox</a></div>
                                <div class="AssetCreator"><span class="Label">Creator:</span> <span class="Detail notranslate" ><a id="ctl00_cphRoblox_rbxBadgesDisplay_BadgeListView_ctrl3_AssetCreatorHyperLink" href="User.aspx?ID=21557">Games</a></span></div>
                            </div>
                        </div>
                    
                        <div class="TileBadges">
                                <a id="ctl00_cphRoblox_rbxBadgesDisplay_BadgeListView_ctrl4_AssetThumbnailHyperLink" title="Gargoyle (Creator: Games)" href="/Gargoyle-item?id=133552758" style="display:inline-block;height:75px;width:75px;cursor:pointer;"><img src="http://t1.rbxcdn.com/f32508438dde20389a39e9882d656750" height="75" width="75" border="0" onerror="return Roblox.Controls.Image.OnError(this)" alt="Gargoyle (Creator: Games)" /></a>
                        
                    
                            <div class="AssetDetails" style="display:none;" id="badgeInfo1563931165">
                                <div class="AssetName notranslate"><a id="ctl00_cphRoblox_rbxBadgesDisplay_BadgeListView_ctrl4_AssetNameHyperLink" title="click to view" href="/Gargoyle-item?id=133552758">Gargoyle</a></div>
                                <div class="AssetCreator"><span class="Label">Creator:</span> <span class="Detail notranslate" ><a id="ctl00_cphRoblox_rbxBadgesDisplay_BadgeListView_ctrl4_AssetCreatorHyperLink" href="User.aspx?ID=21557">Games</a></span></div>
                            </div>
                        </div>
                    
                        <div class="TileBadges">
                                <a id="ctl00_cphRoblox_rbxBadgesDisplay_BadgeListView_ctrl5_AssetThumbnailHyperLink" title="Hallo-bot (Creator: Games)" href="/Hallo-bot-item?id=133553737" style="display:inline-block;height:75px;width:75px;cursor:pointer;"><img src="http://t7.rbxcdn.com/cea4ad4ce02bf9ebb00795b78512eca1" height="75" width="75" border="0" onerror="return Roblox.Controls.Image.OnError(this)" alt="Hallo-bot (Creator: Games)" /></a>
                        
                    
                            <div class="AssetDetails" style="display:none;" id="badgeInfo1563887895">
                                <div class="AssetName notranslate"><a id="ctl00_cphRoblox_rbxBadgesDisplay_BadgeListView_ctrl5_AssetNameHyperLink" title="click to view" href="/Hallo-bot-item?id=133553737">Hallo-bot</a></div>
                                <div class="AssetCreator"><span class="Label">Creator:</span> <span class="Detail notranslate" ><a id="ctl00_cphRoblox_rbxBadgesDisplay_BadgeListView_ctrl5_AssetCreatorHyperLink" href="User.aspx?ID=21557">Games</a></span></div>
                            </div>
                        </div>
                    
                        <div class="TileBadges">
                                <a id="ctl00_cphRoblox_rbxBadgesDisplay_BadgeListView_ctrl6_AssetThumbnailHyperLink" title="Scarecrow (Creator: Games)" href="/Scarecrow-item?id=133554803" style="display:inline-block;height:75px;width:75px;cursor:pointer;"><img src="http://t3.rbxcdn.com/de04dd8e94c73fb038295564de261c25" height="75" width="75" border="0" onerror="return Roblox.Controls.Image.OnError(this)" alt="Scarecrow (Creator: Games)" /></a>
                        
                    
                            <div class="AssetDetails" style="display:none;" id="badgeInfo1563812166">
                                <div class="AssetName notranslate"><a id="ctl00_cphRoblox_rbxBadgesDisplay_BadgeListView_ctrl6_AssetNameHyperLink" title="click to view" href="/Scarecrow-item?id=133554803">Scarecrow</a></div>
                                <div class="AssetCreator"><span class="Label">Creator:</span> <span class="Detail notranslate" ><a id="ctl00_cphRoblox_rbxBadgesDisplay_BadgeListView_ctrl6_AssetCreatorHyperLink" href="User.aspx?ID=21557">Games</a></span></div>
                            </div>
                        </div>
                    
                        <div class="TileBadges">
                                <a id="ctl00_cphRoblox_rbxBadgesDisplay_BadgeListView_ctrl7_AssetThumbnailHyperLink" title="Yodalien (Creator: Games)" href="/Yodalien-item?id=133552138" style="display:inline-block;height:75px;width:75px;cursor:pointer;"><img src="http://t5.rbxcdn.com/73b27b2f5efac4c8c49fd01ebb92812d" height="75" width="75" border="0" onerror="return Roblox.Controls.Image.OnError(this)" alt="Yodalien (Creator: Games)" /></a>
                        
                    
                            <div class="AssetDetails" style="display:none;" id="badgeInfo1563645001">
                                <div class="AssetName notranslate"><a id="ctl00_cphRoblox_rbxBadgesDisplay_BadgeListView_ctrl7_AssetNameHyperLink" title="click to view" href="/Yodalien-item?id=133552138">Yodalien</a></div>
                                <div class="AssetCreator"><span class="Label">Creator:</span> <span class="Detail notranslate" ><a id="ctl00_cphRoblox_rbxBadgesDisplay_BadgeListView_ctrl7_AssetCreatorHyperLink" href="User.aspx?ID=21557">Games</a></span></div>
                            </div>
                        </div>
                    
                        <div class="TileBadges">
                                <a id="ctl00_cphRoblox_rbxBadgesDisplay_BadgeListView_ctrl8_AssetThumbnailHyperLink" title="Headless Horseman (Creator: Games)" href="/Headless-Horseman-item?id=133555353" style="display:inline-block;height:75px;width:75px;cursor:pointer;"><img src="http://t1.rbxcdn.com/82a195bcfb48c0a3dde5e7f8d9f10acd" height="75" width="75" border="0" onerror="return Roblox.Controls.Image.OnError(this)" alt="Headless Horseman (Creator: Games)" /></a>
                        
                    
                            <div class="AssetDetails" style="display:none;" id="badgeInfo1563522224">
                                <div class="AssetName notranslate"><a id="ctl00_cphRoblox_rbxBadgesDisplay_BadgeListView_ctrl8_AssetNameHyperLink" title="click to view" href="/Headless-Horseman-item?id=133555353">Headless Horseman</a></div>
                                <div class="AssetCreator"><span class="Label">Creator:</span> <span class="Detail notranslate" ><a id="ctl00_cphRoblox_rbxBadgesDisplay_BadgeListView_ctrl8_AssetCreatorHyperLink" href="User.aspx?ID=21557">Games</a></span></div>
                            </div>
                        </div>
                    
                        <div class="TileBadges">
                                <a id="ctl00_cphRoblox_rbxBadgesDisplay_BadgeListView_ctrl9_AssetThumbnailHyperLink" title="Frankenstein&#39;s Bride (Creator: Games)" href="/Frankensteins-Bride-item?id=133552453" style="display:inline-block;height:75px;width:75px;cursor:pointer;"><img src="http://t5.rbxcdn.com/a0f8592bbc438e3490b6882c9844da36" height="75" width="75" border="0" onerror="return Roblox.Controls.Image.OnError(this)" alt="Frankenstein&#39;s Bride (Creator: Games)" /></a>
                        
                    
                            <div class="AssetDetails" style="display:none;" id="badgeInfo1563204517">
                                <div class="AssetName notranslate"><a id="ctl00_cphRoblox_rbxBadgesDisplay_BadgeListView_ctrl9_AssetNameHyperLink" title="click to view" href="/Frankensteins-Bride-item?id=133552453">Frankenstein's Bride</a></div>
                                <div class="AssetCreator"><span class="Label">Creator:</span> <span class="Detail notranslate" ><a id="ctl00_cphRoblox_rbxBadgesDisplay_BadgeListView_ctrl9_AssetCreatorHyperLink" href="User.aspx?ID=21557">Games</a></span></div>
                            </div>
                        </div>
                    
                        <div class="TileBadges">
                                <a id="ctl00_cphRoblox_rbxBadgesDisplay_BadgeListView_ctrl10_AssetThumbnailHyperLink" title="Batgirl (Creator: Games)" href="/Batgirl-item?id=133162157" style="display:inline-block;height:75px;width:75px;cursor:pointer;"><img src="http://t7.rbxcdn.com/a44fc5e2c6f1e4021edb2013d7e1fe4e" height="75" width="75" border="0" onerror="return Roblox.Controls.Image.OnError(this)" alt="Batgirl (Creator: Games)" /></a>
                        
                    
                            <div class="AssetDetails" style="display:none;" id="badgeInfo1563102927">
                                <div class="AssetName notranslate"><a id="ctl00_cphRoblox_rbxBadgesDisplay_BadgeListView_ctrl10_AssetNameHyperLink" title="click to view" href="/Batgirl-item?id=133162157">Batgirl</a></div>
                                <div class="AssetCreator"><span class="Label">Creator:</span> <span class="Detail notranslate" ><a id="ctl00_cphRoblox_rbxBadgesDisplay_BadgeListView_ctrl10_AssetCreatorHyperLink" href="User.aspx?ID=21557">Games</a></span></div>
                            </div>
                        </div>
                    
                        <div class="TileBadges">
                                <a id="ctl00_cphRoblox_rbxBadgesDisplay_BadgeListView_ctrl11_AssetThumbnailHyperLink" title="Ooze Monster (Creator: Games)" href="/Ooze-Monster-item?id=133555504" style="display:inline-block;height:75px;width:75px;cursor:pointer;"><img src="http://t7.rbxcdn.com/30fdb7eb25c40e35a372c575c1c75b9c" height="75" width="75" border="0" onerror="return Roblox.Controls.Image.OnError(this)" alt="Ooze Monster (Creator: Games)" /></a>
                        
                    
                            <div class="AssetDetails" style="display:none;" id="badgeInfo1563074771">
                                <div class="AssetName notranslate"><a id="ctl00_cphRoblox_rbxBadgesDisplay_BadgeListView_ctrl11_AssetNameHyperLink" title="click to view" href="/Ooze-Monster-item?id=133555504">Ooze Monster</a></div>
                                <div class="AssetCreator"><span class="Label">Creator:</span> <span class="Detail notranslate" ><a id="ctl00_cphRoblox_rbxBadgesDisplay_BadgeListView_ctrl11_AssetCreatorHyperLink" href="User.aspx?ID=21557">Games</a></span></div>
                            </div>
                        </div>
                    
                        <div class="TileBadges">
                                <a id="ctl00_cphRoblox_rbxBadgesDisplay_BadgeListView_ctrl12_AssetThumbnailHyperLink" title="Tarabyte (Creator: Games)" href="/Tarabyte-item?id=132918228" style="display:inline-block;height:75px;width:75px;cursor:pointer;"><img src="http://t4.rbxcdn.com/b60c83e6714094710b319241390c3023" height="75" width="75" border="0" onerror="return Roblox.Controls.Image.OnError(this)" alt="Tarabyte (Creator: Games)" /></a>
                        
                    
                            <div class="AssetDetails" style="display:none;" id="badgeInfo1561315190">
                                <div class="AssetName notranslate"><a id="ctl00_cphRoblox_rbxBadgesDisplay_BadgeListView_ctrl12_AssetNameHyperLink" title="click to view" href="/Tarabyte-item?id=132918228">Tarabyte</a></div>
                                <div class="AssetCreator"><span class="Label">Creator:</span> <span class="Detail notranslate" ><a id="ctl00_cphRoblox_rbxBadgesDisplay_BadgeListView_ctrl12_AssetCreatorHyperLink" href="User.aspx?ID=21557">Games</a></span></div>
                            </div>
                        </div>
                    
                        <div class="TileBadges">
                                <a id="ctl00_cphRoblox_rbxBadgesDisplay_BadgeListView_ctrl13_AssetThumbnailHyperLink" title="JediTkacheff (Creator: Games)" href="/JediTkacheff-item?id=132917820" style="display:inline-block;height:75px;width:75px;cursor:pointer;"><img src="http://t2.rbxcdn.com/21279cac35da88e11d364bdd70707f0c" height="75" width="75" border="0" onerror="return Roblox.Controls.Image.OnError(this)" alt="JediTkacheff (Creator: Games)" /></a>
                        
                    
                            <div class="AssetDetails" style="display:none;" id="badgeInfo1561153462">
                                <div class="AssetName notranslate"><a id="ctl00_cphRoblox_rbxBadgesDisplay_BadgeListView_ctrl13_AssetNameHyperLink" title="click to view" href="/JediTkacheff-item?id=132917820">JediTkacheff</a></div>
                                <div class="AssetCreator"><span class="Label">Creator:</span> <span class="Detail notranslate" ><a id="ctl00_cphRoblox_rbxBadgesDisplay_BadgeListView_ctrl13_AssetCreatorHyperLink" href="User.aspx?ID=21557">Games</a></span></div>
                            </div>
                        </div>
                    
                        <div class="TileBadges">
                                <a id="ctl00_cphRoblox_rbxBadgesDisplay_BadgeListView_ctrl14_AssetThumbnailHyperLink" title="Spiderboy (Creator: Games)" href="/Spiderboy-item?id=133162359" style="display:inline-block;height:75px;width:75px;cursor:pointer;"><img src="http://t4.rbxcdn.com/758b946b9d75a043da24cd35865dfb82" height="75" width="75" border="0" onerror="return Roblox.Controls.Image.OnError(this)" alt="Spiderboy (Creator: Games)" /></a>
                        
                    
                            <div class="AssetDetails" style="display:none;" id="badgeInfo1561135118">
                                <div class="AssetName notranslate"><a id="ctl00_cphRoblox_rbxBadgesDisplay_BadgeListView_ctrl14_AssetNameHyperLink" title="click to view" href="/Spiderboy-item?id=133162359">Spiderboy</a></div>
                                <div class="AssetCreator"><span class="Label">Creator:</span> <span class="Detail notranslate" ><a id="ctl00_cphRoblox_rbxBadgesDisplay_BadgeListView_ctrl14_AssetCreatorHyperLink" href="User.aspx?ID=21557">Games</a></span></div>
                            </div>
                        </div>
                    
                    
            </div>
            
            <div class="BadgesPager_Container" style="clear:both;text-align:center;bottom: 5px;left: 75px;">
                <span id="ctl00_cphRoblox_rbxBadgesDisplay_BadgeDataPagerFooter"><a disabled="disabled" class="pager previous"></a>&nbsp;
                        <span style="display: inline-block; padding: 5px; vertical-align: top">
                        Page
                        <span id="ctl00_cphRoblox_rbxBadgesDisplay_BadgeDataPagerFooter_ctl01_CurrentPageLabel">1</span>
                        of
                        <span id="ctl00_cphRoblox_rbxBadgesDisplay_BadgeDataPagerFooter_ctl01_TotalPagesLabel">41</span>
                        </span>
                        <a class="pager next" href="javascript:__doPostBack(&#39;ctl00$cphRoblox$rbxBadgesDisplay$BadgeDataPagerFooter$ctl02$ctl00&#39;,&#39;&#39;)"></a>&nbsp;</span>
            </div>
        
</div>
	<div style="clear:both;"></div>
</div>

<script type="text/javascript">
    $('#' + 'ctl00_cphRoblox_rbxBadgesDisplay_BadgesUpdatePanel').bind('click', function (e) {
        var target = $(e.target);
        if (target.parentsUntil('.BadgesUpdatePanel', '.BadgesPager_Container').length > 0 && target[0].tagName == 'A') {
            //put up loading sign
            $('.BadgesListView_Container').html("");

            window.setTimeout(function () {
                if ($('.BadgesListView_Container').html() == "") {
                    $('.BadgesLoading_Container').html('<div style="text-align: center;margin-top: 25px;"><img src="/images/ProgressIndicator4.gif" alt="Loading..." /></div>');
                }
            }, 1000);
        }
    });
</script>
            </div>
            

<style>
.statsLabel { font-weight:bold; width:200px; text-align:right; padding-right:10px;}
.statsValue { font-weight:normal; width:200px; text-align:left;}
.statsTable { width:400px; }
</style>
<h2 class="title"><span>Statistics</span></h2>

<div class="divider-bottom" style="padding-bottom: 20px">
<table class="statsTable">
    <tr>
        <td class="statsLabel">
        <acronym title="The number of this user's friends.">Friends</acronym>:
        </td>
        <td class="statsValue">
        <span id="ctl00_cphRoblox_rbxUserStatisticsPane_lFriendsStatistics"><?php echo number_format($friendCount); ?></span>
        </td>
    </tr>
    
    <tr>
        <td class="statsLabel"><acronym title="The number of posts this user has made to the ROBLOX forum.">Forum Posts</acronym>:</td>
        <td class="statsValue"><span id="ctl00_cphRoblox_rbxUserStatisticsPane_lForumPostsStatistics" class="notranslate">0</span></td>
    </tr>
    <tr>
        <td class="statsLabel"><acronym title="The number of times this user's place has been visited.">Place Visits</acronym>:</td>
        <td class="statsValue"><span id="ctl00_cphRoblox_rbxUserStatisticsPane_lPlaceVisitsStatistics" class="notranslate">0</span></td>
    </tr>
    <tr>
        <td class="statsLabel"><acronym title="The number of times this user's character has destroyed another user's character in-game.">Knockouts</acronym>:</td>
        <td class="statsValue"><span id="ctl00_cphRoblox_rbxUserStatisticsPane_lKillsStatistics" class="notranslate">0</span></td>
    </tr>
    
     <tr>
        <td class="statsLabel"><acronym title="The all-time highest voting accuracy this user has achieved when voting in contests.">Highest Ever Voting Accuracy</acronym>:</td>
        <td class="statsValue"><span id="ctl00_cphRoblox_rbxUserStatisticsPane_lHighestEverVotingAccuracyStatistics">50</span>%</td>
    </tr>
     
</table>    
</div>
            

<div class="divider-bottom" style="padding-bottom: 20px">
    <div>
        <h2 class="title" style="display:block;float: left;">
            <span class="notranslate"><?php echo $uinfo->username; ?></span>'s Sets
        </h2>
        <a data-js-my-button href class="btn-small btn-neutral" id="ToggleBetweenOwnedSubscribedSets" style="float: right; margin-right: 20px; margin-top: 25px" onclick="Roblox.SetsPaneObject.toggleBetweenSetsOwnedSubscribed();return false;" >View Subscribed<span class="btn-text" id="SetsToggleSpan">View Subscribed</span></a>
        <div class="clear"></div>
    </div>
    <div id="OwnedSetsContainerDiv" style="padding-bottom:0;">
        <div id="SetsItemContainer" style="margin-bottom: 30px; margin-left: 15px"></div>
        <div style="clear:both;"></div>
        <div class="SetsPager_Container" style="position: relative">
            <div id="SetsPagerContainer"></div>
        </div>
    </div>
    <div id="SubscribedSetsContainerDiv" style="display:none; padding-top: 50px; padding-bottom: 0px">
        <div id="SubscribedSetsItemContainer" style="margin-bottom: 30px; margin-left: 15px"></div>
        <div style="clear:both;"></div>
        <div class="SetsPager_Container" style="position: relative">
            <div id="SubscribedSetsPagerContainer"></div>
        </div>
    </div>
    
    <div id="SetsPaneItemTemplate" style="display:none;">
        <div class="AssetThumbnail">
            <img class="$ImageAssetID"></img>
        </div>
        <div class="AssetDetails">
            <div class="AssetName notranslate" >
                <a href="/My/Sets.aspx?id=$ID">$Name</a>
            </div>
            <div class="AssetCreator">
                <span class="Label">Creator:&nbsp;</span>
                <span class="Detail">
                    <a href="/User.aspx?id=$CreatorUserID" class="notranslate">$CreatorName</a>
                </span>
            </div>
        </div>
    </div>
</div>

<script type="text/javascript">
    if (typeof Roblox === "undefined") {
        Roblox = {};
    }

    $(function () {
        Roblox.SetsPaneObject = Roblox.SetsPane('http://www.roblox.com/', 32916061);

        var options = { Paging_PageNumbers_AreLinks: false };
        Roblox.OwnedSetsJSDataPager = new DataPager(0, 9, 'SetsItemContainer', 'SetsPagerContainer',
            Roblox.SetsPaneObject.getSetsPaged, Roblox.SetsPaneObject.ownedItemFormatter, Roblox.SetsPaneObject.getSetAssetImageThumbnail, options
        );
        Roblox.SubscribedSetsJSDataPager = new DataPager(0, 9, 'SubscribedSetsItemContainer', 'SubscribedSetsPagerContainer',
            Roblox.SetsPaneObject.getSubscribedSetsPaged, Roblox.SetsPaneObject.subscribedItemFormatter, Roblox.SetsPaneObject.getSetAssetImageThumbnail, options
        );
    });
</script>

            
            <div id="UserGroupsPane" style="clear: both;">
                <h2 class="title">
                    <span>Groups</span></h2>
                

<div style="clear:both; padding-bottom: 20px; padding-left: 30px">
    
    <div id="ctl00_cphRoblox_rbxUserGroupsPane_ctl00">
	
            
                        
                    <div id="ctl00_cphRoblox_rbxUserGroupsPane_GroupListView_ctrl0_GroupTemplateItem" style="float: left">
		
                        <div class="groupEmblemThumbnail" style="width:70px; overflow:hidden;margin:15px">
                            <div class="groupEmblemImage notranslate" style="width: 70px; height:72px; margin: 0px 0px 0px 0px; padding-top: 0px; background-repeat:no-repeat; background-image:none ">
                                <a id="ctl00_cphRoblox_rbxUserGroupsPane_GroupListView_ctrl0_AssetImage1" title="Delvosity" href="/Groups/group.aspx?gid=975714" style="display:inline-block;height:62px;width:60px;cursor:pointer;"><img src="http://t7.rbxcdn.com/4bc58ea26af2fe1797081287481810c5" height="62" width="60" border="0" onerror="return Roblox.Controls.Image.OnError(this)" alt="Delvosity" /></a>
                            </div>
                        </div>
                    
	</div>
                
                    <div id="ctl00_cphRoblox_rbxUserGroupsPane_GroupListView_ctrl1_GroupTemplateItem" style="float: left">
		
                        <div class="groupEmblemThumbnail" style="width:70px; overflow:hidden;margin:15px">
                            <div class="groupEmblemImage notranslate" style="width: 70px; height:72px; margin: 0px 0px 0px 0px; padding-top: 0px; background-repeat:no-repeat; background-image:none ">
                                <a id="ctl00_cphRoblox_rbxUserGroupsPane_GroupListView_ctrl1_AssetImage1" title="Hydra Legion(HL)" href="/Groups/group.aspx?gid=880769" style="display:inline-block;height:62px;width:60px;cursor:pointer;"><img src="http://t6.rbxcdn.com/5644e5de753c86303fe1527ff55ec1f4" height="62" width="60" border="0" onerror="return Roblox.Controls.Image.OnError(this)" alt="Hydra Legion(HL)" /></a>
                            </div>
                        </div>
                    
	</div>
                
                    <div id="ctl00_cphRoblox_rbxUserGroupsPane_GroupListView_ctrl2_GroupTemplateItem" style="float: left">
		
                        <div class="groupEmblemThumbnail" style="width:70px; overflow:hidden;margin:15px">
                            <div class="groupEmblemImage notranslate" style="width: 70px; height:72px; margin: 0px 0px 0px 0px; padding-top: 0px; background-repeat:no-repeat; background-image:none ">
                                <a id="ctl00_cphRoblox_rbxUserGroupsPane_GroupListView_ctrl2_AssetImage1" title="Nightfall Clan " href="/Groups/group.aspx?gid=85654" style="display:inline-block;height:62px;width:60px;cursor:pointer;"><img src="http://t2.rbxcdn.com/7c8cb495f951a21d2746992fc6607471" height="62" width="60" border="0" onerror="return Roblox.Controls.Image.OnError(this)" alt="Nightfall Clan " /></a>
                            </div>
                        </div>
                    
	</div>
                
                    <div id="ctl00_cphRoblox_rbxUserGroupsPane_GroupListView_ctrl3_GroupTemplateItem" style="float: left">
		
                        <div class="groupEmblemThumbnail" style="width:70px; overflow:hidden;margin:15px">
                            <div class="groupEmblemImage notranslate" style="width: 70px; height:72px; margin: 0px 0px 0px 0px; padding-top: 0px; background-repeat:no-repeat; background-image:none ">
                                <a id="ctl00_cphRoblox_rbxUserGroupsPane_GroupListView_ctrl3_AssetImage1" title="Nightfall Clan Viridian Infantry" href="/Groups/group.aspx?gid=951145" style="display:inline-block;height:62px;width:60px;cursor:pointer;"><img src="http://t3.rbxcdn.com/106d4df06b86906906ffed686235d013" height="62" width="60" border="0" onerror="return Roblox.Controls.Image.OnError(this)" alt="Nightfall Clan Viridian Infantry" /></a>
                            </div>
                        </div>
                    
	</div>
                
                    <div id="ctl00_cphRoblox_rbxUserGroupsPane_GroupListView_ctrl4_GroupTemplateItem" style="float: left">
		
                        <div class="groupEmblemThumbnail" style="width:70px; overflow:hidden;margin:15px">
                            <div class="groupEmblemImage notranslate" style="width: 70px; height:72px; margin: 0px 0px 0px 0px; padding-top: 0px; background-repeat:no-repeat; background-image:none ">
                                <a id="ctl00_cphRoblox_rbxUserGroupsPane_GroupListView_ctrl4_AssetImage1" title="Ninjas Of The Dark Apocalypse" href="/Groups/group.aspx?gid=830510" style="display:inline-block;height:62px;width:60px;cursor:pointer;"><img src="http://t7.rbxcdn.com/1f7182ba1e9ac9de26a40264d31b5351" height="62" width="60" border="0" onerror="return Roblox.Controls.Image.OnError(this)" alt="Ninjas Of The Dark Apocalypse" /></a>
                            </div>
                        </div>
                    
	</div>
                
                
            
        
</div>
</div>

            </div>
        </div>
        <!--[if IE 6]>
      </td><td width="450px" valign="top">
      <![endif]-->
        <div class="divider-left" style="width: 484px; float: left; position: relative; left: -1px">
            <div class="divider-bottom" style="padding-bottom: 20px; padding-left: 20px">
                <h2 class="title" style="float: left">
                    <span>Active Places</span>
                </h2>
                
                <div id="UserPlacesPane">
                    <div id="ctl00_cphRoblox_rbxUserPlacesPane_pnlUserPlaces">
	
<div id="UserPlaces" style="overflow: hidden">

    <div id="ctl00_cphRoblox_rbxPlacesPane_pNoResults">
	
		<p><span id="ctl00_cphRoblox_rbxPlacesPane_lNoResults"><?php echo $uinfo->username; ?> does not have any Roblox places.</span></p>
	
	</div>



	<div id="ctl00_cphRoblox_rbxUserPlacesPane_ShowcaseFooter" class="PanelFooter" style="margin-top: 5px; margin-left:20px">
		
	    
	    
	
	</div>
 </div>
 
</div>
 
 <div class="ItemPurchaseAjaxContainer">
    

<div id="ItemPurchaseAjaxData"
        data-authenticateduser-isnull="True"
        data-user-balance-robux="0"
        data-user-balance-tickets="0"
        data-user-bc="0"
        data-continueshopping-url=""
        data-imageurl="" 
        data-alerturl="http://images.rbxcdn.com/cbb24e0c0f1fb97381a065bd1e056fcb.png"
        data-builderscluburl="http://images.rbxcdn.com/ae345c0d59b00329758518edc104d573.png"></div>

    <div id="ProcessingView" style="display:none">
        <div class="ProcessingModalBody">
            <p style="margin:0px"><img src='http://images.rbxcdn.com/ec4e85b0c4396cf753a06fade0a8d8af.gif' alt="Processing..." /></p>
            <p style="margin:7px 0px">Processing Transaction</p>
        </div>
    </div>
    
    <script type="text/javascript">
        //<sl:translate>
        Roblox.ItemPurchase.strings = {
            insufficientFundsTitle : "Insufficient Funds",
            insufficientFundsText : "You need {0} more to purchase this item.",
            cancelText : "Cancel",
            okText : "OK",
            buyText : "Buy",
            buyTextLower : "buy",
            tradeCurrencyText : "Trade Currency",
            priceChangeTitle : "Item Price Has Changed",
            priceChangeText : "While you were shopping, the price of this item changed from {0} to {1}.",
            buyNowText : "Buy Now",
            buyAccessText: "Buy Access",
            buildersClubOnlyTitle : "{0} Only",
            buildersClubOnlyText : "You need {0} to buy this item!",
            buyItemTitle : "Buy Item",
            buyItemText : "Would you like to {0} {5}the {1} {2} from {3} for {4}?",
            balanceText : "Your balance after this transaction will be {0}",
            freeText : "Free",
            purchaseCompleteTitle : "Purchase Complete!",
            purchaseCompleteText : "You have successfully {0} {5}the {1} {2} from {3} for {4}.",
            continueShoppingText : "Return to Profile",
            customizeCharacterText : "Customize Character",
            orText : "or",
            rentText : "rent",
            accessText: "access to "
        }
    //</sl:translate>
    </script>

</div>
 <script type="text/javascript">
     Roblox.require('Widgets.DropdownMenu', function (dropdown) {
         dropdown.InitializeDropdown();
     });
</script>
                </div>
            </div>
            <div style="padding-left: 20px" class="divider-bottom">
                

<div style="margin: 12px 0 20px; overflow:visible">
    <h2 style="float: left"><?php echo $uinfo->username; ?>'s Friends</h2>
    
    <a data-js-my-button style="float: right" href="Friends.aspx?UserID=<?php echo $uinfo->id; ?>" class="btn-small btn-neutral" id="HeaderButton">See All <?php echo $friendCount; ?><span class="btn-text">See All 4988</span></a>
    
</div>
<div style="padding-top: 50px">
    
	<table id="ctl00_cphRoblox_rbxFriendsPane_dlFriends" cellspacing="0" align="Center" border="0" style="border-collapse:collapse;">
	<tr>
	<?php 
	// friends list
	if($friendCount > 0)
	{
	$tr = 0; // <tr> tag, required for making two rows in html
	$stmt = $conn->prepare("SELECT * FROM friends WHERE ((sender = :t1) OR (receiver = :t2)) AND ((status = 2) OR (status = 3)) LIMIT 6");
	$stmt->bindParam(":t1", $uinfo->id, PDO::PARAM_INT);
	$stmt->bindParam(":t2", $uinfo->id, PDO::PARAM_INT);
	$stmt->execute();

	foreach($stmt->fetchAll(PDO::FETCH_OBJ) as $friend) 
	{ 
	
	// get user info
	$f_uinfo = (new UserAuthentication(($friend->sender == $uinfo->id) ? $friend->receiver : $friend->sender))->GetAllUserInfo();
	$online = isTimeConsideredOnline($f_uinfo->lastonline);
	
	// set user vars
	$f_icon = null;
	switch ($f_uinfo->membershiptype)
	{
		case "BuildersClub":
			$f_icon = "overlay_bcOnly.png";
			break;
		case "TurboBuildersClub":
			$f_icon = "overlay_tbcOnly.png";
			break;
		case "OutrageousBuildersClub":
			$f_icon = "overlay_obcOnly.png";
			break;
	}
	
	?>
		<td>
			<div class="Friend notranslate">
				<div class="Avatar"><a id="ctl00_cphRoblox_rbxFriendsPane_dlFriends_ctl00_hlAvatar" class=" notranslate" title="<?php echo $f_uinfo->username; ?>" class=" notranslate" href="/User.aspx?ID=<?php echo $f_uinfo->id; ?>" style="display:inline-block;height:100px;width:100px;cursor:pointer;"><img src="/images/boy_guest.png" height="100" width="100" border="0" onerror="return Roblox.Controls.Image.OnError(this)" alt="<?php echo $f_uinfo->username; ?>" class=" notranslate" />
				<?php if ($f_icon != null) echo '<img src="/images/icons/'.$f_icon.'" align="left" style="position:relative;top:-19px;" />'; ?></a></div>
				<div class="Summary">
					<span class="<?php echo $online ? "Online" : "Offline"; ?>Status"><img id="ctl00_cphRoblox_rbxFriendsPane_dlFriends_ctl00_i<?php echo $online ? "Online" : "Offline"; ?>Status" src="images/<?php echo $online ? "online" : "offline"; ?>.png" alt="" style="border-width:0px;" /></span>
					<span class="Name"><a id="ctl00_cphRoblox_rbxFriendsPane_dlFriends_ctl00_hlFriend" href="User.aspx?ID=<?php echo $f_uinfo->id; ?>"><?php echo $f_uinfo->username; ?></a></span>
				</div>
			</div>
		</td>
	<?php 
	$tr++;
	
	// create new row
	if($tr === 3) 
        echo "</tr><tr>";
	
	}
	} else { ?>
		<div id="ctl00_cphRoblox_rbxFriendsPane_pNoResults">
		<p><span id="ctl00_cphRoblox_rbxFriendsPane_lNoResults"><?php echo $uinfo->username; ?> does not have any Roblox friends.</span></p>
		</div>
<?php } ?>
	</tr>
</table>
	
</div>

            </div>
            

<div class="divider-bottom" style="padding-left: 20px; padding-bottom: 20px">
    <div id="ctl00_cphRoblox_rbxFavoritesPane_FavoritesPane">
	
	        <div  style="overflow: auto">
                <h2 class="title" style="float: left">Favorites</h2>
                <div class="PanelFooter" style="float: right; font: 12px Arial; text-transform: none">
			        Category:&nbsp;
			        <select name="ctl00$cphRoblox$rbxFavoritesPane$AssetCategoryDropDownList" id="ctl00_cphRoblox_rbxFavoritesPane_AssetCategoryDropDownList">
		<option value="17">Heads</option>
		<option value="18">Faces</option>
		<option value="19">Gear</option>
		<option value="8">Hats</option>
		<option value="2">T-Shirts</option>
		<option value="11">Shirts</option>
		<option value="12">Pants</option>
		<option value="13">Decals</option>
		<option value="10">Models</option>
		<option selected="selected" value="9">Places</option>

	</select>
		        </div>
            </div>
		    <div>
			
			    <div id="FavoritesContent">
				    <table id="ctl00_cphRoblox_rbxFavoritesPane_FavoritesDataList" cellspacing="0" border="0" style="border-collapse:collapse;">
		<tr>
			<td class="Asset" valign="top">
					        <div style="padding:5px; margin-right: 30px; margin-left: 10px">
						        <div class="AssetThumbnail notranslate" >
							        <a id="ctl00_cphRoblox_rbxFavoritesPane_FavoritesDataList_ctl03_AssetThumbnailHyperLink" class=" notranslate" title="Intense Doge fighting!" class=" notranslate" href="/Intense-Doge-fighting-place?id=120134405" style="display:inline-block;height:110px;width:110px;cursor:pointer;"><img src="http://t4.rbxcdn.com/01a39a4dc618c7b012eacc906b2437fd" height="110" width="110" border="0" onerror="return Roblox.Controls.Image.OnError(this)" alt="Intense Doge fighting!" class=" notranslate" /></a>
							    
						        </div>
						        <div class="AssetDetails notranslate" style="clear:both;">
							        <div class="AssetName"><a id="ctl00_cphRoblox_rbxFavoritesPane_FavoritesDataList_ctl03_AssetNameHyperLink" href="/Intense-Doge-fighting-place?id=120134405">Intense Doge fighting!</a></div>
							        <div class="AssetCreator"><span class="Label">Creator:</span> <span class="Detail"><a id="ctl00_cphRoblox_rbxFavoritesPane_FavoritesDataList_ctl03_AssetCreatorHyperLink" href="User.aspx?ID=2312310">loleris</a></span></div>
						            
						        </div>
						    </div>
					    </td>
		</tr>
	</table>
				    
				    
			    </div>
		    </div>
	    
</div>
</div>

            <div style="clear: both; margin: 20px;width:300px;">
                
                
            <div style="width: 300px">
    <!--<span id='3534333134383332' class="GPTAd rectangle" data-js-adtype="gptAd">
        <script type="text/javascript">
            googletag.cmd.push(function () {
                googletag.display("3534333134383332");
            });
        </script>
    </span>
    <div class="ad-annotations " style="width: 300px">
        <span class="ad-identification">Advertisement</span>
            <a class="BadAdButton" href="/Ads/ReportAd.aspx" title="click to report an offensive ad">Report</a>
    </div>-->
</div>

            </div>
        </div>
        <!--[if IE 6]>
      </td></tr></table>
      <![endif]-->
        <br clear="all" />
    </div>
    <div id="UserContainer">
        <div id="UserAssetsPane" style="border-top: 1px solid #ccc;">
            <div id="ctl00_cphRoblox_rbxUserAssetsPane_upUserAssetsPane">
	
        <h2 class="title" display="block" style="width:970px">
            <span>
                Inventory
                
        </span>
        </h2>
        <div id="UserAssets">
            <div id="AssetsMenu"  class="divider-right">
                
                        <div id="ctl00_cphRoblox_rbxUserAssetsPane_AssetCategoryRepeater_ctl00_AssetCategorySelectorPanel" class="verticaltab">
		
                            <a id="ctl00_cphRoblox_rbxUserAssetsPane_AssetCategoryRepeater_ctl00_AssetCategorySelector" href="javascript:WebForm_DoPostBackWithOptions(new WebForm_PostBackOptions(&quot;ctl00$cphRoblox$rbxUserAssetsPane$AssetCategoryRepeater$ctl00$AssetCategorySelector&quot;, &quot;&quot;, true, &quot;&quot;, &quot;&quot;, false, true))">Heads</a>
	</div>
                    
                        <div id="ctl00_cphRoblox_rbxUserAssetsPane_AssetCategoryRepeater_ctl01_AssetCategorySelectorPanel" class="verticaltab">
		
                            <a id="ctl00_cphRoblox_rbxUserAssetsPane_AssetCategoryRepeater_ctl01_AssetCategorySelector" href="javascript:WebForm_DoPostBackWithOptions(new WebForm_PostBackOptions(&quot;ctl00$cphRoblox$rbxUserAssetsPane$AssetCategoryRepeater$ctl01$AssetCategorySelector&quot;, &quot;&quot;, true, &quot;&quot;, &quot;&quot;, false, true))">Faces</a>
	</div>
                    
                        <div id="ctl00_cphRoblox_rbxUserAssetsPane_AssetCategoryRepeater_ctl02_AssetCategorySelectorPanel" class="verticaltab">
		
                            <a id="ctl00_cphRoblox_rbxUserAssetsPane_AssetCategoryRepeater_ctl02_AssetCategorySelector" href="javascript:WebForm_DoPostBackWithOptions(new WebForm_PostBackOptions(&quot;ctl00$cphRoblox$rbxUserAssetsPane$AssetCategoryRepeater$ctl02$AssetCategorySelector&quot;, &quot;&quot;, true, &quot;&quot;, &quot;&quot;, false, true))">Gear</a>
	</div>
                    
                        <div id="ctl00_cphRoblox_rbxUserAssetsPane_AssetCategoryRepeater_ctl03_AssetCategorySelectorPanel" class="verticaltab selected">
		
                            <a id="ctl00_cphRoblox_rbxUserAssetsPane_AssetCategoryRepeater_ctl03_AssetCategorySelector" href="javascript:WebForm_DoPostBackWithOptions(new WebForm_PostBackOptions(&quot;ctl00$cphRoblox$rbxUserAssetsPane$AssetCategoryRepeater$ctl03$AssetCategorySelector&quot;, &quot;&quot;, true, &quot;&quot;, &quot;&quot;, false, true))">Hats</a>
	</div>
                    
                        <div id="ctl00_cphRoblox_rbxUserAssetsPane_AssetCategoryRepeater_ctl04_AssetCategorySelectorPanel" class="verticaltab">
		
                            <a id="ctl00_cphRoblox_rbxUserAssetsPane_AssetCategoryRepeater_ctl04_AssetCategorySelector" href="javascript:WebForm_DoPostBackWithOptions(new WebForm_PostBackOptions(&quot;ctl00$cphRoblox$rbxUserAssetsPane$AssetCategoryRepeater$ctl04$AssetCategorySelector&quot;, &quot;&quot;, true, &quot;&quot;, &quot;&quot;, false, true))">T-Shirts</a>
	</div>
                    
                        <div id="ctl00_cphRoblox_rbxUserAssetsPane_AssetCategoryRepeater_ctl05_AssetCategorySelectorPanel" class="verticaltab">
		
                            <a id="ctl00_cphRoblox_rbxUserAssetsPane_AssetCategoryRepeater_ctl05_AssetCategorySelector" href="javascript:WebForm_DoPostBackWithOptions(new WebForm_PostBackOptions(&quot;ctl00$cphRoblox$rbxUserAssetsPane$AssetCategoryRepeater$ctl05$AssetCategorySelector&quot;, &quot;&quot;, true, &quot;&quot;, &quot;&quot;, false, true))">Shirts</a>
	</div>
                    
                        <div id="ctl00_cphRoblox_rbxUserAssetsPane_AssetCategoryRepeater_ctl06_AssetCategorySelectorPanel" class="verticaltab">
		
                            <a id="ctl00_cphRoblox_rbxUserAssetsPane_AssetCategoryRepeater_ctl06_AssetCategorySelector" href="javascript:WebForm_DoPostBackWithOptions(new WebForm_PostBackOptions(&quot;ctl00$cphRoblox$rbxUserAssetsPane$AssetCategoryRepeater$ctl06$AssetCategorySelector&quot;, &quot;&quot;, true, &quot;&quot;, &quot;&quot;, false, true))">Pants</a>
	</div>
                    
                        <div id="ctl00_cphRoblox_rbxUserAssetsPane_AssetCategoryRepeater_ctl07_AssetCategorySelectorPanel" class="verticaltab">
		
                            <a id="ctl00_cphRoblox_rbxUserAssetsPane_AssetCategoryRepeater_ctl07_AssetCategorySelector" href="javascript:WebForm_DoPostBackWithOptions(new WebForm_PostBackOptions(&quot;ctl00$cphRoblox$rbxUserAssetsPane$AssetCategoryRepeater$ctl07$AssetCategorySelector&quot;, &quot;&quot;, true, &quot;&quot;, &quot;&quot;, false, true))">Decals</a>
	</div>
                    
                        <div id="ctl00_cphRoblox_rbxUserAssetsPane_AssetCategoryRepeater_ctl08_AssetCategorySelectorPanel" class="verticaltab">
		
                            <a id="ctl00_cphRoblox_rbxUserAssetsPane_AssetCategoryRepeater_ctl08_AssetCategorySelector" href="javascript:WebForm_DoPostBackWithOptions(new WebForm_PostBackOptions(&quot;ctl00$cphRoblox$rbxUserAssetsPane$AssetCategoryRepeater$ctl08$AssetCategorySelector&quot;, &quot;&quot;, true, &quot;&quot;, &quot;&quot;, false, true))">Models</a>
	</div>
                    
                        <div id="ctl00_cphRoblox_rbxUserAssetsPane_AssetCategoryRepeater_ctl09_AssetCategorySelectorPanel" class="verticaltab">
		
                            <a id="ctl00_cphRoblox_rbxUserAssetsPane_AssetCategoryRepeater_ctl09_AssetCategorySelector" href="javascript:WebForm_DoPostBackWithOptions(new WebForm_PostBackOptions(&quot;ctl00$cphRoblox$rbxUserAssetsPane$AssetCategoryRepeater$ctl09$AssetCategorySelector&quot;, &quot;&quot;, true, &quot;&quot;, &quot;&quot;, false, true))">Places</a>
	</div>
                    
                        <div id="ctl00_cphRoblox_rbxUserAssetsPane_AssetCategoryRepeater_ctl10_AssetCategorySelectorPanel" class="verticaltab">
		
                            <a id="ctl00_cphRoblox_rbxUserAssetsPane_AssetCategoryRepeater_ctl10_AssetCategorySelector" href="javascript:WebForm_DoPostBackWithOptions(new WebForm_PostBackOptions(&quot;ctl00$cphRoblox$rbxUserAssetsPane$AssetCategoryRepeater$ctl10$AssetCategorySelector&quot;, &quot;&quot;, true, &quot;&quot;, &quot;&quot;, false, true))">Game Passes</a>
	</div>
                    
                        <div id="ctl00_cphRoblox_rbxUserAssetsPane_AssetCategoryRepeater_ctl11_AssetCategorySelectorPanel" class="verticaltab">
		
                            <a id="ctl00_cphRoblox_rbxUserAssetsPane_AssetCategoryRepeater_ctl11_AssetCategorySelector" href="javascript:WebForm_DoPostBackWithOptions(new WebForm_PostBackOptions(&quot;ctl00$cphRoblox$rbxUserAssetsPane$AssetCategoryRepeater$ctl11$AssetCategorySelector&quot;, &quot;&quot;, true, &quot;&quot;, &quot;&quot;, false, true))">Audio</a>
	</div>
                    
                        <div id="ctl00_cphRoblox_rbxUserAssetsPane_AssetCategoryRepeater_ctl12_AssetCategorySelectorPanel" class="verticaltab">
		
                            <a id="ctl00_cphRoblox_rbxUserAssetsPane_AssetCategoryRepeater_ctl12_AssetCategorySelector" href="javascript:WebForm_DoPostBackWithOptions(new WebForm_PostBackOptions(&quot;ctl00$cphRoblox$rbxUserAssetsPane$AssetCategoryRepeater$ctl12$AssetCategorySelector&quot;, &quot;&quot;, true, &quot;&quot;, &quot;&quot;, false, true))">Badges</a>
	</div>
                    
                        <div id="ctl00_cphRoblox_rbxUserAssetsPane_AssetCategoryRepeater_ctl13_AssetCategorySelectorPanel" class="verticaltab">
		
                            <a id="ctl00_cphRoblox_rbxUserAssetsPane_AssetCategoryRepeater_ctl13_AssetCategorySelector" href="javascript:WebForm_DoPostBackWithOptions(new WebForm_PostBackOptions(&quot;ctl00$cphRoblox$rbxUserAssetsPane$AssetCategoryRepeater$ctl13$AssetCategorySelector&quot;, &quot;&quot;, true, &quot;&quot;, &quot;&quot;, false, true))">Left Arms</a>
	</div>
                    
                        <div id="ctl00_cphRoblox_rbxUserAssetsPane_AssetCategoryRepeater_ctl14_AssetCategorySelectorPanel" class="verticaltab">
		
                            <a id="ctl00_cphRoblox_rbxUserAssetsPane_AssetCategoryRepeater_ctl14_AssetCategorySelector" href="javascript:WebForm_DoPostBackWithOptions(new WebForm_PostBackOptions(&quot;ctl00$cphRoblox$rbxUserAssetsPane$AssetCategoryRepeater$ctl14$AssetCategorySelector&quot;, &quot;&quot;, true, &quot;&quot;, &quot;&quot;, false, true))">Right Arms</a>
	</div>
                    
                        <div id="ctl00_cphRoblox_rbxUserAssetsPane_AssetCategoryRepeater_ctl15_AssetCategorySelectorPanel" class="verticaltab">
		
                            <a id="ctl00_cphRoblox_rbxUserAssetsPane_AssetCategoryRepeater_ctl15_AssetCategorySelector" href="javascript:WebForm_DoPostBackWithOptions(new WebForm_PostBackOptions(&quot;ctl00$cphRoblox$rbxUserAssetsPane$AssetCategoryRepeater$ctl15$AssetCategorySelector&quot;, &quot;&quot;, true, &quot;&quot;, &quot;&quot;, false, true))">Left Legs</a>
	</div>
                    
                        <div id="ctl00_cphRoblox_rbxUserAssetsPane_AssetCategoryRepeater_ctl16_AssetCategorySelectorPanel" class="verticaltab">
		
                            <a id="ctl00_cphRoblox_rbxUserAssetsPane_AssetCategoryRepeater_ctl16_AssetCategorySelector" href="javascript:WebForm_DoPostBackWithOptions(new WebForm_PostBackOptions(&quot;ctl00$cphRoblox$rbxUserAssetsPane$AssetCategoryRepeater$ctl16$AssetCategorySelector&quot;, &quot;&quot;, true, &quot;&quot;, &quot;&quot;, false, true))">Right Legs</a>
	</div>
                    
                        <div id="ctl00_cphRoblox_rbxUserAssetsPane_AssetCategoryRepeater_ctl17_AssetCategorySelectorPanel" class="verticaltab">
		
                            <a id="ctl00_cphRoblox_rbxUserAssetsPane_AssetCategoryRepeater_ctl17_AssetCategorySelector" href="javascript:WebForm_DoPostBackWithOptions(new WebForm_PostBackOptions(&quot;ctl00$cphRoblox$rbxUserAssetsPane$AssetCategoryRepeater$ctl17$AssetCategorySelector&quot;, &quot;&quot;, true, &quot;&quot;, &quot;&quot;, false, true))">Torsos</a>
	</div>
                    
                        <div id="ctl00_cphRoblox_rbxUserAssetsPane_AssetCategoryRepeater_ctl18_AssetCategorySelectorPanel" class="verticaltab">
		
                            <a id="ctl00_cphRoblox_rbxUserAssetsPane_AssetCategoryRepeater_ctl18_AssetCategorySelector" href="javascript:WebForm_DoPostBackWithOptions(new WebForm_PostBackOptions(&quot;ctl00$cphRoblox$rbxUserAssetsPane$AssetCategoryRepeater$ctl18$AssetCategorySelector&quot;, &quot;&quot;, true, &quot;&quot;, &quot;&quot;, false, true))">Packages</a>
	</div>
                    
            </div>
            <div id="AssetsContent">
                
                
                
                <table id="ctl00_cphRoblox_rbxUserAssetsPane_UserAssetsDataList" cellspacing="0" border="0" style="border-collapse:collapse;">
		<tr>
			<td class="Asset" valign="top">
                        <div style="padding: 5px">
                            <div class="AssetThumbnail">
                                <a id="ctl00_cphRoblox_rbxUserAssetsPane_UserAssetsDataList_ctl00_AssetThumbnailHyperLink" class=" notranslate" title="BLOXikin #05 Mummy OstrichSized" class=" notranslate" href="/BLOXikin-05-Mummy-OstrichSized-item?id=132923387" style="display:inline-block;height:110px;width:110px;cursor:pointer;"><img src="http://t0.rbxcdn.com/2294d678ae308dbf1ee52c6809877f40" height="110" width="110" border="0" onerror="return Roblox.Controls.Image.OnError(this)" alt="BLOXikin #05 Mummy OstrichSized" class=" notranslate" /></a>
                                
                            </div>
                            <div class="AssetDetails">
                                <div class="AssetName">
                                    <a id="ctl00_cphRoblox_rbxUserAssetsPane_UserAssetsDataList_ctl00_AssetNameHyperLink" class="noranslate" href="/BLOXikin-05-Mummy-OstrichSized-item?id=132923387">BLOXikin #05 Mummy OstrichSized</a></div>
                                <div class="AssetCreator">
                                    <span class="Label">Creator: </span><span class="Detail notranslate">
                                        <a id="ctl00_cphRoblox_rbxUserAssetsPane_UserAssetsDataList_ctl00_AssetCreatorHyperLink" href="User.aspx?ID=1">ROBLOX</a></span></div>
                                
                                
                                
                            </div>
                        </div>
                    </td><td class="Asset" valign="top">
                        <div style="padding: 5px">
                            <div class="AssetThumbnail">
                                <a id="ctl00_cphRoblox_rbxUserAssetsPane_UserAssetsDataList_ctl01_AssetThumbnailHyperLink" class=" notranslate" title="BLOXikin #13 Devil ChiefJustus" class=" notranslate" href="/BLOXikin-13-Devil-ChiefJustus-item?id=132923310" style="display:inline-block;height:110px;width:110px;cursor:pointer;"><img src="http://t2.rbxcdn.com/bfa2a24e61c7b74199ad1af2a64d72dd" height="110" width="110" border="0" onerror="return Roblox.Controls.Image.OnError(this)" alt="BLOXikin #13 Devil ChiefJustus" class=" notranslate" /></a>
                                
                            </div>
                            <div class="AssetDetails">
                                <div class="AssetName">
                                    <a id="ctl00_cphRoblox_rbxUserAssetsPane_UserAssetsDataList_ctl01_AssetNameHyperLink" class="noranslate" href="/BLOXikin-13-Devil-ChiefJustus-item?id=132923310">BLOXikin #13 Devil ChiefJustus</a></div>
                                <div class="AssetCreator">
                                    <span class="Label">Creator: </span><span class="Detail notranslate">
                                        <a id="ctl00_cphRoblox_rbxUserAssetsPane_UserAssetsDataList_ctl01_AssetCreatorHyperLink" href="User.aspx?ID=1">ROBLOX</a></span></div>
                                
                                
                                
                            </div>
                        </div>
                    </td><td class="Asset" valign="top">
                        <div style="padding: 5px">
                            <div class="AssetThumbnail">
                                <a id="ctl00_cphRoblox_rbxUserAssetsPane_UserAssetsDataList_ctl02_AssetThumbnailHyperLink" class=" notranslate" title="Beautiful Hair for Beautiful People" class=" notranslate" href="/Beautiful-Hair-for-Beautiful-People-item?id=16630147" style="display:inline-block;height:110px;width:110px;cursor:pointer;"><img src="http://t1.rbxcdn.com/1efa50b1cbb98fa8476ff0de661c8abc" height="110" width="110" border="0" onerror="return Roblox.Controls.Image.OnError(this)" alt="Beautiful Hair for Beautiful People" class=" notranslate" /></a>
                                
                            </div>
                            <div class="AssetDetails">
                                <div class="AssetName">
                                    <a id="ctl00_cphRoblox_rbxUserAssetsPane_UserAssetsDataList_ctl02_AssetNameHyperLink" class="noranslate" href="/Beautiful-Hair-for-Beautiful-People-item?id=16630147">Beautiful Hair for Beautiful People</a></div>
                                <div class="AssetCreator">
                                    <span class="Label">Creator: </span><span class="Detail notranslate">
                                        <a id="ctl00_cphRoblox_rbxUserAssetsPane_UserAssetsDataList_ctl02_AssetCreatorHyperLink" href="User.aspx?ID=1">ROBLOX</a></span></div>
                                <div id="ctl00_cphRoblox_rbxUserAssetsPane_UserAssetsDataList_ctl02_Div1" class="AssetPrice">
                                    <span class="PriceInRobux notranslate">
                                        R$: 95</span></div>
                                
                                
                            </div>
                        </div>
                    </td><td class="Asset" valign="top">
                        <div style="padding: 5px">
                            <div class="AssetThumbnail">
                                <a id="ctl00_cphRoblox_rbxUserAssetsPane_UserAssetsDataList_ctl03_AssetThumbnailHyperLink" class=" notranslate" title="BLOXikin #09 Zombie StickmasterLuke" class=" notranslate" href="/BLOXikin-09-Zombie-StickmasterLuke-item?id=133873051" style="display:inline-block;height:110px;width:110px;cursor:pointer;"><img src="http://t7.rbxcdn.com/81959e7eb6e1310c685d6038ee78938e" height="110" width="110" border="0" onerror="return Roblox.Controls.Image.OnError(this)" alt="BLOXikin #09 Zombie StickmasterLuke" class=" notranslate" /></a>
                                
                            </div>
                            <div class="AssetDetails">
                                <div class="AssetName">
                                    <a id="ctl00_cphRoblox_rbxUserAssetsPane_UserAssetsDataList_ctl03_AssetNameHyperLink" class="noranslate" href="/BLOXikin-09-Zombie-StickmasterLuke-item?id=133873051">BLOXikin #09 Zombie StickmasterLuke</a></div>
                                <div class="AssetCreator">
                                    <span class="Label">Creator: </span><span class="Detail notranslate">
                                        <a id="ctl00_cphRoblox_rbxUserAssetsPane_UserAssetsDataList_ctl03_AssetCreatorHyperLink" href="User.aspx?ID=1">ROBLOX</a></span></div>
                                
                                
                                
                            </div>
                        </div>
                    </td><td class="Asset" valign="top">
                        <div style="padding: 5px">
                            <div class="AssetThumbnail">
                                <a id="ctl00_cphRoblox_rbxUserAssetsPane_UserAssetsDataList_ctl04_AssetThumbnailHyperLink" class=" notranslate" title="BLOXikin #10 Frankenstein Fusroblox" class=" notranslate" href="/BLOXikin-10-Frankenstein-Fusroblox-item?id=133872999" style="display:inline-block;height:110px;width:110px;cursor:pointer;"><img src="http://t3.rbxcdn.com/5feb647702eaf258400685eacb182b42" height="110" width="110" border="0" onerror="return Roblox.Controls.Image.OnError(this)" alt="BLOXikin #10 Frankenstein Fusroblox" class=" notranslate" /></a>
                                
                            </div>
                            <div class="AssetDetails">
                                <div class="AssetName">
                                    <a id="ctl00_cphRoblox_rbxUserAssetsPane_UserAssetsDataList_ctl04_AssetNameHyperLink" class="noranslate" href="/BLOXikin-10-Frankenstein-Fusroblox-item?id=133872999">BLOXikin #10 Frankenstein Fusroblox</a></div>
                                <div class="AssetCreator">
                                    <span class="Label">Creator: </span><span class="Detail notranslate">
                                        <a id="ctl00_cphRoblox_rbxUserAssetsPane_UserAssetsDataList_ctl04_AssetCreatorHyperLink" href="User.aspx?ID=1">ROBLOX</a></span></div>
                                
                                
                                
                            </div>
                        </div>
                    </td><td class="Asset" valign="top">
                        <div style="padding: 5px">
                            <div class="AssetThumbnail">
                                <a id="ctl00_cphRoblox_rbxUserAssetsPane_UserAssetsDataList_ctl05_AssetThumbnailHyperLink" class=" notranslate" title="BLOXikin #27 Gargoyle" class=" notranslate" href="/BLOXikin-27-Gargoyle-item?id=133520439" style="display:inline-block;height:110px;width:110px;cursor:pointer;"><img src="http://t5.rbxcdn.com/879ddf069cf6320c57d1c48ea316077d" height="110" width="110" border="0" onerror="return Roblox.Controls.Image.OnError(this)" alt="BLOXikin #27 Gargoyle" class=" notranslate" /></a>
                                
                            </div>
                            <div class="AssetDetails">
                                <div class="AssetName">
                                    <a id="ctl00_cphRoblox_rbxUserAssetsPane_UserAssetsDataList_ctl05_AssetNameHyperLink" class="noranslate" href="/BLOXikin-27-Gargoyle-item?id=133520439">BLOXikin #27 Gargoyle</a></div>
                                <div class="AssetCreator">
                                    <span class="Label">Creator: </span><span class="Detail notranslate">
                                        <a id="ctl00_cphRoblox_rbxUserAssetsPane_UserAssetsDataList_ctl05_AssetCreatorHyperLink" href="User.aspx?ID=1">ROBLOX</a></span></div>
                                
                                
                                
                            </div>
                        </div>
                    </td>
		</tr><tr>
			<td class="Asset" valign="top">
                        <div style="padding: 5px">
                            <div class="AssetThumbnail">
                                <a id="ctl00_cphRoblox_rbxUserAssetsPane_UserAssetsDataList_ctl06_AssetThumbnailHyperLink" class=" notranslate" title="BLOXikin #29 Hallo-bot" class=" notranslate" href="/BLOXikin-29-Hallo-bot-item?id=133520348" style="display:inline-block;height:110px;width:110px;cursor:pointer;"><img src="http://t4.rbxcdn.com/2d2f92715bdd687712d99b632a65643d" height="110" width="110" border="0" onerror="return Roblox.Controls.Image.OnError(this)" alt="BLOXikin #29 Hallo-bot" class=" notranslate" /></a>
                                
                            </div>
                            <div class="AssetDetails">
                                <div class="AssetName">
                                    <a id="ctl00_cphRoblox_rbxUserAssetsPane_UserAssetsDataList_ctl06_AssetNameHyperLink" class="noranslate" href="/BLOXikin-29-Hallo-bot-item?id=133520348">BLOXikin #29 Hallo-bot</a></div>
                                <div class="AssetCreator">
                                    <span class="Label">Creator: </span><span class="Detail notranslate">
                                        <a id="ctl00_cphRoblox_rbxUserAssetsPane_UserAssetsDataList_ctl06_AssetCreatorHyperLink" href="User.aspx?ID=1">ROBLOX</a></span></div>
                                
                                
                                
                            </div>
                        </div>
                    </td><td class="Asset" valign="top">
                        <div style="padding: 5px">
                            <div class="AssetThumbnail">
                                <a id="ctl00_cphRoblox_rbxUserAssetsPane_UserAssetsDataList_ctl07_AssetThumbnailHyperLink" class=" notranslate" title="BLOXikin #25 Scarecrow" class=" notranslate" href="/BLOXikin-25-Scarecrow-item?id=133520230" style="display:inline-block;height:110px;width:110px;cursor:pointer;"><img src="http://t2.rbxcdn.com/5600d7f0dd160567a41d0d952715fae3" height="110" width="110" border="0" onerror="return Roblox.Controls.Image.OnError(this)" alt="BLOXikin #25 Scarecrow" class=" notranslate" /></a>
                                
                            </div>
                            <div class="AssetDetails">
                                <div class="AssetName">
                                    <a id="ctl00_cphRoblox_rbxUserAssetsPane_UserAssetsDataList_ctl07_AssetNameHyperLink" class="noranslate" href="/BLOXikin-25-Scarecrow-item?id=133520230">BLOXikin #25 Scarecrow</a></div>
                                <div class="AssetCreator">
                                    <span class="Label">Creator: </span><span class="Detail notranslate">
                                        <a id="ctl00_cphRoblox_rbxUserAssetsPane_UserAssetsDataList_ctl07_AssetCreatorHyperLink" href="User.aspx?ID=1">ROBLOX</a></span></div>
                                
                                
                                
                            </div>
                        </div>
                    </td><td class="Asset" valign="top">
                        <div style="padding: 5px">
                            <div class="AssetThumbnail">
                                <a id="ctl00_cphRoblox_rbxUserAssetsPane_UserAssetsDataList_ctl08_AssetThumbnailHyperLink" class=" notranslate" title="BLOXikin #28 Yodalien" class=" notranslate" href="/BLOXikin-28-Yodalien-item?id=133520293" style="display:inline-block;height:110px;width:110px;cursor:pointer;"><img src="http://t2.rbxcdn.com/7535c994cb734621c94e7dbf12e28390" height="110" width="110" border="0" onerror="return Roblox.Controls.Image.OnError(this)" alt="BLOXikin #28 Yodalien" class=" notranslate" /></a>
                                
                            </div>
                            <div class="AssetDetails">
                                <div class="AssetName">
                                    <a id="ctl00_cphRoblox_rbxUserAssetsPane_UserAssetsDataList_ctl08_AssetNameHyperLink" class="noranslate" href="/BLOXikin-28-Yodalien-item?id=133520293">BLOXikin #28 Yodalien</a></div>
                                <div class="AssetCreator">
                                    <span class="Label">Creator: </span><span class="Detail notranslate">
                                        <a id="ctl00_cphRoblox_rbxUserAssetsPane_UserAssetsDataList_ctl08_AssetCreatorHyperLink" href="User.aspx?ID=1">ROBLOX</a></span></div>
                                
                                
                                
                            </div>
                        </div>
                    </td><td class="Asset" valign="top">
                        <div style="padding: 5px">
                            <div class="AssetThumbnail">
                                <a id="ctl00_cphRoblox_rbxUserAssetsPane_UserAssetsDataList_ctl09_AssetThumbnailHyperLink" class=" notranslate" title="BLOXikin #31 Headless Horseman" class=" notranslate" href="/BLOXikin-31-Headless-Horseman-item?id=133520071" style="display:inline-block;height:110px;width:110px;cursor:pointer;"><img src="http://t1.rbxcdn.com/6731b5ea1fb5a7d2d16601e7709dfa14" height="110" width="110" border="0" onerror="return Roblox.Controls.Image.OnError(this)" alt="BLOXikin #31 Headless Horseman" class=" notranslate" /></a>
                                
                            </div>
                            <div class="AssetDetails">
                                <div class="AssetName">
                                    <a id="ctl00_cphRoblox_rbxUserAssetsPane_UserAssetsDataList_ctl09_AssetNameHyperLink" class="noranslate" href="/BLOXikin-31-Headless-Horseman-item?id=133520071">BLOXikin #31 Headless Horseman</a></div>
                                <div class="AssetCreator">
                                    <span class="Label">Creator: </span><span class="Detail notranslate">
                                        <a id="ctl00_cphRoblox_rbxUserAssetsPane_UserAssetsDataList_ctl09_AssetCreatorHyperLink" href="User.aspx?ID=1">ROBLOX</a></span></div>
                                
                                
                                
                            </div>
                        </div>
                    </td><td class="Asset" valign="top">
                        <div style="padding: 5px">
                            <div class="AssetThumbnail">
                                <a id="ctl00_cphRoblox_rbxUserAssetsPane_UserAssetsDataList_ctl10_AssetThumbnailHyperLink" class=" notranslate" title="BLOXikin #26 Bride of Frankenstein" class=" notranslate" href="/BLOXikin-26-Bride-of-Frankenstein-item?id=133520174" style="display:inline-block;height:110px;width:110px;cursor:pointer;"><img src="http://t1.rbxcdn.com/9b7b6a622aa03583ae8f0f08fddc51b3" height="110" width="110" border="0" onerror="return Roblox.Controls.Image.OnError(this)" alt="BLOXikin #26 Bride of Frankenstein" class=" notranslate" /></a>
                                
                            </div>
                            <div class="AssetDetails">
                                <div class="AssetName">
                                    <a id="ctl00_cphRoblox_rbxUserAssetsPane_UserAssetsDataList_ctl10_AssetNameHyperLink" class="noranslate" href="/BLOXikin-26-Bride-of-Frankenstein-item?id=133520174">BLOXikin #26 Bride of Frankenstein</a></div>
                                <div class="AssetCreator">
                                    <span class="Label">Creator: </span><span class="Detail notranslate">
                                        <a id="ctl00_cphRoblox_rbxUserAssetsPane_UserAssetsDataList_ctl10_AssetCreatorHyperLink" href="User.aspx?ID=1">ROBLOX</a></span></div>
                                
                                
                                
                            </div>
                        </div>
                    </td><td class="Asset" valign="top">
                        <div style="padding: 5px">
                            <div class="AssetThumbnail">
                                <a id="ctl00_cphRoblox_rbxUserAssetsPane_UserAssetsDataList_ctl11_AssetThumbnailHyperLink" class=" notranslate" title="BLOXikin #17 Bat Girl ROBLOXian" class=" notranslate" href="/BLOXikin-17-Bat-Girl-ROBLOXian-item?id=133519820" style="display:inline-block;height:110px;width:110px;cursor:pointer;"><img src="http://t5.rbxcdn.com/ba5dc35a62d717adc0ee8b08ea6fbdc0" height="110" width="110" border="0" onerror="return Roblox.Controls.Image.OnError(this)" alt="BLOXikin #17 Bat Girl ROBLOXian" class=" notranslate" /></a>
                                
                            </div>
                            <div class="AssetDetails">
                                <div class="AssetName">
                                    <a id="ctl00_cphRoblox_rbxUserAssetsPane_UserAssetsDataList_ctl11_AssetNameHyperLink" class="noranslate" href="/BLOXikin-17-Bat-Girl-ROBLOXian-item?id=133519820">BLOXikin #17 Bat Girl ROBLOXian</a></div>
                                <div class="AssetCreator">
                                    <span class="Label">Creator: </span><span class="Detail notranslate">
                                        <a id="ctl00_cphRoblox_rbxUserAssetsPane_UserAssetsDataList_ctl11_AssetCreatorHyperLink" href="User.aspx?ID=1">ROBLOX</a></span></div>
                                
                                
                                
                            </div>
                        </div>
                    </td>
		</tr><tr>
			<td class="Asset" valign="top">
                        <div style="padding: 5px">
                            <div class="AssetThumbnail">
                                <a id="ctl00_cphRoblox_rbxUserAssetsPane_UserAssetsDataList_ctl12_AssetThumbnailHyperLink" class=" notranslate" title="BLOXikin #24 Ooze Monster" class=" notranslate" href="/BLOXikin-24-Ooze-Monster-item?id=133520394" style="display:inline-block;height:110px;width:110px;cursor:pointer;"><img src="http://t1.rbxcdn.com/532aba89c5bb167bb45716b132f91fe1" height="110" width="110" border="0" onerror="return Roblox.Controls.Image.OnError(this)" alt="BLOXikin #24 Ooze Monster" class=" notranslate" /></a>
                                
                            </div>
                            <div class="AssetDetails">
                                <div class="AssetName">
                                    <a id="ctl00_cphRoblox_rbxUserAssetsPane_UserAssetsDataList_ctl12_AssetNameHyperLink" class="noranslate" href="/BLOXikin-24-Ooze-Monster-item?id=133520394">BLOXikin #24 Ooze Monster</a></div>
                                <div class="AssetCreator">
                                    <span class="Label">Creator: </span><span class="Detail notranslate">
                                        <a id="ctl00_cphRoblox_rbxUserAssetsPane_UserAssetsDataList_ctl12_AssetCreatorHyperLink" href="User.aspx?ID=1">ROBLOX</a></span></div>
                                
                                
                                
                            </div>
                        </div>
                    </td><td class="Asset" valign="top">
                        <div style="padding: 5px">
                            <div class="AssetThumbnail">
                                <a id="ctl00_cphRoblox_rbxUserAssetsPane_UserAssetsDataList_ctl13_AssetThumbnailHyperLink" class=" notranslate" title="Spooky Tie" class=" notranslate" href="/Spooky-Tie-item?id=129533465" style="display:inline-block;height:110px;width:110px;cursor:pointer;"><img src="http://t6.rbxcdn.com/7b26fd38b438c882eb6185b700786a7b" height="110" width="110" border="0" onerror="return Roblox.Controls.Image.OnError(this)" alt="Spooky Tie" class=" notranslate" /></a>
                                
                            </div>
                            <div class="AssetDetails">
                                <div class="AssetName">
                                    <a id="ctl00_cphRoblox_rbxUserAssetsPane_UserAssetsDataList_ctl13_AssetNameHyperLink" class="noranslate" href="/Spooky-Tie-item?id=129533465">Spooky Tie</a></div>
                                <div class="AssetCreator">
                                    <span class="Label">Creator: </span><span class="Detail notranslate">
                                        <a id="ctl00_cphRoblox_rbxUserAssetsPane_UserAssetsDataList_ctl13_AssetCreatorHyperLink" href="User.aspx?ID=1">ROBLOX</a></span></div>
                                <div id="ctl00_cphRoblox_rbxUserAssetsPane_UserAssetsDataList_ctl13_Div1" class="AssetPrice">
                                    <span class="PriceInRobux notranslate">
                                        R$: 13</span></div>
                                
                                
                            </div>
                        </div>
                    </td><td class="Asset" valign="top">
                        <div style="padding: 5px">
                            <div class="AssetThumbnail">
                                <a id="ctl00_cphRoblox_rbxUserAssetsPane_UserAssetsDataList_ctl14_AssetThumbnailHyperLink" class=" notranslate" title="BLOXikin #08 Black Cat Tarabyte" class=" notranslate" href="/BLOXikin-08-Black-Cat-Tarabyte-item?id=132923240" style="display:inline-block;height:110px;width:110px;cursor:pointer;"><img src="http://t4.rbxcdn.com/6b5a7b1ccdbf64ff94b1fa03cea72915" height="110" width="110" border="0" onerror="return Roblox.Controls.Image.OnError(this)" alt="BLOXikin #08 Black Cat Tarabyte" class=" notranslate" /></a>
                                
                            </div>
                            <div class="AssetDetails">
                                <div class="AssetName">
                                    <a id="ctl00_cphRoblox_rbxUserAssetsPane_UserAssetsDataList_ctl14_AssetNameHyperLink" class="noranslate" href="/BLOXikin-08-Black-Cat-Tarabyte-item?id=132923240">BLOXikin #08 Black Cat Tarabyte</a></div>
                                <div class="AssetCreator">
                                    <span class="Label">Creator: </span><span class="Detail notranslate">
                                        <a id="ctl00_cphRoblox_rbxUserAssetsPane_UserAssetsDataList_ctl14_AssetCreatorHyperLink" href="User.aspx?ID=1">ROBLOX</a></span></div>
                                
                                
                                
                            </div>
                        </div>
                    </td><td class="Asset" valign="top">
                        <div style="padding: 5px">
                            <div class="AssetThumbnail">
                                <a id="ctl00_cphRoblox_rbxUserAssetsPane_UserAssetsDataList_ctl15_AssetThumbnailHyperLink" class=" notranslate" title="BLOXikin #06 Swamp Monster Jeditkacheff" class=" notranslate" href="/BLOXikin-06-Swamp-Monster-Jeditkacheff-item?id=132923132" style="display:inline-block;height:110px;width:110px;cursor:pointer;"><img src="http://t0.rbxcdn.com/54e4dd1693c3f2e4c165f995e007bac7" height="110" width="110" border="0" onerror="return Roblox.Controls.Image.OnError(this)" alt="BLOXikin #06 Swamp Monster Jeditkacheff" class=" notranslate" /></a>
                                
                            </div>
                            <div class="AssetDetails">
                                <div class="AssetName">
                                    <a id="ctl00_cphRoblox_rbxUserAssetsPane_UserAssetsDataList_ctl15_AssetNameHyperLink" class="noranslate" href="/BLOXikin-06-Swamp-Monster-Jeditkacheff-item?id=132923132">BLOXikin #06 Swamp Monster Jeditkacheff</a></div>
                                <div class="AssetCreator">
                                    <span class="Label">Creator: </span><span class="Detail notranslate">
                                        <a id="ctl00_cphRoblox_rbxUserAssetsPane_UserAssetsDataList_ctl15_AssetCreatorHyperLink" href="User.aspx?ID=1">ROBLOX</a></span></div>
                                
                                
                                
                            </div>
                        </div>
                    </td><td class="Asset" valign="top">
                        <div style="padding: 5px">
                            <div class="AssetThumbnail">
                                <a id="ctl00_cphRoblox_rbxUserAssetsPane_UserAssetsDataList_ctl16_AssetThumbnailHyperLink" class=" notranslate" title="BLOXikin #18 Spider ROBLOXian" class=" notranslate" href="/BLOXikin-18-Spider-ROBLOXian-item?id=132923833" style="display:inline-block;height:110px;width:110px;cursor:pointer;"><img src="http://t1.rbxcdn.com/024a924bbb81cfb8a9fb332fc607839b" height="110" width="110" border="0" onerror="return Roblox.Controls.Image.OnError(this)" alt="BLOXikin #18 Spider ROBLOXian" class=" notranslate" /></a>
                                
                            </div>
                            <div class="AssetDetails">
                                <div class="AssetName">
                                    <a id="ctl00_cphRoblox_rbxUserAssetsPane_UserAssetsDataList_ctl16_AssetNameHyperLink" class="noranslate" href="/BLOXikin-18-Spider-ROBLOXian-item?id=132923833">BLOXikin #18 Spider ROBLOXian</a></div>
                                <div class="AssetCreator">
                                    <span class="Label">Creator: </span><span class="Detail notranslate">
                                        <a id="ctl00_cphRoblox_rbxUserAssetsPane_UserAssetsDataList_ctl16_AssetCreatorHyperLink" href="User.aspx?ID=1">ROBLOX</a></span></div>
                                
                                
                                
                            </div>
                        </div>
                    </td><td class="Asset" valign="top">
                        <div style="padding: 5px">
                            <div class="AssetThumbnail">
                                <a id="ctl00_cphRoblox_rbxUserAssetsPane_UserAssetsDataList_ctl17_AssetThumbnailHyperLink" class=" notranslate" title="BLOXikin #02 Vampire Shedletsky" class=" notranslate" href="/BLOXikin-02-Vampire-Shedletsky-item?id=132923524" style="display:inline-block;height:110px;width:110px;cursor:pointer;"><img src="http://t3.rbxcdn.com/0ec5f0e11776b3893f9f4ba467c33c93" height="110" width="110" border="0" onerror="return Roblox.Controls.Image.OnError(this)" alt="BLOXikin #02 Vampire Shedletsky" class=" notranslate" /></a>
                                
                            </div>
                            <div class="AssetDetails">
                                <div class="AssetName">
                                    <a id="ctl00_cphRoblox_rbxUserAssetsPane_UserAssetsDataList_ctl17_AssetNameHyperLink" class="noranslate" href="/BLOXikin-02-Vampire-Shedletsky-item?id=132923524">BLOXikin #02 Vampire Shedletsky</a></div>
                                <div class="AssetCreator">
                                    <span class="Label">Creator: </span><span class="Detail notranslate">
                                        <a id="ctl00_cphRoblox_rbxUserAssetsPane_UserAssetsDataList_ctl17_AssetCreatorHyperLink" href="User.aspx?ID=1">ROBLOX</a></span></div>
                                
                                
                                
                            </div>
                        </div>
                    </td>
		</tr>
	</table>
                <div id="ctl00_cphRoblox_rbxUserAssetsPane_FooterPagerPanel" class="FooterPager" style="width: 780px">
                    <span class="pager previous disabled"></span>
                    
                    <span id="ctl00_cphRoblox_rbxUserAssetsPane_FooterPagerLabel" style="vertical-align: top; display: inline-block; padding: 5px; padding-top: 6px">Page 1 of 9</span>
                    <a id="ctl00_cphRoblox_rbxUserAssetsPane_FooterPageSelector_Next" href="javascript:WebForm_DoPostBackWithOptions(new WebForm_PostBackOptions(&quot;ctl00$cphRoblox$rbxUserAssetsPane$FooterPageSelector_Next&quot;, &quot;&quot;, true, &quot;&quot;, &quot;&quot;, false, true))"><span class="pager next"></span></a>
                    
                </div>
                <div style="width:784px;">
                    
    <h3 class="RecommendationHeader2">
        Recommended Hats
        <a href='/Catalog/' >See All <span>&#187;</span></a>
    </h3>


    <div class="AssetRecommenderContainer">
    <table id="ctl00_cphRoblox_rbxUserAssetsPane_AssetRec_dlAssets" cellspacing="0" align="Center" border="0" style="height:175px;width:784px;border-collapse:collapse;">
		<tr>
			<td>
            <div class="PortraitDiv" style="width: 140px;overflow: hidden;margin:auto;" visible="True" data-se="recommended-items-0">
                <div class="AssetThumbnail">
                    <a id="ctl00_cphRoblox_rbxUserAssetsPane_AssetRec_dlAssets_ctl00_AssetThumbnailHyperLink" class=" notranslate" title="Normal Hair" class=" notranslate" href="/Normal-Hair-item?id=20643008" style="display:inline-block;height:110px;width:110px;cursor:pointer;"><img src="http://t2.rbxcdn.com/ebbd952de47e3d45d4a52865a7259871" height="110" width="110" border="0" onerror="return Roblox.Controls.Image.OnError(this)" alt="Normal Hair" class=" notranslate" /></a>
                </div>
                <div class="AssetDetails">
                    <div class="AssetName noTranslate">
                        <a id="ctl00_cphRoblox_rbxUserAssetsPane_AssetRec_dlAssets_ctl00_AssetNameHyperLinkPortrait" href="/Normal-Hair-item?id=20643008">Normal Hair</a>
                    </div>
                    <div class="AssetCreator">
                        <span class="stat-label">Creator:</span> <span class="Detail stat"><a id="ctl00_cphRoblox_rbxUserAssetsPane_AssetRec_dlAssets_ctl00_CreatorHyperLinkPortrait" class="notranslate" href="User.aspx?ID=1">ROBLOX</a></span>
                    </div>
                </div>
            </div>
        </td><td>
            <div class="PortraitDiv" style="width: 140px;overflow: hidden;margin:auto;" visible="True" data-se="recommended-items-1">
                <div class="AssetThumbnail">
                    <a id="ctl00_cphRoblox_rbxUserAssetsPane_AssetRec_dlAssets_ctl01_AssetThumbnailHyperLink" class=" notranslate" title="Summertime R&amp;R&amp;R 2010" class=" notranslate" href="/Summertime-R-R-R-2010-item?id=29294506" style="display:inline-block;height:110px;width:110px;cursor:pointer;"><img src="http://t4.rbxcdn.com/23121e289500dd2131896abdb42e7051" height="110" width="110" border="0" onerror="return Roblox.Controls.Image.OnError(this)" alt="Summertime R&amp;R&amp;R 2010" class=" notranslate" /></a>
                </div>
                <div class="AssetDetails">
                    <div class="AssetName noTranslate">
                        <a id="ctl00_cphRoblox_rbxUserAssetsPane_AssetRec_dlAssets_ctl01_AssetNameHyperLinkPortrait" href="/Summertime-R-R-R-2010-item?id=29294506">Summertime R&amp;R&amp;R 2010</a>
                    </div>
                    <div class="AssetCreator">
                        <span class="stat-label">Creator:</span> <span class="Detail stat"><a id="ctl00_cphRoblox_rbxUserAssetsPane_AssetRec_dlAssets_ctl01_CreatorHyperLinkPortrait" class="notranslate" href="User.aspx?ID=1">ROBLOX</a></span>
                    </div>
                </div>
            </div>
        </td><td>
            <div class="PortraitDiv" style="width: 140px;overflow: hidden;margin:auto;" visible="True" data-se="recommended-items-2">
                <div class="AssetThumbnail">
                    <a id="ctl00_cphRoblox_rbxUserAssetsPane_AssetRec_dlAssets_ctl02_AssetThumbnailHyperLink" class=" notranslate" title="Fez" class=" notranslate" href="/Fez-item?id=10911974" style="display:inline-block;height:110px;width:110px;cursor:pointer;"><img src="http://t7.rbxcdn.com/23ecf26b13aec78e7393d7d343475928" height="110" width="110" border="0" onerror="return Roblox.Controls.Image.OnError(this)" alt="Fez" class=" notranslate" /></a>
                </div>
                <div class="AssetDetails">
                    <div class="AssetName noTranslate">
                        <a id="ctl00_cphRoblox_rbxUserAssetsPane_AssetRec_dlAssets_ctl02_AssetNameHyperLinkPortrait" href="/Fez-item?id=10911974">Fez</a>
                    </div>
                    <div class="AssetCreator">
                        <span class="stat-label">Creator:</span> <span class="Detail stat"><a id="ctl00_cphRoblox_rbxUserAssetsPane_AssetRec_dlAssets_ctl02_CreatorHyperLinkPortrait" class="notranslate" href="User.aspx?ID=1">ROBLOX</a></span>
                    </div>
                </div>
            </div>
        </td><td>
            <div class="PortraitDiv" style="width: 140px;overflow: hidden;margin:auto;" visible="True" data-se="recommended-items-3">
                <div class="AssetThumbnail">
                    <a id="ctl00_cphRoblox_rbxUserAssetsPane_AssetRec_dlAssets_ctl03_AssetThumbnailHyperLink" class=" notranslate" title="Mongolian Hat" class=" notranslate" href="/Mongolian-Hat-item?id=10911982" style="display:inline-block;height:110px;width:110px;cursor:pointer;"><img src="http://t6.rbxcdn.com/81b5c08830e2c4b142303e1e08e80475" height="110" width="110" border="0" onerror="return Roblox.Controls.Image.OnError(this)" alt="Mongolian Hat" class=" notranslate" /></a>
                </div>
                <div class="AssetDetails">
                    <div class="AssetName noTranslate">
                        <a id="ctl00_cphRoblox_rbxUserAssetsPane_AssetRec_dlAssets_ctl03_AssetNameHyperLinkPortrait" href="/Mongolian-Hat-item?id=10911982">Mongolian Hat</a>
                    </div>
                    <div class="AssetCreator">
                        <span class="stat-label">Creator:</span> <span class="Detail stat"><a id="ctl00_cphRoblox_rbxUserAssetsPane_AssetRec_dlAssets_ctl03_CreatorHyperLinkPortrait" class="notranslate" href="User.aspx?ID=1">ROBLOX</a></span>
                    </div>
                </div>
            </div>
        </td><td>
            <div class="PortraitDiv" style="width: 140px;overflow: hidden;margin:auto;" visible="True" data-se="recommended-items-4">
                <div class="AssetThumbnail">
                    <a id="ctl00_cphRoblox_rbxUserAssetsPane_AssetRec_dlAssets_ctl04_AssetThumbnailHyperLink" class=" notranslate" title="Canvas Cap" class=" notranslate" href="/Canvas-Cap-item?id=57596936" style="display:inline-block;height:110px;width:110px;cursor:pointer;"><img src="http://t0.rbxcdn.com/e8023df6d8fed4e4141d808760a17d30" height="110" width="110" border="0" onerror="return Roblox.Controls.Image.OnError(this)" alt="Canvas Cap" class=" notranslate" /></a>
                </div>
                <div class="AssetDetails">
                    <div class="AssetName noTranslate">
                        <a id="ctl00_cphRoblox_rbxUserAssetsPane_AssetRec_dlAssets_ctl04_AssetNameHyperLinkPortrait" href="/Canvas-Cap-item?id=57596936">Canvas Cap</a>
                    </div>
                    <div class="AssetCreator">
                        <span class="stat-label">Creator:</span> <span class="Detail stat"><a id="ctl00_cphRoblox_rbxUserAssetsPane_AssetRec_dlAssets_ctl04_CreatorHyperLinkPortrait" class="notranslate" href="User.aspx?ID=1">ROBLOX</a></span>
                    </div>
                </div>
            </div>
        </td>
		</tr><tr>
			<td>
            <div class="PortraitDiv" style="width: 140px;overflow: hidden;margin:auto;" visible="True" data-se="recommended-items-5">
                <div class="AssetThumbnail">
                    <a id="ctl00_cphRoblox_rbxUserAssetsPane_AssetRec_dlAssets_ctl05_AssetThumbnailHyperLink" class=" notranslate" title="Adventure Time Jake Hat" class=" notranslate" href="/Adventure-Time-Jake-Hat-item?id=129554183" style="display:inline-block;height:110px;width:110px;cursor:pointer;"><img src="http://t6.rbxcdn.com/ad41a12fe400ba8bd6f59382c4bd4dfc" height="110" width="110" border="0" onerror="return Roblox.Controls.Image.OnError(this)" alt="Adventure Time Jake Hat" class=" notranslate" /></a>
                </div>
                <div class="AssetDetails">
                    <div class="AssetName noTranslate">
                        <a id="ctl00_cphRoblox_rbxUserAssetsPane_AssetRec_dlAssets_ctl05_AssetNameHyperLinkPortrait" href="/Adventure-Time-Jake-Hat-item?id=129554183">Adventure Time Jake Hat</a>
                    </div>
                    <div class="AssetCreator">
                        <span class="stat-label">Creator:</span> <span class="Detail stat"><a id="ctl00_cphRoblox_rbxUserAssetsPane_AssetRec_dlAssets_ctl05_CreatorHyperLinkPortrait" class="notranslate" href="User.aspx?ID=1">ROBLOX</a></span>
                    </div>
                </div>
            </div>
        </td><td>
            <div class="PortraitDiv" style="width: 140px;overflow: hidden;margin:auto;" visible="True" data-se="recommended-items-6">
                <div class="AssetThumbnail">
                    <a id="ctl00_cphRoblox_rbxUserAssetsPane_AssetRec_dlAssets_ctl06_AssetThumbnailHyperLink" class=" notranslate" title="Backwards &#39;R&#39; Cap" class=" notranslate" href="/Backwards-R-Cap-item?id=17903982" style="display:inline-block;height:110px;width:110px;cursor:pointer;"><img src="http://t2.rbxcdn.com/c69e14cc9c627268e063e1f4ba513ee6" height="110" width="110" border="0" onerror="return Roblox.Controls.Image.OnError(this)" alt="Backwards &#39;R&#39; Cap" class=" notranslate" /></a>
                </div>
                <div class="AssetDetails">
                    <div class="AssetName noTranslate">
                        <a id="ctl00_cphRoblox_rbxUserAssetsPane_AssetRec_dlAssets_ctl06_AssetNameHyperLinkPortrait" href="/Backwards-R-Cap-item?id=17903982">Backwards &#39;R&#39; Cap</a>
                    </div>
                    <div class="AssetCreator">
                        <span class="stat-label">Creator:</span> <span class="Detail stat"><a id="ctl00_cphRoblox_rbxUserAssetsPane_AssetRec_dlAssets_ctl06_CreatorHyperLinkPortrait" class="notranslate" href="User.aspx?ID=1">ROBLOX</a></span>
                    </div>
                </div>
            </div>
        </td><td>
            <div class="PortraitDiv" style="width: 140px;overflow: hidden;margin:auto;" visible="True" data-se="recommended-items-7">
                <div class="AssetThumbnail">
                    <a id="ctl00_cphRoblox_rbxUserAssetsPane_AssetRec_dlAssets_ctl07_AssetThumbnailHyperLink" class=" notranslate" title="Trojan Infantry Helmet" class=" notranslate" href="/Trojan-Infantry-Helmet-item?id=10546552" style="display:inline-block;height:110px;width:110px;cursor:pointer;"><img src="http://t1.rbxcdn.com/8948c7c7830bcce040a2f7852a4027db" height="110" width="110" border="0" onerror="return Roblox.Controls.Image.OnError(this)" alt="Trojan Infantry Helmet" class=" notranslate" /></a>
                </div>
                <div class="AssetDetails">
                    <div class="AssetName noTranslate">
                        <a id="ctl00_cphRoblox_rbxUserAssetsPane_AssetRec_dlAssets_ctl07_AssetNameHyperLinkPortrait" href="/Trojan-Infantry-Helmet-item?id=10546552">Trojan Infantry Helmet</a>
                    </div>
                    <div class="AssetCreator">
                        <span class="stat-label">Creator:</span> <span class="Detail stat"><a id="ctl00_cphRoblox_rbxUserAssetsPane_AssetRec_dlAssets_ctl07_CreatorHyperLinkPortrait" class="notranslate" href="User.aspx?ID=1">ROBLOX</a></span>
                    </div>
                </div>
            </div>
        </td><td>
            <div class="PortraitDiv" style="width: 140px;overflow: hidden;margin:auto;" visible="True" data-se="recommended-items-8">
                <div class="AssetThumbnail">
                    <a id="ctl00_cphRoblox_rbxUserAssetsPane_AssetRec_dlAssets_ctl08_AssetThumbnailHyperLink" class=" notranslate" title="Zipper Cap" class=" notranslate" href="/Zipper-Cap-item?id=51245998" style="display:inline-block;height:110px;width:110px;cursor:pointer;"><img src="http://t5.rbxcdn.com/d2ed42fcb3b261f97ef849bb2021f100" height="110" width="110" border="0" onerror="return Roblox.Controls.Image.OnError(this)" alt="Zipper Cap" class=" notranslate" /></a>
                </div>
                <div class="AssetDetails">
                    <div class="AssetName noTranslate">
                        <a id="ctl00_cphRoblox_rbxUserAssetsPane_AssetRec_dlAssets_ctl08_AssetNameHyperLinkPortrait" href="/Zipper-Cap-item?id=51245998">Zipper Cap</a>
                    </div>
                    <div class="AssetCreator">
                        <span class="stat-label">Creator:</span> <span class="Detail stat"><a id="ctl00_cphRoblox_rbxUserAssetsPane_AssetRec_dlAssets_ctl08_CreatorHyperLinkPortrait" class="notranslate" href="User.aspx?ID=1">ROBLOX</a></span>
                    </div>
                </div>
            </div>
        </td><td>
            <div class="PortraitDiv" style="width: 140px;overflow: hidden;margin:auto;" visible="True" data-se="recommended-items-9">
                <div class="AssetThumbnail">
                    <a id="ctl00_cphRoblox_rbxUserAssetsPane_AssetRec_dlAssets_ctl09_AssetThumbnailHyperLink" class=" notranslate" title="Dr. Atomic&#39;s Mesmerizing Quantodrome" class=" notranslate" href="/Dr-Atomics-Mesmerizing-Quantodrome-item?id=10914012" style="display:inline-block;height:110px;width:110px;cursor:pointer;"><img src="http://t5.rbxcdn.com/1edd14ac1d9997613f483de165dd8f9c" height="110" width="110" border="0" onerror="return Roblox.Controls.Image.OnError(this)" alt="Dr. Atomic&#39;s Mesmerizing Quantodrome" class=" notranslate" /></a>
                </div>
                <div class="AssetDetails">
                    <div class="AssetName noTranslate">
                        <a id="ctl00_cphRoblox_rbxUserAssetsPane_AssetRec_dlAssets_ctl09_AssetNameHyperLinkPortrait" href="/Dr-Atomics-Mesmerizing-Quantodrome-item?id=10914012">Dr. Atomic&#39;s Mesmerizing Quantodrome</a>
                    </div>
                    <div class="AssetCreator">
                        <span class="stat-label">Creator:</span> <span class="Detail stat"><a id="ctl00_cphRoblox_rbxUserAssetsPane_AssetRec_dlAssets_ctl09_CreatorHyperLinkPortrait" class="notranslate" href="User.aspx?ID=1">ROBLOX</a></span>
                    </div>
                </div>
            </div>
        </td>
		</tr>
	</table>
    
</div>

<script type="text/javascript">
    $(function () {
        var itemNames = $('.PortraitDiv .AssetDetails .AssetName a');
        $.each(itemNames, function (index) {
            var elem = $(itemNames[index]);
            elem.html(fitStringToWidthSafe(elem.html(), 200));
        });
        var userNames = $('.PortraitDiv .AssetDetails .AssetCreator .Detail a');
        $.each(userNames, function (index) {
            var elem = $(userNames[index]);
            elem.html(fitStringToWidthSafe(elem.html(), 70));
        });
    });
</script>

                </div>
            </div>
            <div style="clear: both;">
            </div>
        </div>
        <div id="ctl00_cphRoblox_rbxUserAssetsPane_CreateSetPanelDiv" class="createSetPanelPopup" style="width: 400px; height: 100%; padding: 0px; float: left; display: none">
		
            
        
	</div>

    
</div>
        </div>
    </div>
    

                <div style="clear:both"></div>
            </div>
        </div></div> 
        </div>
<?php
$_PS->FooterJS = "if(typeof __utmSetVar !== 'undefined'){ __utmSetVar(''); }if(typeof __utmSetVar !== 'undefined'){ __utmSetVar('Roblox_User_Top_728x90'); }Roblox.Controls.Image.ErrorUrl = \"http://www.roblox.com/Analytics/BadHtmlImage.ashx\";$(function () { $('.VisitButtonPlay').click(function () {play_placeId=$(this).attr('placeid');Roblox.CharacterSelect.placeid = play_placeId;Roblox.CharacterSelect.show();});$('.VisitButtonPersonalServer').click(function () {play_placeId=$(this).attr('placeid');Roblox.CharacterSelect.placeid = play_placeId;Roblox.CharacterSelect.show();});$('.VisitButtonSoloPlay').click(function () {RobloxLaunch._GoogleAnalyticsCallback = function() { var isInsideRobloxIDE = 'website'; if (Roblox && Roblox.Client && Roblox.Client.isIDE && Roblox.Client.isIDE()) { isInsideRobloxIDE = 'Studio'; };GoogleAnalyticsEvents.FireEvent(['PlaySolo Location', 'Guest', isInsideRobloxIDE]);GoogleAnalyticsEvents.FireEvent(['PlaySolo', 'Guest', '']); }; play_placeId = (typeof $(this).attr('placeid') === 'undefined') ? play_placeId : $(this).attr('placeid'); Roblox.Client.WaitForRoblox(function() { window.location = '/Login/Default.aspx?ReturnUrl=http%3a%2f%2fwww.roblox.com%2fUser.aspx%3fID%3d".$uinfo->id."' }); return false;});$('.VisitButtonBuild').click(function () {RobloxLaunch._GoogleAnalyticsCallback = function() { var isInsideRobloxIDE = 'website'; if (Roblox && Roblox.Client && Roblox.Client.isIDE && Roblox.Client.isIDE()) { isInsideRobloxIDE = 'Studio'; };GoogleAnalyticsEvents.FireEvent(['Build Location', 'Guest', isInsideRobloxIDE]);GoogleAnalyticsEvents.FireEvent(['Build', 'Guest', '']); }; play_placeId = (typeof $(this).attr('placeid') === 'undefined') ? play_placeId : $(this).attr('placeid'); Roblox.Client.WaitForRoblox(function() { window.location = '/Login/Default.aspx?ReturnUrl=http%3a%2f%2fwww.roblox.com%2fUser.aspx%3fID%3d1' }); return false;});$('.VisitButtonEdit').click(function () {RobloxLaunch._GoogleAnalyticsCallback = function() { var isInsideRobloxIDE = 'website'; if (Roblox && Roblox.Client && Roblox.Client.isIDE && Roblox.Client.isIDE()) { isInsideRobloxIDE = 'Studio'; };GoogleAnalyticsEvents.FireEvent(['Edit Location', 'Guest', isInsideRobloxIDE]);GoogleAnalyticsEvents.FireEvent(['Edit', 'Guest', '']); }; play_placeId = (typeof $(this).attr('placeid') === 'undefined') ? play_placeId : $(this).attr('placeid'); Roblox.Client.WaitForRoblox(function() { RobloxLaunch.StartGame('http://www.roblox.com//Game/edit.ashx?PlaceID='+play_placeId+'&upload=', 'edit.ashx', 'https://www.roblox.com//Login/Negotiate.ashx', 'FETCH', true) }); return false;});Roblox.CharacterSelect.robloxLaunchFunction = function (genderTypeID) { if (genderTypeID == 3) { var isInsideRobloxIDE = 'website'; if (Roblox && Roblox.Client && Roblox.Client.isIDE && Roblox.Client.isIDE()) { isInsideRobloxIDE = 'Studio'; };GoogleAnalyticsEvents.FireEvent(['Play Location', 'Guest', isInsideRobloxIDE]);GoogleAnalyticsEvents.FireEvent(['Play', 'Guest', '', 0]);$(function(){ RobloxEventManager.triggerEvent('rbx_evt_play_guest', {age:'Unknown',gender:'Female'});});} else { var isInsideRobloxIDE = 'website'; if (Roblox && Roblox.Client && Roblox.Client.isIDE && Roblox.Client.isIDE()) { isInsideRobloxIDE = 'Studio'; };GoogleAnalyticsEvents.FireEvent(['Play Location', 'Guest', isInsideRobloxIDE]);GoogleAnalyticsEvents.FireEvent(['Play', 'Guest', '', 1]);$(function(){ RobloxEventManager.triggerEvent('rbx_evt_play_guest', {age:'Unknown',gender:'Male'});});}play_placeId = (typeof $(this).attr('placeid') === 'undefined') ? play_placeId : $(this).attr('placeid'); Roblox.Client.WaitForRoblox(function() { RobloxLaunch.RequestGame('PlaceLauncherStatusPanel', play_placeId, genderTypeID); }); return false;};});if(typeof __utmSetVar !== 'undefined'){ __utmSetVar('Roblox_User_Middle_300x250'); }";
require_once($_SERVER["STATIC"]."/footer.php");
?>
