<?php
// ROBLOSIUM 2013
require_once($_SERVER["STATIC"]."/settings.php");
require_once($_SERVER["STATIC"]."/package_compiler.php");
require_once($_SERVER["STATIC"]."/authentication.php");
if ($userAuth === false)
	die(header("Location: /NewLogin"));
AddCSS(CSS_DEFAULT_PACKAGE);
AddCSS(PackageCompiler::CompilePackage("page", ["/CSS/Pages/Home/Home.css", "/CSS/Pages/Home/RobloxFeed.css", "/CSS/Pages/Notifications/Notifications.css", "/CSS/PartialViews/Navigation.css", "/CSS/My/BestFriends.css"], null));
AddJS(JS_DEFAULT_PACKAGE);
AddJS(PackageCompiler::CompilePackage("page", ["/js/GenericConfirmation.js", "/js/GenericModal.js", "/js/extensions/Thumbnails.js", "/jS/Home/Home.js"], null));
$_PS->SubmenuEnabled = true;
// lets get the user's latest status
$stmt = $conn->prepare("SELECT * FROM statuses WHERE uid=:uid ORDER BY id DESC LIMIT 1");
$stmt->bindValue(":uid", $userAuth->GetUserInfo("id"));
$stmt->execute();
if ($stmt->rowCount() === 0)
	$status = "";
else
	$status = $stmt->fetch(PDO::FETCH_ASSOC)["status"];
require_once($_SERVER["STATIC"]."/header.php");
?>
        <div id="BodyWrapper">
            <div id="RepositionBody">
                <div id="Body" style="width:970px">
                    		   

<div id="HomeContainer" class="home-container" data-facebook-share="/facebook/share-character" data-update-status-url="/home/updatestatus" data-get-feed-url="/feeds/getuserfeed">
	<div>
		<h1>Hello, <span class="notranslate"><?php echo $userAuth->GetUserInfo("username"); ?></span>!</h1>
	</div>
	<div class="left-column">
	    <div class="left-column-boxes user-avatar-container">
<div id="UserAvatar" class="user-avatar-holder">
    <span class="user-avatar"><img alt="<?php echo $userAuth->GetUserInfo("username"); ?>" class="user-avatar-image" src="/images/boy_guest.png"></span>
</div>
<div id="UserInfo" class="text">
	<div>
		<b><a class="text-link" href="http://<?php echo $_SERVER["HTTP_HOST"]; ?>/my/messages?111">0 System Notification(s)</a></b>
	</div>
</div>	    </div>
		<div class="left-column-boxes">
			<h3>Roblox News</h3>
			<div class="notranslate text news-container">
				<div id="RobloxNews">
    <div class="roblox-news-feed">
                <div class="roblox-news-feed-item">
                    <a href="http://blog.roblox.com/2013/11/racetothebottom-races-to-the-top-with-space-knights/?utm_source=rss&utm_medium=rss&utm_campaign=racetothebottom-races-to-the-top-with-space-knights" ref="news-article" class="roblox-interstitial">RaceToTheBottom Races to the Top with Space Knights</a>
                </div>
                <div class="roblox-news-feed-item">
                    <a href="http://blog.roblox.com/2013/11/developers-share-their-devex-success-stories/?utm_source=rss&utm_medium=rss&utm_campaign=developers-share-their-devex-success-stories" ref="news-article" class="roblox-interstitial">Developers Share Their DevEx Success Stories</a>
                </div>
    </div>
    <a href="http://blog.roblox.com/" class="SeeMore roblox-interstitial">See More</a>
    <img alt="See more! " src="http://images.roblox.com/efe86a4cae90d4c37a5d73480dea4cb1.png" class="see-more-img">
</div>
			</div>
		</div>
	    <div class="left-column-boxes">
	        <div>
	            <h3 class="best-friends-title">My Best Friends</h3>
	            <div class="edit-friends-button">
	                <a href="http://<?php echo $_SERVER["HTTP_HOST"]; ?>/my/EditFriends.aspx" class="btn-small btn-neutral">Edit</a>
	            </div>
	            <div class="clear"></div>
	        </div>
	        <div id="bestFriendsContainer" class="best-friends-container">
