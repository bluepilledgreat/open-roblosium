<?php
// ROBLOSIUM 2013
require_once($_SERVER["STATIC"]."/settings.php");
require_once($_SERVER["STATIC"]."/package_compiler.php");
require_once($_SERVER["STATIC"]."/authentication.php");
require_once($_SERVER["STATIC"]."/friends.php");
if ($userAuth === false)
	die(header("Location: /NewLogin"));
AddCSS(CSS_DEFAULT_PACKAGE);
AddCSS(PackageCompiler::CompilePackage("page", ["/CSS/Pages/CashOut/CashOut.css", "/CSS/PartialViews/Navigation.css", "/CSS/Pages/Friends.css"], null));
AddJS(JS_DEFAULT_PACKAGE);
AddJS(PackageCompiler::CompilePackage("page", ["/js/jquery.validate.js", "/js/jquery.validate.unobtrusive.js", "/js/GenericModal.js", "/js/SignupFormValidator.js", "/js/Modules/Widgets/Tabs.js", "/js/Modules/Widgets/AvatarImage.js", "/js/Modules/Widgets/DropdownMenu.js", "/js/Friends.js", "/js/AddEmail.js", "/js/SuperSafePrivacyIndicator.js", "/js/GenericConfirmation.js"], null));
$_PS->SubmenuEnabled = true;
require_once($_SERVER["STATIC"]."/header.php");

// friends
$Friends = new Friends(0, $userAuth->GetUserInfo("id"));
$friendCount = $Friends->GetCount();
$friendRequestCount = $Friends->GetCount(1);
$bestFriendCount = $Friends->GetCount(3);
?>
<div id="BodyWrapper">
            <div id="RepositionBody">
                <div id="Body" style="width:970px;">
                    
    <style type="text/css">
        #Body {
            padding: 10px;
        }
    </style>
    
    <h1>My Friends</h1>
<div id="FriendTabs" class="tab-container tab-history-hash">
    <div class="tab-active">Friends</div>
	<div>Best Friends</div>
                <div>Friend Requests</div>
</div>
<div>
    <div id="FriendsTab" class="tab-active">
<div class="friends-container">
<?php 
	// friends list
	if($friendCount > 0)
	{
	$stmt = $conn->prepare("SELECT * FROM friends WHERE ((sender = :t1) OR (receiver = :t2)) AND status = 2 LIMIT 35");
	$stmt->bindValue(":t1", $userAuth->GetUserInfo("id"), PDO::PARAM_INT);
	$stmt->bindValue(":t2", $userAuth->GetUserInfo("id"), PDO::PARAM_INT);
	$stmt->execute();

	foreach($stmt->fetchAll(PDO::FETCH_OBJ) as $friend) { 
	
	// get user info
	$f_uinfo = (new UserAuthentication(($friend->sender == $userAuth->GetUserInfo("id")) ? $friend->receiver : $friend->sender))->GetAllUserInfo();
	
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
			$_PS->EnableOBCTheme = true;
			break;
	}
	
	?>
		<div class="friend-container notranslate">
            <div class="friend-hover">
                    <div class="friend-dropdown">
                        <div class="dropdown">
                            <div class="button gear"></div>
                            <ul class="dropdown-list">
								<li>
                                    <a class="add-best-friend" data-target-user-id="<?php echo $f_uinfo->id; ?>" data-view="Friends" data-page-num="1" data-displayed-user-id="<?php echo $userAuth->GetUserInfo("id"); ?>">Add Best Friend</a>
                                </li>
                                <li>
                                    <a class="remove-friend" data-target-user-name="<?php echo $f_uinfo->username; ?>" data-target-user-id="<?php echo $f_uinfo->id; ?>" data-view="Friends" data-page-num="1" data-displayed-user-id="<?php echo $userAuth->GetUserInfo("id"); ?>">Remove Friend</a>
                                </li>
                            </ul>
                        </div>
                    </div>
                <div class="friend-avatar">
                    <a class="roblox-avatar-image" data-user-id="<?php echo $f_uinfo->id; ?>" data-image-size="small" href="/User.aspx?ID=<?php echo $f_uinfo->id; ?>">
					<img src="/images/boy_guest.png" height="100" width="100" border="0" onerror="return Roblox.Controls.Image.OnError(this)" alt="<?php echo $f_uinfo->username; ?>" class=" notranslate" />
				<?php if ($f_icon != null) echo '<img src="/images/icons/'.$f_icon.'" align="left" style="position:relative;top:-19px;" />'; ?></a>
                </div>
            </div>
            <div class="friend-name" style="position:absolute;width: 102px;">
                <img src="/images/offline.png" alt="">
                <a class="text-link" title="<?php echo $f_uinfo->username; ?>" href="/User.aspx?ID=<?php echo $f_uinfo->id; ?>"><?php echo $f_uinfo->username; ?></a>
            </div>
        </div>
	<?php 
	
	}
	} else { ?>
		<h3><a href="/browse.aspx">Find your friends</a> on ROBLOX</h3>
<?php } ?>
</div>
</div>

