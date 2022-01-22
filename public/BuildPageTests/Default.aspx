<?php
// ROBLOSIUM 2013
// thx brent :D
require_once($_SERVER["STATIC"]."/settings.php");
require_once($_SERVER["STATIC"]."/package_compiler.php");
AddCSS(CSS_DEFAULT_PACKAGE);
AddCSS(PackageCompiler::CompilePackage("page", ["/CSS/PartialViews/Navigation.css", "/CSS/Pages/Build/Develop.css", "/CSS/Pages/Build/BuildPage.css", "/CSS/Pages/Build/DropDownMenus.css", "/CSS/Pages/Build/StudioWidget.css", "/CSS/Pages/Build/Upload.css"], null));
AddJS(JS_DEFAULT_PACKAGE);
AddJS(PackageCompiler::CompilePackage("page", ["/js/Build/BuildPage.js"], null));
require_once($_SERVER["STATIC"]."/header.php");
?>
<div id="BodyWrapper">
	<div id="RepositionBody">
		<div id="Body" class="" style="width:970px">
			<div>
				<div id="MyCreationsTab" class="tab-active">
					<div class="BuildPageContent" data-groupid="">
						<input id="assetTypeId" name="assetTypeId" type="hidden" value="9"> <input data-val="true" data-val-required="The IsTgaUploadEnabled field is required." id="isTgaUploadEnabled" name="isTgaUploadEnabled" type="hidden" value="True">
						<table id="build-page" data-asset-type-id="9" data-showcases-enabled="true" data-edit-opens-studio="True">
							<tbody>
								<tr>
									<td class="menu-area divider-right">
										<div id="build-new-button" class="btn-medium btn-primary">Build New &#9662;</div>
										<div id="build-new-dropdown-menu">
											<a style="background-position-y: 2px" href="/My/NewPlace.aspx">Place</a>
											<a style="background-position-y: 2px" href="">Personal Server</a>
											<a style="background-position-y: -22px" href="">Shirt</a>
											<a style="background-position-y: -97px" href="">T-Shirt</a>
											<a style="background-position-y: -72px" href="">Pants</a>
											<a style="background-position-y: -47px" href="">Model</a>
											<a style="background-position-y: -122px" href="">Decal</a>
										</div>
										<a href="/develop?View=9" class="tab-item tab-item-selected">Places</a> <a href="/develop?View=11" class="tab-item">Shirts</a> <a href="/develop?View=2" class="tab-item">T-Shirts</a> <a href="/develop?View=12" class="tab-item">Pants</a> <a href="/develop?View=10" class="tab-item">Models</a> <a href="/develop?View=13" class="tab-item">Decals</a> <a href="/develop?View=3" class="tab-item">Audio</a> 
										<div id="StudioWidget">
											<div class="widget-name">
												<h3>ROBLONIUM Studio</h3>
											</div>
											<div class="content">
												<div id="LeftColumn">
													<div class="studio-icon"><img src="/Images/Roblonium_Studio_By_Lemur.png"></div>
												</div>
												<div id="RightColumn">
													<ul>
														<li><a href="https://setup.roblonium.com/RobloxStudioLauncherBeta.exe" class="studio-launch" download="">Download</a></li>
														<li><a href="https://devforum.roblonium.com/">Forum</a></li>
														<li><a href="https://wiki.roblonium.com/">Wiki</a></li>
													</ul>
												</div>
											</div>
										</div>
									</td>
									<td class="content-area">
										<table class="section-header">
											<tbody>
												<tr>
													<td class="content-title">
														<div>
															<h2 class="header-text">Places</h2>
															<span class="aside-text">0 of 10 active slots used</span>
														</div>
													</td>
													<td>
														<div class="creation-context-filters-and-sorts" data-fetchplaceurl="/build/gamesbycontext?groupId=">
															<div class="option">
																<label class="sort-label">Sort by:</label>
																<select class="place-creationcontext-drop-down" size="1">
																	<option value="RecentlyUpdated"> Recently Updated </option>
																</select>
															</div>
															<div class="option">
																<label class="checkbox-label active-only-checkbox"><input type="checkbox">Active First</label>
															</div>
														</div>
													</td>
												</tr>
												<tr class="creation-context-breadcrumb" style="display:none">
													<td style="height:21px">
														<div class="breadCrumb creation-context-breadcrumb"><a href="#breadcrumbs=gamecontext" class="breadCrumbContext">Context</a> <span class="context-game-separator" style="display:none"> » </span> <a href="#breadcrumbs=game" class="breadCrumbGame" style="display:none">Game</a></div>
													</td>
												</tr>
											</tbody>
										</table>
										<div class="items-container games-container">
											<script>
												function editGameInStudio(play_placeId) {
													RobloxLaunch._GoogleAnalyticsCallback = function() {
														var isInsideRobloxIDE = 'website';
														if (Roblox && Roblox.Client && Roblox.Client.isIDE && Roblox.Client.isIDE()) {
															isInsideRobloxIDE = 'Studio';
														};
														GoogleAnalyticsEvents.FireEvent(['Plugin Location', 'Launch Attempt', isInsideRobloxIDE]);
														GoogleAnalyticsEvents.FireEvent(['Plugin', 'Launch Attempt', 'Edit']);
														EventTracker.fireEvent('GameLaunchAttempt_Win32', 'GameLaunchAttempt_Win32_Plugin');
														if (typeof Roblox.GamePlayEvents != 'undefined') {
															Roblox.GamePlayEvents.SendClientStartAttempt(null, play_placeId);
														}
													};
													Roblox.Client.WaitForRoblox(function() {
														Roblox.VideoPreRoll.showVideoPreRoll = false;
														RobloxLaunch.StartGame('http://www.roblonium.com//Game/edit.ashx?placeId=' + play_placeId , 'edit.ashx', 'https://www.roblonium.com//Login/Negotiate.ashx', 'FETCH', true)
													});
												}
											</script><span id="verifiedEmail" style="display:none"></span> <span id="assetLinks" style="display:none" data-asset-links-enabled="True"></span>
											<table class="item-table" data-item-id="{placeId}" data-type="game" data-universeid="{universeId}">
												<tbody>
													<tr>
														<td class="image-col"><a href="/games/{placeId}/{placeNameEncoded}" class="game-image"> <img src="/Thumbs/defaultplaceimagebuild.png" alt="{placeName}"> </a></td>
														<td class="name-col">
															<a class="title" href="/games/{placeId}/{placeNameEncoded}">{placeName}</a>
															<table class="details-table">
																<tbody>
																	<tr>
																		<td class="activate-cell"><a class="place-active" href="/universes/configure?id={universeId}">Active</a></td>
																		<td class="item-date"><span>Updated: 9/28/2014</span></td>
																	</tr>
																</tbody>
															</table>
														</td>
														<td class="stats-col-games">
															<div class="totals-label">Total Visitors:<span>0</span></div>
															<div class="totals-label">Last 7 days:<span>0</span></div>
														</td>
														<td class="edit-col"><a class="roblox-edit-button btn-control btn-control-large" href="javascript:">Edit</a></td>
														<td class="build-col"><a class="roblox-build-button btn-control btn-control-large" href="javascript:">Build</a></td>
														<td class="menu-col">
															<div class="gear-button-wrapper"><a href="#" class="gear-button"></a></div>
														</td>
													</tr>
												</tbody>
											</table>
											<div class="separator"></div>
											<table class="item-table" data-item-id="{placeId}" data-type="game" data-universeid="{universeId}">
												<tbody>
													<tr>
														<td class="image-col"><a href="/games/{placeId}/{placeNameEncoded}" class="game-image"> <img src="/Thumbs/defaultplaceimagebuild.png" alt="{placeName}"> </a></td>
														<td class="name-col">
															<a class="title" href="/games/{placeId}/{placeNameEncoded}">{placeName}</a>
															<table class="details-table">
																<tbody>
																	<tr>
																		<td class="activate-cell"><a class="place-inactive" href="/universes/configure?id={universeId}">Inactive</a></td>
																		<td class="item-date"><span>Updated: 9/28/2014</span></td>
																	</tr>
																</tbody>
															</table>
														</td>
														<td class="stats-col-games">
															<div class="totals-label">Total Visitors:<span>0</span></div>
															<div class="totals-label">Last 7 days:<span>0</span></div>
														</td>
														<td class="edit-col"><a class="roblox-edit-button btn-control btn-control-large" href="javascript:">Edit</a></td>
														<td class="build-col"><a class="roblox-build-button btn-control btn-control-large" href="javascript:">Build</a></td>
														<td class="menu-col">
															<div class="gear-button-wrapper"><a href="#" class="gear-button"></a></div>
														</td>
													</tr>
												</tbody>
											</table>
											<div class="separator"></div>
										</div>
										<div class="build-loading-container" style="display:none">
											<div class="buildpage-loading-container"><img alt="^_^" src="https://images.rbxcdn.com/ec4e85b0c4396cf753a06fade0a8d8af.gif"></div>
										</div>
									</td>
								</tr>
							</tbody>
						</table>
						<div id="build-dropdown-menu"><a href="#" data-href-template="/places/0/update">Configure</a> <a href="#" data-href-template="/places/0/update">Advertise</a> <a href="#" data-href-template="/places/0/update">Create Badge</a> <a href="#" data-href-template="/places/0/update">Create Game Pass</a> <a href="#" data-href-template="/places/0/update">Add Gear</a> <a href="#" data-gameonly-link="true" data-href-template="/places/0/stats">Developer Stats</a> <a class="shutdown-all-servers-button divider-top" href="#">Shut Down All Servers</a></div>
						<div class="PlaceSelectorModal modalPopup unifiedModal" style="display:none">
							<div class="Title">Select Place</div>
							<div class="GenericModalBody text">
								<div class="place-selector-modal" data-place-loader-url="/universes/get-places-by-context?creationContext=NonGameCreation&amp;universeId=0&amp;groupId=">
									<div class="place-selector-container">
										<div id="PlaceSelectorItemContainer" class="place-selector-item-container"></div>
										<div id="PlaceSelectorPagerContainer" class="place-selector-pager-container"></div>
									</div>
									<div class="place-selector selectable template" title="Place" style="display:none">
										<div class="place-image" data-retry-url-template="https://thumbnails.roblonium.com/v1/assets?size=160x100&amp;format=jpeg&amp;returnPolicy=AutoGenerated"><img alt="^_^" class="item-image" src="https://images.rbxcdn.com/ec5c01d220bf1b73403fa51519267742.gif"></div>
										<div class="InfoContainer">
											<div class="place-name"></div>
											<div class="game-name"><span class="form-label">Game: </span><span class="game-name-text"></span></div>
											<div class="root-place" style="display:none"><span>Cannot choose start places</span></div>
										</div>
										<div style="clear:both"></div>
									</div>
								</div>
							</div>
						</div>
						<script>$(function(){Roblox.PlaceSelector.Init();Roblox.PlaceSelector.Resources={anErrorOccurred:'An error occurred, please try again.'};});</script>
						<div class="GenericModal modalPopup unifiedModal smallModal" style="display:none">
							<div class="Title"></div>
							<div class="GenericModalBody">
								<div>
									<div class="ImageContainer"><img class="GenericModalImage" alt="generic image"></div>
									<div class="Message"></div>
								</div>
								<div class="GenericModalButtonContainer"><a class="ImageButton btn-neutral btn-large roblox-ok">OK</a></div>
							</div>
						</div>
						<script>Roblox=Roblox||{};Roblox.BuildPage=Roblox.BuildPage||{};Roblox.BuildPage.AlertURL="https://images.rbxcdn.com/43ac54175f3f3cd403536fedd9170c10.png";</script>
					</div>
					<script>if(typeof Roblox==="undefined"){Roblox={};}
						if(typeof Roblox.BuildPage==="undefined"){Roblox.BuildPage={};}
						Roblox.BuildPage.Resources={active:"Active",inactive:"Inactive",activatePlace:"Activate Place",editGame:"Edit Game",ok:"OK",robloxStudio:"ROBLOX Studio",openIn:"To edit this game, open to this page in ",placeInactive:"Deactivate Place",toBuileHere:"To build here, please activate this place by clicking the ",inactiveButton:"inactive button. ",createModel:"Create Model",toCreate:"To create models, please use ",makeActive:"Make Active",makeInactive:"Make Inactive",purchaseComplete:"Purchase Complete!",youHaveBid:"You have successfully bid ",confirmBid:"Confirm the Bid",placeBid:"Place Bid",cancel:"Cancel",errorOccurred:"Error Occurred",adDeleted:"Ad Deleted",theAdWasDeleted:"The Ad has been deleted.",confirmDelete:"Confirm Deletion",areYouSureDelete:"Are you sure you want to delete this Ad?",bidRejected:"Your bid was Rejected",bidRange:"Bid value must be a number between ",bidRange2:"Bid value must be a number greater than ",and:" and ",yourRejected:"Your bid was Rejected",estimatorExplanation:"This estimator uses data from ads run yesterday to guess how many impressions your ad will recieve.",estimatedImpressions:"Estimated Impressions ",makeAdBid:"Make Ad Bid",wouldYouLikeToBid:"Would you like to bid ",verify:"Verify",emailVerifiedTitle:"Verify Your Email",emailVerifiedMessage:"You must verify your email before you can work on your place. You can verify your email on the <a href='/my/account?confirmemail=1'>Account</a> page.",continueText:"Continue",profileRemoveTitle:"Remove from profile?",profileRemoveMessage:"This game is private and listed on your profile, do you wish to remove it?",profileAddTitle:"Add to profile?",profileAddMessage:"This game is public, but not listed on your profile, do you wish to add it?",deactivateTitle:"Deactivate Place",deactivateBody:"This will shut down any running games <br /><br />Do you still want to deactivate the place?",deactivateButton:"Deactivate",questionmarkImgUrl:"/images/Buttons/questionmark-12x12.png",activationRequestFailed:"Request to active the place. Please retry in a few minutes!",deactivationRequestFailed:"Request to deactivate the place failed. Please retry in a few minutes!",tooManyActiveMessage:"You have reached the maximum number of active places for your membership level. Deactivate one of your existing places before activating this one.",activeSlotsMessage:"{0} of {1} active slots used"};
					</script>
				</div>
			</div>
			<div id="AdPreviewModal" class="simplemodal-data" style="display:none">
				<div id="ConfirmationDialog" style="overflow:hidden">
					<div id="AdPreviewContainer" style="overflow:hidden"></div>
				</div>
			</div>
			<div id="clothing-upload-fun-captcha-container">
				<div id="clothing-upload-fun-captcha-backdrop"></div>
				<div id="clothing-upload-fun-captcha-modal"></div>
			</div>
			<div style="clear:both"></div>
		</div>
	</div>
</div>
<?php
require_once($_SERVER["STATIC"]."/footer.php");
?>