<div class="best-friends">
    <!--<div class="user">
        <div class="roblox-avatar-image" data-user-id="20658082" data-image-size="tiny"><div style="position: relative;"><a href="http://www.roblox.com/user.aspx?id=20658082"><img title="acraw" alt="acraw" border="0" src="./ROBLOX.com_files/045d304a6d5dc78e3bcfa6f64b2c780d"></a></div></div>
        <div class="info">
                <img src="./ROBLOX.com_files/3a3aa21b169be06d20de7586e56e3739.png" title="Offline">
            <a class="name" href="http://www.roblox.com/User.aspx?ID=20658082">acraw</a>
                <div class="status">"minecraft is better"</div>
        </div>
        <div class="clear"></div>
    </div>
    <div class="user">
        <div class="roblox-avatar-image" data-user-id="6570505" data-image-size="tiny"><div style="position: relative;"><a href="http://www.roblox.com/user.aspx?id=6570505"><img title="bibman4000" alt="bibman4000" border="0" src="./ROBLOX.com_files/f9d6953aebf90492ba912e4e62a860ed"></a></div></div>
        <div class="info">
                <img src="./ROBLOX.com_files/3a3aa21b169be06d20de7586e56e3739.png" title="Offline">
            <a class="name" href="http://www.roblox.com/User.aspx?ID=6570505">bibman4000</a>
                <div class="status">"no more training???"</div>
        </div>
        <div class="clear"></div>
    </div>
    <div class="user">
        <div class="roblox-avatar-image" data-user-id="1394055" data-image-size="tiny"><div style="position: relative;"><a href="http://www.roblox.com/user.aspx?id=1394055"><img title="bigboy100" alt="bigboy100" border="0" src="./ROBLOX.com_files/ff153e9e7c36ff977858edc942083051"></a></div></div>
        <div class="info">
                <img src="./ROBLOX.com_files/3a3aa21b169be06d20de7586e56e3739.png" title="Offline">
            <a class="name" href="http://www.roblox.com/User.aspx?ID=1394055">bigboy100</a>
                <div class="status">"bc gone.:["</div>
        </div>
        <div class="clear"></div>
    </div>-->
</div>
</div>
	        <div style="clear:both;"></div>
	    </div>
            <div class="left-column-boxes text">
                	
	<div id="fbNotLoggedIn">
			<img border="0" alt="Facebook Connect" src="http://images.roblox.com/4ec0c6c40a454f2f6537946d00f09b56.png">
			<div style="text-align: left; margin: 5px">
				Link your ROBLOX account with your Facebook account to let your Facebook friends see what you're doing on ROBLOX!<br>
			</div>
		<a class="facebook-login" href="http://www.roblox.com/facebook/authorize?ReturnTo=%2Fmy%2Fhome.aspx">
			<span class="left"></span>
			<span class="middle">Connect with Facebook<span>Connect with Facebook</span></span>
			<span class="right"></span>
		</a>
			<div class="facepile">
				<!--<iframe src="./ROBLOX.com_files/facepile.htm" scrolling="yes" frameborder="0" style="border: none; overflow: hidden; width: 210px;"></iframe>-->
				<p style="color: Gray; font-size: smaller">Only your Facebook friends can see this.</p>
			</div>
	</div>

            </div>
	</div>

	<div class="middle-column">
		<div id="statusUpdateBox" class="middle-column-box status-update">
		    <div>
                    <input name="txtStatusMessage" type="text" id="txtStatusMessage" maxlength="254" class="translate text-box text-box-large status-textbox" placeholder="What are you up to?" value="<?php echo htmlspecialchars($status); ?>">
<span class="btn-control btn-control-large share-button" id="shareButton">Share</span>		        
		        <img id="loadingImage" class="status-update-image" style="display: none" alt="Sharing..." src="http://images.roblox.com/ec4e85b0c4396cf753a06fade0a8d8af.gif">
		        <div class="clear"></div>
		    </div>
		</div>

        <div id="FeedificationsContainer" class="">

</div>

		<div id="FeedContainer" class="middle-column-box feed-container">
			<h2>My Feed</h2>
			<div id="FeedPanel">
				<div id="AjaxFeed" class="text"><div class="text">
		<!--<div class="divider-top feed-container">
			<div class="feed-image-container notranslate">
<a href="http://www.roblox.com/TEAM-EPIK-item?id=59605209" class="feed-asset"><img class="feed-asset-image" src="./ROBLOX.com_files/d8d05001369d0bceef38a07ebd2dda1c"></a>			</div>
			<div class="feed-text-container text">
				<span class="notranslate"><a href="http://www.roblox.com/My/Groups.aspx?gid=358594">TEAM EPIK</a><br><div class="Feedtext">"If BATBOY222 makes me admin, I will make this group really active and make ads!"</div> (posted by <a href="http://www.roblox.com/User.aspx?ID=20471214">DaVe87545</a>)</span>
				<span style="display: block; padding-top: 5px; color: #AAA; font-size: 11px;">10/26/2013 at 3:35 PM</span> 
			</div>
			<div class="feed-report-abuse">
				<a href="http://www.roblox.com/AbuseReport/Feed.aspx?ID=66872670&RedirectUrl=/home">
					<img src="./ROBLOX.com_files/1ea8de3b0f71a67b032b67ddc1770c78.png" alt="Report abuse" id="reportAbuseButton">
				</a>
			</div>
			<div class="clear"></div>
		</div>
		<div class="divider-top feed-container">
			<div class="feed-image-container notranslate">
