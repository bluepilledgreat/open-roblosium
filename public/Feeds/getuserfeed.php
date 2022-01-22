<?php
// ROBLOSIUM 2013
// TODO: why does time not work?
require_once($_SERVER["STATIC"]."/connection.php");
require_once($_SERVER["STATIC"]."/authentication.php");
if($userAuth) 
{
	// get friend's feed and put it into array
	$stmt = $conn->prepare("SELECT * FROM friends WHERE ((sender = :t1) OR (receiver = :t2)) AND ((status = 2) OR (status = 3))");
	$stmt->bindValue(":t1", $userAuth->GetUserInfo("id"), PDO::PARAM_INT);
	$stmt->bindValue(":t2", $userAuth->GetUserInfo("id"), PDO::PARAM_INT);
	$stmt->execute();
	$results = $stmt->fetchAll(PDO::FETCH_OBJ);
	$friendids = [];
	foreach ($results as $f)
		array_push($friendids, $f->sender == $userAuth->GetUserInfo("id") ? $f->receiver : $f->sender);
	$feed = [];
	if (!empty($friendids))
	{
		$stmt = $conn->prepare("SELECT * FROM users WHERE id=".implode(" OR id=", $friendids));
		$stmt->execute();
		$friends = $stmt->fetchAll(PDO::FETCH_GROUP|PDO::FETCH_OBJ);
		$stmt = $conn->prepare("SELECT * FROM statuses WHERE uid=".implode(" OR uid=", $friendids)." ORDER BY date DESC LIMIT 10");
		$stmt->execute();
		$feed_arr = $stmt->fetchAll(PDO::FETCH_OBJ);
		foreach($feed_arr as $feed) 
		{
			$user = $friends[$feed->uid][0];
		?>
<div class="divider-top feed-container">
	<div class="feed-image-container notranslate">
      <a href="/User.aspx?ID=<?php echo $feed->uid; ?>" class="feed-asset">
      <img class="feed-asset-image" title="<?php echo $user->username; ?>" alt="<?php echo $user->username; ?>" border="0" height="48" width="48" src="/images/boy_guest.png">
      </a>
   </div>
   <div class="feed-text-container text">
      <span class="notranslate">
         <a href="/User.aspx?ID=<?php echo $feed->uid; ?>"><?php echo $user->username; ?></a><br>
         <div class="Feedtext">"<?php echo htmlspecialchars($feed->status); ?>"</div>
      </span>
      <span style="display: block; padding-top: 5px; color: #AAA; font-size: 11px;"><?php echo date("m/d/Y", $feed->date) . " at " . date("g:i a", $feed->date); ?></span>
   </div>
   <div class="feed-report-abuse">
      <a href="/abusereport/feed?id=90938582&amp;redirectUrl=%2Fhome">
      <img src="https://images.rbxcdn.com/1ea8de3b0f71a67b032b67ddc1770c78.png" alt="Report abuse" class="reportAbuseButton" height="13" width="14">
      </a>
   </div>
   <div class="clear"></div>
</div>
<?php
		}
	}
	else
	{ ?>
	<div class="divider-top feed-container" data-default-roblox-feed>
		<div class="feed-image-container notranslate">
			<a href="/games"><img src="http://images.rbxcdn.com/39aa8f6babe14e04b7c194bf7537ca7d.png" alt="" width="48px" height="48px"/></a>
		</div>
		<div class="feed-text-container text">
			<div><h3>Play Games!</h3></div>
			<div>Nearly all ROBLOX games are built by players like you. Here are some of our favorites:</div>
			<div id="FeaturedGamesContainer"></div>
		</div>
		<div class="clear"></div>
	</div>
	<div class="divider-top feed-container" data-default-roblox-feed>
		<div class="feed-image-container notranslate">
			<a href="/catalog/browse.aspx?Subcategory=3&CurrencyType=4&pxMin=1&pxMax=10&SortType=0&SortAggregation=3&SortCurrency=1&LegendExpanded=true&Category=3">
			    <img src="http://images.rbxcdn.com/fba7daaa77b9598d8c20337dd2b2d19c.png" alt="" width="48px" height="48px"/>
            </a>
		</div>
		<div class="feed-text-container text">
			<div><h3>Customize Your Character</h3></div>
			<div>
				Log in everyday and earn 10 tickets. Tickets can be used to buy clothing in our 
				<a href="/catalog/browse.aspx?Subcategory=3&CurrencyType=4&pxMin=1&pxMax=10&SortType=0&SortAggregation=3&SortCurrency=1&LegendExpanded=true&Category=3">catalog</a>.
				You can also create your own clothing on the <a href="/develop">Build page</a>.
			</div>
			<div>
				<img src="http://images.rbxcdn.com/005a0f4d764d9c609ff4c37a2bb99006.png" class="default-feed-character-image" alt=""/>
				<img src="http://images.rbxcdn.com/e861c0c517df63e9f17e96685cc4bb14.png" class="default-feed-character-image" alt=""/>
				<img src="http://images.rbxcdn.com/7fd0bef40b29834e8add92234b352c3e.png" class="default-feed-character-image" alt=""/>
				<img src="http://images.rbxcdn.com/294ebb9ceaac3c5352de0ebecab909ec.png" class="default-feed-character-image" alt=""/>
			</div>
		</div>
		<div class="clear"></div>
	</div>
	<div class="divider-top feed-container" data-default-roblox-feed>
		<div class="feed-image-container notranslate">
			<a href="/Browse.aspx"><img src="http://images.rbxcdn.com/e7ad153358eb44ae9c67b5ca603dd97e.png" alt="" width="48px" height="48px"/></a>
		</div>
		<div class="feed-text-container text">
			<div><h3>Make Friends</h3></div>
			<div>
				Meet other players in-game and send them a friend request. 
				If you miss your opportunity you can always send a request later by <a href="/Browse.aspx">searching</a> for their user profile.
			</div>
		</div>
		<div class="clear"></div>
	</div>
	<div class="divider-top feed-container" data-default-roblox-feed>
		<div class="feed-image-container">
			<a href="/develop"><img src="http://images.rbxcdn.com/327969f8ec51f6c08fba1ecb2e77aaae.png"  alt="" width="48px" height="48px"/></a>
		</div>
		<div class="feed-text-container text">
			<div><h3>Build Something</h3></div>
			<div>
				Builders will enjoy playing our multiplayer building game. Professional builders will want to check out ROBLOX Studio, 
				our game development environment on your <a href="/develop">Build page</a>
			</div>				
		</div>
		<div class="clear"></div>
	</div>
	<div class="divider-top feed-container" data-default-roblox-feed>
		<div class="feed-image-container">
			<a href="/Forum/Default.aspx"><img src="http://images.rbxcdn.com/8a075547b027867bdaa24767a5de9a73.png" alt="" width="48px" height="48px"/></a>
		</div>
		<div class="feed-text-container text">
			<div><h3>ROBLOX forums for help and more</h3></div>
			<div>
				No matter what you're looking for, if it's ROBLOX related, there are people talking about it
				<a href="/Forum/Default.aspx">here</a>.
			</div>
		</div>
		<div class="clear"></div>
	</div>
<?php
	}
}
else
	header("Location: /RobloxDefaultErrorPage.aspx?code=500");
?>