<div id="BestFriendsTab">

<div class="friends-container">
<?php 
	// best friend list
	if($bestFriendCount > 0)
	{
	$stmt = $conn->prepare("SELECT * FROM friends WHERE ((sender = :t1) OR (receiver = :t2)) AND status = 3 LIMIT 35");
	$stmt->bindValue(":t1", $userAuth->GetUserInfo("id"), PDO::PARAM_INT);
	$stmt->bindValue(":t2", $userAuth->GetUserInfo("id"), PDO::PARAM_INT);
	$stmt->execute();

	foreach($stmt->fetchAll(PDO::FETCH_OBJ) as $friend) { 
	
	// get user info
	$f_uinfo = (new UserAuthentication(($friend->sender == $userAuth->GetUserInfo("id")) ? $friend->receiver : $friend->sender))->GetAllUserInfo();
	
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
			$_PS->EnableOBCTheme = true;
			break;
	}
	
	?>
		<div class="friend-container notranslate">
            <div class="friend-hover">
                    <div class="friend-dropdown">
                        <div class="dropdown">
                            <div class="button gear"></div>
                            <ul class="dropdown-list">
                                <li>
                                    <a class="remove-best-friend" data-target-user-id="<?php echo $f_uinfo->id; ?>" data-view="BestFriends" data-page-num="1" data-displayed-user-id="<?php echo $userAuth->GetUserInfo("id"); ?>">Remove Best Friend</a>
                                </li>
								<li>
                                    <a class="remove-friend" data-target-user-name="<?php echo $f_uinfo->username; ?>" data-target-user-id="<?php echo $f_uinfo->id; ?>" data-view="Friends" data-page-num="1" data-displayed-user-id="<?php echo $userAuth->GetUserInfo("id"); ?>">Remove Friend</a>
                                </li>
                            </ul>
                        </div>
                    </div>
                <div class="friend-avatar">
                    <a class="roblox-avatar-image" data-user-id="<?php echo $f_uinfo->id; ?>" data-image-size="small" href="/User.aspx?ID=<?php echo $f_uinfo->id; ?>">
					<img src="/images/boy_guest.png" height="100" width="100" border="0" onerror="return Roblox.Controls.Image.OnError(this)" alt="<?php echo $f_uinfo->username; ?>" class=" notranslate" />
				<?php if ($f_icon != null) echo '<img src="/images/icons/'.$f_icon.'" align="left" style="position:relative;top:-19px;" />'; ?></a>
                </div>
            </div>
            <div class="friend-name" style="position:absolute;width: 102px;">
                <img src="/images/offline.png" alt="">
                <a class="text-link" title="<?php echo $f_uinfo->username; ?>" href="/User.aspx?ID=<?php echo $f_uinfo->id; ?>"><?php echo $f_uinfo->username; ?></a>
            </div>
        </div>
	<?php 
	}
	} else { ?>
		<h3><a href="/browse.aspx">Find your friends</a> on ROBLOX</h3>
<?php } ?>
</div>
<div class="friends-pager">
</div>

<script type="text/javascript">
     Roblox.Friends = Roblox.Friends || {};
     //<sl:translate>
     Roblox.Friends.Resources = {
         FeatureDisabled: "Feature Disabled",
         AddFriendsDisabled: "Adding friends is currently disabled.",
         RemoveFriend: "Remove Friend",
         RemoveFriendMessage: "Are you sure you want to remove {0} as a friend?"
     };
 //</sl:translate>
</script>



<div class="GenericModal modalPopup unifiedModal smallModal" style="display:none;">
    <div class="Title"></div>
    <div class="GenericModalBody">
        <div>
            <div class="ImageContainer">
                <img class="GenericModalImage" alt="generic image">
            </div>
            <div class="Message"></div>
        </div>
        <div class="clear"></div>
        <div id="GenericModalButtonContainer" class="GenericModalButtonContainer">
            <a class="ImageButton btn-neutral btn-large roblox-ok">OK<span class="btn-text">OK</span></a>
        </div>  
    </div>
</div>

<script type="text/javascript">
    Roblox = Roblox || {};
    Roblox.GenericModal = Roblox.GenericModal || {};

    Roblox.GenericModal.Resources = {
        //<sl:translate>
        ErrorText: 'Error'
        , ErrorMessage: 'Sorry, an error occurred.'
        //</sl:translate>
    };