<a href="http://www.roblox.com/Roblox-Trade-System-Group-item?id=119718787" class="feed-asset"><img class="feed-asset-image" src="./ROBLOX.com_files/7be0fc39343608e796de90d97186f72c"></a>			</div>
			<div class="feed-text-container text">
				<span class="notranslate"><a href="http://www.roblox.com/My/Groups.aspx?gid=653079">Roblox Trade System Group</a><br><div class="Feedtext">"Downgrading my items, send me trades!"</div> (posted by <a href="http://www.roblox.com/User.aspx?ID=23641053">SimpleStar</a>)</span>
				<span style="display: block; padding-top: 5px; color: #AAA; font-size: 11px;">10/17/2013 at 4:34 PM</span> 
			</div>
			<div class="feed-report-abuse">
				<a href="http://www.roblox.com/AbuseReport/Feed.aspx?ID=66390401&RedirectUrl=/home">
					<img src="./ROBLOX.com_files/1ea8de3b0f71a67b032b67ddc1770c78.png" alt="Report abuse" id="reportAbuseButton">
				</a>
			</div>
			<div class="clear"></div>
		</div>
		<div class="divider-top feed-container">
			<div class="feed-image-container notranslate">
<a href="http://www.roblox.com/Roblox-Trade-System-Group-item?id=119718787" class="feed-asset"><img class="feed-asset-image" src="./ROBLOX.com_files/7be0fc39343608e796de90d97186f72c"></a>			</div>
			<div class="feed-text-container text">
				<span class="notranslate"><a href="http://www.roblox.com/My/Groups.aspx?gid=653079">Roblox Trade System Group</a><br><div class="Feedtext">"Send me (SimpleStar) Trades on my items!"</div> (posted by <a href="http://www.roblox.com/User.aspx?ID=23641053">SimpleStar</a>)</span>
				<span style="display: block; padding-top: 5px; color: #AAA; font-size: 11px;">9/29/2013 at 2:54 PM</span> 
			</div>
			<div class="feed-report-abuse">
				<a href="http://www.roblox.com/AbuseReport/Feed.aspx?ID=65488391&RedirectUrl=/home">
					<img src="./ROBLOX.com_files/1ea8de3b0f71a67b032b67ddc1770c78.png" alt="Report abuse" id="reportAbuseButton">
				</a>
			</div>
			<div class="clear"></div>
		</div>
		<div class="divider-top feed-container">
			<div class="feed-image-container notranslate">
<a href="http://www.roblox.com/Roblox-Trade-System-Group-item?id=119718787" class="feed-asset"><img class="feed-asset-image" src="./ROBLOX.com_files/7be0fc39343608e796de90d97186f72c"></a>			</div>
			<div class="feed-text-container text">
				<span class="notranslate"><a href="http://www.roblox.com/My/Groups.aspx?gid=653079">Roblox Trade System Group</a><br><div class="Feedtext">"What's the best trade you've gotten all week?"</div> (posted by <a href="http://www.roblox.com/User.aspx?ID=23641053">SimpleStar</a>)</span>
				<span style="display: block; padding-top: 5px; color: #AAA; font-size: 11px;">9/28/2013 at 4:52 PM</span> 
			</div>
			<div class="feed-report-abuse">
				<a href="http://www.roblox.com/AbuseReport/Feed.aspx?ID=65424635&RedirectUrl=/home">
					<img src="./ROBLOX.com_files/1ea8de3b0f71a67b032b67ddc1770c78.png" alt="Report abuse" id="reportAbuseButton">
				</a>
			</div>
			<div class="clear"></div>
		</div>
		<div class="divider-top feed-container">
			<div class="feed-image-container notranslate">
                    <a href="http://www.roblox.com/user.aspx?id=20471214">
					    <span class="feed-user-avatar"><img alt="DaVe87545" class="feed-user-avatar-image" src="./ROBLOX.com_files/0184aa2e2c447c5b6211374e1ba2a90a"></span>
                    </a>
			</div>
			<div class="feed-text-container text">
				<span class="notranslate"><a href="http://www.roblox.com/User.aspx?ID=20471214">DaVe87545</a> created a new place: <a href="http://www.roblox.com/item.aspx?id=129931823">Capture The Flag(READ DESCRIPTION)</a></span>
				<span style="display: block; padding-top: 5px; color: #AAA; font-size: 11px;">9/16/2013 at 10:57 PM</span> 
			</div>
			<div class="feed-report-abuse" style="display:none">
				<a href="http://www.roblox.com/AbuseReport/Feed.aspx?ID=0&RedirectUrl=/home">
					<img src="./ROBLOX.com_files/1ea8de3b0f71a67b032b67ddc1770c78.png" alt="Report abuse" id="reportAbuseButton">
				</a>
			</div>
			<div class="clear"></div>
		</div>
		<div class="divider-top feed-container">
			<div class="feed-image-container notranslate">
<a href="http://www.roblox.com/Bricksmiths-item?id=126212757" class="feed-asset"><img class="feed-asset-image" src="./ROBLOX.com_files/c4dab426a4c2108f1d9f88e3204889e6"></a>			</div>
			<div class="feed-text-container text">
				<span class="notranslate"><a href="http://www.roblox.com/My/Groups.aspx?gid=931225">[Bricksmiths]</a><br><div class="Feedtext">"Using advertisements is the only way that we can spread the word about this group. The advertisement we currently have up, is seen quite often; but doesn't attract the eye. I will pay for a professional advertisement for this group. Thank you."</div> (posted by <a href="http://www.roblox.com/User.aspx?ID=8187127">dudeofalldudes1234</a>)</span>
				<span style="display: block; padding-top: 5px; color: #AAA; font-size: 11px;">9/14/2013 at 3:20 PM</span> 
			</div>
			<div class="feed-report-abuse">
				<a href="http://www.roblox.com/AbuseReport/Feed.aspx?ID=64689298&RedirectUrl=/home">
					<img src="./ROBLOX.com_files/1ea8de3b0f71a67b032b67ddc1770c78.png" alt="Report abuse" id="reportAbuseButton">
				</a>
			</div>
			<div class="clear"></div>
		</div>
		<div class="divider-top feed-container">
			<div class="feed-image-container notranslate">
<a href="http://www.roblox.com/Roblox-Trade-System-Group-item?id=119718787" class="feed-asset"><img class="feed-asset-image" src="./ROBLOX.com_files/7be0fc39343608e796de90d97186f72c"></a>			</div>
			<div class="feed-text-container text">
				<span class="notranslate"><a href="http://www.roblox.com/My/Groups.aspx?gid=653079">Roblox Trade System Group</a><br><div class="Feedtext">"What's your favorite limited? Post on the wall!"</div> (posted by <a href="http://www.roblox.com/User.aspx?ID=23641053">SimpleStar</a>)</span>
				<span style="display: block; padding-top: 5px; color: #AAA; font-size: 11px;">9/10/2013 at 5:54 PM</span> 
			</div>
			<div class="feed-report-abuse">
				<a href="http://www.roblox.com/AbuseReport/Feed.aspx?ID=64491476&RedirectUrl=/home">
					<img src="./ROBLOX.com_files/1ea8de3b0f71a67b032b67ddc1770c78.png" alt="Report abuse" id="reportAbuseButton">
				</a>
			</div>
			<div class="clear"></div>
		</div>
		<div class="divider-top feed-container">
			<div class="feed-image-container notranslate">
                    <a href="http://www.roblox.com/user.aspx?id=6570505">
					    <span class="feed-user-avatar"><img alt="bibman4000" class="feed-user-avatar-image" src="./ROBLOX.com_files/bed87dced341d944b093b1f9c9b148d7"></span>
                    </a>
			</div>
			<div class="feed-text-container text">
				<span class="notranslate"><a href="http://www.roblox.com/User.aspx?ID=6570505">bibman4000</a><br><div class="Feedtext">"no more training???"</div></span>
				<span style="display: block; padding-top: 5px; color: #AAA; font-size: 11px;">9/2/2013 at 2:36 AM</span> 
			</div>
			<div class="feed-report-abuse">
				<a href="http://www.roblox.com/AbuseReport/Feed.aspx?ID=64045715&RedirectUrl=/home">
					<img src="./ROBLOX.com_files/1ea8de3b0f71a67b032b67ddc1770c78.png" alt="Report abuse" id="reportAbuseButton">
				</a>
			</div>
			<div class="clear"></div>
		</div>
		<div class="divider-top feed-container">
			<div class="feed-image-container notranslate">
                    <a href="http://www.roblox.com/user.aspx?id=20471214">
					    <span class="feed-user-avatar"><img alt="DaVe87545" class="feed-user-avatar-image" src="./ROBLOX.com_files/0184aa2e2c447c5b6211374e1ba2a90a"></span>
                    </a>
			</div>
			<div class="feed-text-container text">
				<span class="notranslate"><a href="http://www.roblox.com/User.aspx?ID=20471214">DaVe87545</a><br><div class="Feedtext">"T_T"</div></span>
				<span style="display: block; padding-top: 5px; color: #AAA; font-size: 11px;">8/27/2013 at 5:15 PM</span> 
			</div>
			<div class="feed-report-abuse">
				<a href="http://www.roblox.com/AbuseReport/Feed.aspx?ID=63664097&RedirectUrl=/home">
					<img src="./ROBLOX.com_files/1ea8de3b0f71a67b032b67ddc1770c78.png" alt="Report abuse" id="reportAbuseButton">
				</a>
			</div>
			<div class="clear"></div>
		</div>
		<div class="divider-top feed-container">
			<div class="feed-image-container notranslate">