</script></div>
       
                <div id="FriendRequestsTab">

<div class="friends-container">
<?php 
	// friend request list
	if($friendRequestCount > 0)
	{
	$stmt = $conn->prepare("SELECT * FROM friends WHERE receiver = :t1 AND status = 1 LIMIT 35");
	$stmt->bindValue(":t1", $userAuth->GetUserInfo("id"), PDO::PARAM_INT);
	$stmt->execute();

	foreach($stmt->fetchAll(PDO::FETCH_OBJ) as $friend) { 
	
	// get user info
	$f_uinfo = (new UserAuthentication(($friend->sender == $userAuth->GetUserInfo("id")) ? $friend->receiver : $friend->sender))->GetAllUserInfo();
	
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
			$_PS->EnableOBCTheme = true;
			break;
	}
	
	?>
		<div class="friend-container notranslate">
            <div class="friend-hover">
                    <div class="friend-dropdown">
                        <div class="dropdown">
                            <div class="button gear"></div>
                            <ul class="dropdown-list">
                                <li>
                                    <a class="accept-friend" data-target-user-name="<?php echo $f_uinfo->username; ?>" data-target-user-id="<?php echo $f_uinfo->id; ?>" data-view="Friends" data-page-num="1" data-displayed-user-id="<?php echo $userAuth->GetUserInfo("id"); ?>">Accept Friend</a>
                                </li>
								<li>
                                    <a class="decline-friend" data-target-user-name="<?php echo $f_uinfo->username; ?>" data-target-user-id="<?php echo $f_uinfo->id; ?>" data-view="Friends" data-page-num="1" data-displayed-user-id="<?php echo $userAuth->GetUserInfo("id"); ?>">Decline Friend</a>
                                </li>
                            </ul>
                        </div>
                    </div>
                <div class="friend-avatar">
                    <a class="roblox-avatar-image" data-user-id="<?php echo $f_uinfo->id; ?>" data-image-size="small" href="/User.aspx?ID=<?php echo $f_uinfo->id; ?>">
					<img src="/images/boy_guest.png" height="100" width="100" border="0" onerror="return Roblox.Controls.Image.OnError(this)" alt="<?php echo $f_uinfo->username; ?>" class=" notranslate" />
				<?php if ($f_icon != null) echo '<img src="/images/icons/'.$f_icon.'" align="left" style="position:relative;top:-19px;" />'; ?></a>
                </div>
            </div>
            <div class="friend-name" style="position:absolute;width: 102px;">
                <img src="/images/offline.png" alt="">
                <a class="text-link" title="<?php echo $f_uinfo->username; ?>" href="/User.aspx?ID=<?php echo $f_uinfo->id; ?>"><?php echo $f_uinfo->username; ?></a>
            </div>
        </div>
	<?php 
	}
	} else { ?>
		<h3><a href="/browse.aspx">Find your friends</a> on ROBLOX</h3>
<?php } ?>
</div>
<div class="friends-pager">
</div>

<script type="text/javascript">
     Roblox.Friends = Roblox.Friends || {};
     //<sl:translate>
     Roblox.Friends.Resources = {
         FeatureDisabled: "Feature Disabled",
         AddFriendsDisabled: "Adding friends is currently disabled.",
         RemoveFriend: "Remove Friend",
         RemoveFriendMessage: "Are you sure you want to remove {0} as a friend?"
     };
 //</sl:translate>
</script>



<div class="GenericModal modalPopup unifiedModal smallModal" style="display:none;">
    <div class="Title"></div>
    <div class="GenericModalBody">
        <div>
            <div class="ImageContainer">
                <img class="GenericModalImage" alt="generic image">
            </div>
            <div class="Message"></div>
        </div>
        <div class="clear"></div>
        <div id="GenericModalButtonContainer" class="GenericModalButtonContainer">
            <a class="ImageButton btn-neutral btn-large roblox-ok">OK<span class="btn-text">OK</span></a>
        </div>  
    </div>
</div>

<script type="text/javascript">
    Roblox = Roblox || {};
    Roblox.GenericModal = Roblox.GenericModal || {};

    Roblox.GenericModal.Resources = {
        //<sl:translate>
        ErrorText: 'Error'
        , ErrorMessage: 'Sorry, an error occurred.'
        //</sl:translate>
    };
</script></div>
</div>
<script type="text/javascript">
    InitializeFriends(false, false, false);
</script>
                    <div style="clear:both"></div>
                </div>
            </div>
        </div>
<?php
require_once($_SERVER["STATIC"]."/footer.php");
?>