<a href="http://www.roblox.com/speed-Studio-item?id=70281449" class="feed-asset"><img class="feed-asset-image" src="./ROBLOX.com_files/f0443c9bf1dd79661fce85ecec129d0d"></a>			</div>
			<div class="feed-text-container text">
				<span class="notranslate"><a href="http://www.roblox.com/My/Groups.aspx?gid=337030">speed-Studio</a><br><div class="Feedtext">"I'm going to host a poll series on YouTube, where you can vote for your favorite features to be added to chair racing! The first video should come in a couple of weeks/days. ~Nick"</div> (posted by <a href="http://www.roblox.com/User.aspx?ID=17957733">SpeedySeat</a>)</span>
				<span style="display: block; padding-top: 5px; color: #AAA; font-size: 11px;">8/15/2013 at 11:41 PM</span> 
			</div>
			<div class="feed-report-abuse">
				<a href="http://www.roblox.com/AbuseReport/Feed.aspx?ID=62855217&RedirectUrl=/home">
					<img src="./ROBLOX.com_files/1ea8de3b0f71a67b032b67ddc1770c78.png" alt="Report abuse" id="reportAbuseButton">
				</a>
			</div>
			<div class="clear"></div>
		</div>
		<div class="divider-top feed-container">
			<div class="feed-image-container notranslate">
<a href="http://www.roblox.com/Roblox-Trade-System-Group-item?id=119718787" class="feed-asset"><img class="feed-asset-image" src="./ROBLOX.com_files/7be0fc39343608e796de90d97186f72c"></a>			</div>
			<div class="feed-text-container text">
				<span class="notranslate"><a href="http://www.roblox.com/My/Groups.aspx?gid=653079">Roblox Trade System Group</a><br><div class="Feedtext">"Whats the best trade you've ever done? Post it on the wall!"</div> (posted by <a href="http://www.roblox.com/User.aspx?ID=23641053">SimpleStar</a>)</span>
				<span style="display: block; padding-top: 5px; color: #AAA; font-size: 11px;">8/15/2013 at 9:20 PM</span> 
			</div>
			<div class="feed-report-abuse">
				<a href="http://www.roblox.com/AbuseReport/Feed.aspx?ID=62849010&RedirectUrl=/home">
					<img src="./ROBLOX.com_files/1ea8de3b0f71a67b032b67ddc1770c78.png" alt="Report abuse" id="reportAbuseButton">
				</a>
			</div>
			<div class="clear"></div>
		</div>
		<div class="divider-top feed-container">
			<div class="feed-image-container notranslate">
<a href="http://www.roblox.com/speed-Studio-item?id=70281449" class="feed-asset"><img class="feed-asset-image" src="./ROBLOX.com_files/f0443c9bf1dd79661fce85ecec129d0d"></a>			</div>
			<div class="feed-text-container text">
				<span class="notranslate"><a href="http://www.roblox.com/My/Groups.aspx?gid=337030">speed-Studio</a><br><div class="Feedtext">"Alright. The map reviewer is back up, so if you need to submit a map, submit it ASAP. ~Nick"</div> (posted by <a href="http://www.roblox.com/User.aspx?ID=17957733">SpeedySeat</a>)</span>
				<span style="display: block; padding-top: 5px; color: #AAA; font-size: 11px;">8/5/2013 at 7:51 AM</span> 
			</div>
			<div class="feed-report-abuse">
				<a href="http://www.roblox.com/AbuseReport/Feed.aspx?ID=62010995&RedirectUrl=/home">
					<img src="./ROBLOX.com_files/1ea8de3b0f71a67b032b67ddc1770c78.png" alt="Report abuse" id="reportAbuseButton">
				</a>
			</div>
			<div class="clear"></div>
		</div>
		<div class="divider-top feed-container">
			<div class="feed-image-container notranslate">
                    <a href="http://www.roblox.com/user.aspx?id=20471214">
					    <span class="feed-user-avatar"><img alt="DaVe87545" class="feed-user-avatar-image" src="./ROBLOX.com_files/0184aa2e2c447c5b6211374e1ba2a90a"></span>
                    </a>
			</div>
			<div class="feed-text-container text">
				<span class="notranslate"><a href="http://www.roblox.com/User.aspx?ID=20471214">DaVe87545</a><br><div class="Feedtext">"People at the NYPD work hard!!!"</div></span>
				<span style="display: block; padding-top: 5px; color: #AAA; font-size: 11px;">7/31/2013 at 7:59 PM</span> 
			</div>
			<div class="feed-report-abuse">
				<a href="http://www.roblox.com/AbuseReport/Feed.aspx?ID=62034971&RedirectUrl=/home">
					<img src="./ROBLOX.com_files/1ea8de3b0f71a67b032b67ddc1770c78.png" alt="Report abuse" id="reportAbuseButton">
				</a>
			</div>
			<div class="clear"></div>
		</div>
		<div class="divider-top feed-container">
			<div class="feed-image-container notranslate">
<a href="http://www.roblox.com/speed-Studio-item?id=70281449" class="feed-asset"><img class="feed-asset-image" src="./ROBLOX.com_files/f0443c9bf1dd79661fce85ecec129d0d"></a>			</div>
			<div class="feed-text-container text">
				<span class="notranslate"><a href="http://www.roblox.com/My/Groups.aspx?gid=337030">speed-Studio</a><br><div class="Feedtext">"[Current Game version: 8.4; BETA edition: 9a; BETA update date: August 1st, 2013] ANNCMENT: Doing a hunt for anybody who can retexture the new chair mesh... ~SS"</div> (posted by <a href="http://www.roblox.com/User.aspx?ID=17957733">SpeedySeat</a>)</span>
				<span style="display: block; padding-top: 5px; color: #AAA; font-size: 11px;">7/20/2013 at 9:14 PM</span> 
			</div>
			<div class="feed-report-abuse">
				<a href="http://www.roblox.com/AbuseReport/Feed.aspx?ID=60825103&RedirectUrl=/home">
					<img src="./ROBLOX.com_files/1ea8de3b0f71a67b032b67ddc1770c78.png" alt="Report abuse" id="reportAbuseButton">
				</a>
			</div>
			<div class="clear"></div>
		</div>
		<div class="divider-top feed-container">
			<div class="feed-image-container notranslate">
                    <a href="http://www.roblox.com/user.aspx?id=20471214">
					    <span class="feed-user-avatar"><img alt="DaVe87545" class="feed-user-avatar-image" src="./ROBLOX.com_files/0184aa2e2c447c5b6211374e1ba2a90a"></span>
                    </a>
			</div>
			<div class="feed-text-container text">
				<span class="notranslate"><a href="http://www.roblox.com/User.aspx?ID=20471214">DaVe87545</a><br><div class="Feedtext">"Going SUPER"</div></span>
				<span style="display: block; padding-top: 5px; color: #AAA; font-size: 11px;">6/26/2013 at 12:42 PM</span> 
			</div>
			<div class="feed-report-abuse">
				<a href="http://www.roblox.com/AbuseReport/Feed.aspx?ID=59179429&RedirectUrl=/home">
					<img src="./ROBLOX.com_files/1ea8de3b0f71a67b032b67ddc1770c78.png" alt="Report abuse" id="reportAbuseButton">
				</a>
			</div>
			<div class="clear"></div>
		</div>
		<div class="divider-top feed-container">
			<div class="feed-image-container notranslate">
<a href="http://www.roblox.com/speed-Studio-item?id=70281449" class="feed-asset"><img class="feed-asset-image" src="./ROBLOX.com_files/f0443c9bf1dd79661fce85ecec129d0d"></a>			</div>
			<div class="feed-text-container text">
				<span class="notranslate"><a href="http://www.roblox.com/My/Groups.aspx?gid=337030">speed-Studio</a><br><div class="Feedtext">"[Current Game version: 8.4; BETA edition: 8.4; BETA update date: âˆž until issue resolved.] ANNOUNCEMENT: If chair racing gets enough ratings within the next week, I'll come back and give the game a big update. Unfortunately, I am not BC and cannot add ads."</div> (posted by <a href="http://www.roblox.com/User.aspx?ID=17957733">SpeedySeat</a>)</span>
				<span style="display: block; padding-top: 5px; color: #AAA; font-size: 11px;">6/23/2013 at 9:45 PM</span> 
			</div>
			<div class="feed-report-abuse">
				<a href="http://www.roblox.com/AbuseReport/Feed.aspx?ID=58890802&RedirectUrl=/home">
					<img src="./ROBLOX.com_files/1ea8de3b0f71a67b032b67ddc1770c78.png" alt="Report abuse" id="reportAbuseButton">
				</a>
			</div>
			<div class="clear"></div>
		</div>
		<div class="divider-top feed-container">
			<div class="feed-image-container notranslate">
                    <a href="http://www.roblox.com/user.aspx?id=41260932">
					    <span class="feed-user-avatar"><img alt="DaVe875453" class="feed-user-avatar-image" src="./ROBLOX.com_files/4111f0f738c237c65ed4047aece12d6c"></span>
                    </a>
			</div>
			<div class="feed-text-container text">
				<span class="notranslate"><a href="http://www.roblox.com/User.aspx?ID=41260932">DaVe875453</a><br><div class="Feedtext">"SOME GUY WAS ON MY ACCOUNT LAST NIGHT &gt;:O"</div></span>
				<span style="display: block; padding-top: 5px; color: #AAA; font-size: 11px;">4/24/2013 at 3:37 PM</span> 
			</div>
			<div class="feed-report-abuse">
				<a href="http://www.roblox.com/AbuseReport/Feed.aspx?ID=55404223&RedirectUrl=/home">
					<img src="./ROBLOX.com_files/1ea8de3b0f71a67b032b67ddc1770c78.png" alt="Report abuse" id="reportAbuseButton">
				</a>
			</div>
			<div class="clear"></div>
		</div>
		<div class="divider-top feed-container">
			<div class="feed-image-container notranslate">
                    <a href="http://www.roblox.com/user.aspx?id=41260932">
					    <span class="feed-user-avatar"><img alt="DaVe875453" class="feed-user-avatar-image" src="./ROBLOX.com_files/4111f0f738c237c65ed4047aece12d6c"></span>
                    </a>
			</div>
			<div class="feed-text-container text">
				<span class="notranslate"><a href="http://www.roblox.com/User.aspx?ID=41260932">DaVe875453</a><br><div class="Feedtext">"Im JUST CHILLIN"</div></span>
				<span style="display: block; padding-top: 5px; color: #AAA; font-size: 11px;">4/22/2013 at 5:57 PM</span> 
			</div>
			<div class="feed-report-abuse">
				<a href="http://www.roblox.com/AbuseReport/Feed.aspx?ID=55382412&RedirectUrl=/home">
					<img src="./ROBLOX.com_files/1ea8de3b0f71a67b032b67ddc1770c78.png" alt="Report abuse" id="reportAbuseButton">
				</a>
			</div>
			<div class="clear"></div>
		</div>
		<div class="divider-top feed-container">
			<div class="feed-image-container notranslate">
                    <a href="http://www.roblox.com/user.aspx?id=41260932">
					    <span class="feed-user-avatar"><img alt="DaVe875453" class="feed-user-avatar-image" src="./ROBLOX.com_files/4111f0f738c237c65ed4047aece12d6c"></span>
                    </a>
			</div>
			<div class="feed-text-container text">
				<span class="notranslate"><a href="http://www.roblox.com/User.aspx?ID=41260932">DaVe875453</a> created a new place: <a href="http://www.roblox.com/item.aspx?id=113225466">DaVe875453's Place</a></span>
				<span style="display: block; padding-top: 5px; color: #AAA; font-size: 11px;">4/18/2013 at 3:19 PM</span> 
			</div>
			<div class="feed-report-abuse" style="display:none">
				<a href="http://www.roblox.com/AbuseReport/Feed.aspx?ID=0&RedirectUrl=/home">
					<img src="./ROBLOX.com_files/1ea8de3b0f71a67b032b67ddc1770c78.png" alt="Report abuse" id="reportAbuseButton">
				</a>
			</div>
			<div class="clear"></div>
		</div>-->
</div>
</div>
				<div id="AjaxFeedError" style="display: none" class="error-message">An error occurred while fetching your feed.</div>
			</div>
		</div>
	</div>

    <div class="right-column">
            <div id="RecentlyVisitedPlacesContainer" class="right-column-box">
                <h3 style="padding-bottom: 6px;">Recently Played Games</h3>
                
<div id="RecentlyVisitedPlaces">
	<div id="RecentlyVisitedPlaceTemplate" class="recent-place-container">
		<div class="recent-place-thumb"></div>
		<div class="recent-place-Info">
			<div class="recent-place-name"></div>
			<div class="recent-place-players-online text"></div>
		</div>
	</div>
<!--<div class="recent-place-container" style="display: block;">
		<div class="recent-place-thumb"><img src="#" alt="Summer 2009" class="recent-place-thumb-img"></div>
		<div class="recent-place-Info">
			<div class="recent-place-name"><a href="http://www.roblox.com/Summer-2009-place?id=40960945">Summer 2009 </a></div>
			<div class="recent-place-players-online text">0 players online</div>
		</div>
	</div><div class="recent-place-container" style="display: block;">
		<div class="recent-place-thumb"><img src="#" alt="Stagecoach and first bus simulator 20..." class="recent-place-thumb-img"></div>
		<div class="recent-place-Info">
			<div class="recent-place-name"><a href="http://www.roblox.com/Stagecoach-and-first-bus-simulator-2013-more-roads-place?id=48727518">Stagecoach and first bus simulatâ€¦ </a></div>
			<div class="recent-place-players-online text">0 players online</div>
		</div>
	</div><div class="recent-place-container" style="display: block;">
		<div class="recent-place-thumb"><img src="#" alt="Space AfflictionÃ¢â€žÂ¢ 1: V3(New Ship/star..." class="recent-place-thumb-img"></div>
		<div class="recent-place-Info">
			<div class="recent-place-name"><a href="http://www.roblox.com/Space-Affliction-1-V3-New-Ship-starsystems-place?id=22782575">Space AfflictionÃ¢â€žÂ¢ 1: V3(New Shâ€¦ </a></div>
			<div class="recent-place-players-online text">61 players online</div>
		</div>
	</div><div class="recent-place-container" style="display: block;">
		<div class="recent-place-thumb"><img src="#" alt="Sinking Ship [Now working on 1.8]" class="recent-place-thumb-img"></div>
		<div class="recent-place-Info">
			<div class="recent-place-name"><a href="http://www.roblox.com/Sinking-Ship-Now-working-on-1-8-place?id=72193303">Sinking Ship [Now working on 1.8] </a></div>
			<div class="recent-place-players-online text">579 players online</div>
		</div>
	</div><div class="recent-place-container" style="display: block;">
		<div class="recent-place-thumb"><img src="#" alt="Base wars:The Land(since 2009) [Read ..." class="recent-place-thumb-img"></div>
		<div class="recent-place-Info">
			<div class="recent-place-name"><a href="http://www.roblox.com/Base-wars-The-Land-since-2009-Read-description-place?id=18164449">Base wars:The Land(since 2009)â€¦ </a></div>
			<div class="recent-place-players-online text">530 players online</div>
		</div>
	</div>--></div>
<div id="SeeMore">
        <a href="http://www.roblox.com/games?sortFilter=6" class="text-link">See More  <img alt="See more! " src="http://images.roblox.com/efe86a4cae90d4c37a5d73480dea4cb1.png" class="see-more-img"></a>
</div>
<div id="PlayGames" style="display: none">
	You haven't played any games recently.
	<a href="http://www.roblox.com/Games.aspx" class="text-link">Play Now  <img alt="See more! " src="http://images.roblox.com/efe86a4cae90d4c37a5d73480dea4cb1.png" class="see-more-img"></a>
</div>
            </div>
        <div id="Skyscraper-Ad" class="right-column-box">
<div style="width: 160px">
    <span id="3439303639313930" class="GPTAd skyscraper" data-js-adtype="gptAd">
        <script type="text/javascript">
            googletag.cmd.push(function () {
                googletag.display("3439303639313930");
            });
        </script>
    <div id="google_ads_iframe_/1015347/Roblox_MyHome_Right_160x600_0__container__" style="border: 0pt none;"><iframe id="google_ads_iframe_/1015347/Roblox_MyHome_Right_160x600_0" name="google_ads_iframe_/1015347/Roblox_MyHome_Right_160x600_0" width="160" height="600" scrolling="no" marginwidth="0" marginheight="0" frameborder="0" src="javascript:"<html><body style='background:transparent'></body></html>"" style="border: 0px; vertical-align: bottom;"></iframe></div><iframe id="google_ads_iframe_/1015347/Roblox_MyHome_Right_160x600_0__hidden__" name="google_ads_iframe_/1015347/Roblox_MyHome_Right_160x600_0__hidden__" width="0" height="0" scrolling="no" marginwidth="0" marginheight="0" frameborder="0" src="javascript:"<html><body style='background:transparent'></body></html>"" style="border: 0px; vertical-align: bottom; visibility: hidden; display: none;"></iframe></span>
    <div class="ad-annotations " style="width: 160px">
        <span class="ad-identification">Advertisement</span>
            <a class="BadAdButton" href="http://www.roblox.com/Ads/ReportAd.aspx" title="click to report an offensive ad">Report</a>
    </div>
</div>        </div>
    </div>
	<div class="clear"></div>
	<div id="UserScreenContainer">

	</div>
</div>


                    <div style="clear:both"></div>
                </div>
            </div>
        </div>
<?php
require_once($_SERVER["STATIC"]."/footer.php");
?>
