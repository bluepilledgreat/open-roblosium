<?php
require_once($_SERVER["STATIC"]."/settings.php");
require_once($_SERVER["STATIC"]."/authentication.php");
require_once($_SERVER["STATIC"]."/assets.php");
require_once($_SERVER["STATIC"]."/package_compiler.php");
require_once($_SERVER["STATIC"]."/utilities.php");
AddCSS(CSS_DEFAULT_PACKAGE);
AddCSS(PackageCompiler::CompilePackage("page", ["/CSS/PartialViews/Navigation.css", "/CSS/Base/CSS/Ads.css", "/CSS/Pages/Catalog.css"], null));
AddJS(JS_DEFAULT_PACKAGE);
AddJS(PackageCompiler::CompilePackage("page", ["/js/GenericConfirmation.js", "/js/jquery.simplemodal-1.3.5.js", "/js/GenericModal.js", "/js/Item.js", "/js/ItemPurchase.js"], ["/js/GPTAdScript.js"]));

// MAKE ALL GET STATEMENTS LOWERCASE
$_GET = array_change_key_case($_GET, CASE_LOWER);

// check if seoname is set
if (!isset($_GET["seoname"]))
	header("Location: /".constructSeoPageUrl("redirect", "item", ["id" => $Asset->id]));

// INITIALIZE ASSET CLASS
$AssetClass = new Asset($_GET["id"]);
if (!$AssetClass->exists) die("asset doesnt exist geno add proper error page plz");
$Asset = $AssetClass->GetAllAssetInfo();

// check if seoname is valid
if ($_GET["seoname"] !== createSeoName($Asset->title))
	header("Location: /".constructSeoPageUrl($Asset->title, "item", ["id" => $Asset->id]));

// GET CREATOR INFO
$Creator = (object)(new UserAuthentication($Asset->uid))->GetAllUserInfo();

// GET ASSET GENRES
$AssetGenres = explode(",", $Asset->genre);

// HANDLE REMOVAL FROM INVENTORY
if(isset($_POST["__EVENTTARGET"]) && $_POST["__EVENTTARGET"] == 'ctl00$cphRoblox$btnDelete') 
{
	if(!$AssetClass->RemoveFromInventory($userAuth->GetUserInfo("id")))
	{
		http_response_code(500);
		die(require_once("../RobloxDefaultErrorPage.aspx"));
	}
}

$_PS->Title = $Asset->title.", a ".$_S->AssetTypes[$Asset->assettype]["name"]." by ".$Creator->username." - ROBLOX (updated N/A)"; // geno, plz do update date (https://web.archive.org/web/20131105023152/http://www.roblox.com/Headless-Horseman-item?id=134082613)
require_once($_SERVER["STATIC"]."/header.php");
?>
<div id="BodyWrapper">
   <div id="RepositionBody">
      <div id="Body" style='width:970px;'>
         <div id="ItemContainer" class="text">
            <div>
               <div id="ctl00_cphRoblox_GearDropDown" class="SetList ItemOptions <?php echo (!$AssetClass->IsInInventory($userAuth->GetUserInfo("id"))) ? "invisible" : ""; ?>" data-isdropdownhidden="<?php echo ($AssetClass->IsInInventory($userAuth->GetUserInfo("id"))) ? "False" : "True"; ?>" data-isitemlimited="False" data-isitemresellable="False">
                  <a href="#" class="btn-dropdown">
                  <img src="http://images.rbxcdn.com/ea51d75440715fc531fc3ad281c722f3.png" />
                  </a>
                  <div class="clear"></div>
                  <div class="SetListDropDown">
                     <div class="SetListDropDownList invisible">
                        <div class="menu invisible">
                           <div id="ctl00_cphRoblox_ItemOwnershipPanel">
                              <a onclick="confirmDelete(this);return false;" id="ctl00_cphRoblox_btnDelete" href="javascript:WebForm_DoPostBackWithOptions(new WebForm_PostBackOptions(&quot;ctl00$cphRoblox$btnDelete&quot;, &quot;&quot;, true, &quot;&quot;, &quot;&quot;, false, true))">Delete from My Stuff</a>
                           </div>
                        </div>
                     </div>
                  </div>
               </div>
               <h1 class="notranslate" data-se="item-name">
                  <?php echo htmlspecialchars($Asset->title); ?>
               </h1>
               <h3>
                  ROBLOX <?php echo $_S->AssetTypes[$Asset->assettype]["name"]; ?>
               </h3>
            </div>
            <div id="Item">
               <div id="Details">
                  <div id="assetContainer">
                     <div id="Thumbnail">
                        <a id="ctl00_cphRoblox_AssetThumbnailImage" disabled="disabled" class="AssetThumbnailImage" title="ROBLOX" class="AssetThumbnailImage" onclick="return false" style="display:inline-block;height:320px;width:320px;"><img src="/Thumbs/RawAsset.ashx?assetId=<?php echo $Asset->id; ?>&format=PNG&width=420&height=420" height="320" width="320" border="0" onerror="return Roblox.Controls.Image.OnError(this)" alt="<?php echo htmlspecialchars($Asset->title); ?>" class="AssetThumbnailImage" /></a>
                     </div>
                  </div>
                  <div id="Summary">
                     <div class="SummaryDetails">
                        <div id="Creator" class="Creator">
                           <div class="Avatar">
                              <a id="ctl00_cphRoblox_AvatarImage" class=" notranslate" class=" notranslate" title="<?php echo htmlspecialchars($Creator->username); ?>" href="/User.aspx?ID=<?php echo htmlspecialchars($Asset->uid); ?>" style="display:inline-block;height:70px;width:70px;cursor:pointer;"><img src="/images/boy_guest.png" height="70" width="70" border="0" onerror="return Roblox.Controls.Image.OnError(this)" alt="<?php echo htmlspecialchars($Creator->username); ?>" class=" notranslate" /><img src="/images/icons/overlay_tbcOnly.png" align="left" style="position:relative;top:-19px;" /></a>
                           </div>
                        </div>
                        <div class="item-detail">
                           <span class="stat-label notranslate">Creator:</span>
                           <a id="ctl00_cphRoblox_CreatorHyperLink" class="stat notranslate" href="User.aspx?ID=<?php echo htmlspecialchars($Asset->uid); ?>"><?php echo htmlspecialchars($Creator->username); ?></a>
                           <div>
                              <span class="stat-label">Created:</span>
                              <span class="stat">
                              <?php echo gmdate("m/d/Y", $Asset->item_created); ?>
                              </span>
                           </div>
                           <div id="LastUpdate">
                              <span class="stat-label">Updated:</span>
                              <span class="stat">
                              <?php echo time_elapsed_string('@' . $Asset->item_updated); ?>
                              </span>
                           </div>
                        </div>
                        <div id="ctl00_cphRoblox_DescriptionPanel" class="DescriptionPanel notranslate">
                           <pre class="Description Full text"><?php echo htmlspecialchars($Asset->description); ?></pre>
                           <pre class="Description body text"><?php echo htmlspecialchars($Asset->description); ?></pre>
                        </div>
                        <div class="ReportAbuse">
                           <div id="ctl00_cphRoblox_AbuseReportButton1_AbuseReportPanel" class="ReportAbuse">
                              <span class="AbuseIcon"><a id="ctl00_cphRoblox_AbuseReportButton1_ReportAbuseIconHyperLink" href="abusereport/asset?id=<?php echo $Asset->id; ?>&amp;RedirectUrl=http%3a%2f%2fwww.roblox.com%2fitem.aspx%3fseoname%3dBat-Wings%26id%3d<?php echo $Asset->id; ?>"><img src="images/abuse.PNG?v=2" alt="Report Abuse" style="border-width:0px;" /></a></span>
                              <span class="AbuseButton"><a id="ctl00_cphRoblox_AbuseReportButton1_ReportAbuseTextHyperLink" href="abusereport/asset?id=<?php echo $Asset->id; ?>&amp;RedirectUrl=http%3a%2f%2fwww.roblox.com%2fitem.aspx%3fseoname%3dBat-Wings%26id%3d<?php echo $Asset->id; ?>">Report Abuse</a></span>
                           </div>
                        </div>
						<?php if(isset($AssetGenres))
						{ ?>
                        <div class="GearGenreContainer divider-top">
                           <div id="GenresDiv">
                              <div id="ctl00_cphRoblox_Genres">
                                 <div class="stat-label">
                                    Genres:
                                 </div>
                                <?php foreach($AssetGenres as $Genre)
								{ 
									if (isset($_S->Genres[$Genre])) {
								?>
								 <div class="GenreInfo stat">
                                    <div>
                                       <div id="ctl00_cphRoblox_GenresDisplayTest_AssetGenreRepeater_ctl02_AssetGenreRepeaterPanel" class="AssetGenreRepeater_Container">
                                          <div class="GamesInfoIcon <?php echo $_S->Genres[$Genre]["cssname"]; ?>"></div>
                                          <div><a href="/games?genreFilter=<?php echo $_S->Genres[$Genre]["id"]; ?>"><?php echo $_S->Genres[$Genre]["name"]; ?></a></div>
                                       </div>
                                       <div style="clear:both;"></div>
                                    </div>
                                 </div>
								<?php
									}
								}
								?>
                              </div>
                           </div>
                           <div class="clear"></div>
                        </div>
						<?php
						}
						?>
                     </div>
                     <div class="BuyPriceBoxContainer">
                        <div class="BuyPriceBox">
						<?php if($Asset->robux > 0)
						   { ?>
                           <div id="ctl00_cphRoblox_RobuxPurchasePanel">
                              <div id="RobuxPurchase">
                                 <div class="calloutParent">
                                    Price: <span class="robux " data-se="item-priceinrobux">
                                    <?php echo $Asset->robux; ?>
                                    </span>
                                 </div>
                                 <div id="BuyWithRobux">
                                    <div data-expected-currency="1" data-asset-type="<?php echo $_S->AssetTypes[$Asset->assettype]["name"]; ?>" class="btn-primary btn-medium PurchaseButton <?php echo ($AssetClass->IsInInventory($userAuth->GetUserInfo("id"))) ? "btn-disabled-primary\" original-title=\"You already own this item.\"" : "\""; ?> data-se="item-buyforrobux" data-item-name="<?php echo htmlspecialchars($Asset->title); ?>" data-item-id="<?php echo $Asset->id; ?>" data-expected-price="<?php echo $Asset->robux; ?>" data-product-id="<?php echo $Asset->id; ?>" data-expected-seller-id="<?php echo $Asset->uid; ?>"  data-bc-requirement="0" data-seller-name="<?php echo htmlspecialchars($Creator->username); ?>">
                                       Buy with R$
                                       <span class="btn-text">Buy with R$</span>
                                    </div>
                                 </div>
                              </div>
                              <div class="clear"></div>
                           </div>
						   <?php
						   }
						   ?>
						   <?php if($Asset->robux > 0 && $Asset->tickets > 0)
						   { ?>
						   <div id="ctl00_cphRoblox_RobuxAndTicketsPurchasePanel" class="RobuxAndTicketsPurchasePanel"></div>
						   <?php 
						   }
						   ?>
						   <?php if($Asset->tickets > 0)
						   { ?>
						   <div id="ctl00_cphRoblox_TicketsPurchasePanel">
                              <div id="TicketsPurchase">
                                 <div class="calloutParent">
                                    Price: <span class="tickets " data-se="item-priceintickets">
                                    <?php echo $Asset->tickets; ?>
                                    </span>
                                 </div>
                                 <div id="BuyWithTickets">
                                    <div data-expected-currency="2" data-asset-type="<?php echo $_S->AssetTypes[$Asset->assettype]["name"]; ?>" class="btn-primary btn-medium PurchaseButton <?php echo ($AssetClass->IsInInventory($userAuth->GetUserInfo("id"))) ? "btn-disabled-primary\" original-title=\"You already own this item.\"" : "\""; ?> data-se="item-buyfortickets" data-item-name="<?php echo htmlspecialchars($Asset->title); ?>" data-item-id="<?php echo $Asset->id; ?>" data-expected-price="<?php echo $Asset->tickets; ?>" data-product-id="<?php echo $Asset->id; ?>" data-expected-seller-id="<?php echo $Asset->uid; ?>" data-bc-requirement="0" data-seller-name="<?php echo htmlspecialchars($Creator->username); ?>">
                                       Buy with Tx
                                       <span class="btn-text">Buy with Tx</span>
                                    </div>
                                 </div>
                              </div>
                              <div class="clear"></div>
                           </div>
						   <?php 
						   }
						   ?>
						   <?php if($Asset->robux == 0 && $Asset->tickets == 0)
						   { ?>
						   <div id="ctl00_cphRoblox_PublicDomainPurchasePanel">
                                <div class="PublicDomainPrice">
                                    Price: <span class="robux-text " data-se="item-price-free">FREE</span>
                                </div>
                                <div id="BuyForFree">
                                    <div data-expected-currency="1" data-asset-type="<?php echo $_S->AssetTypes[$Asset->assettype]["name"]; ?>" class="btn-primary btn-medium PurchaseButton <?php echo ($AssetClass->IsInInventory($userAuth->GetUserInfo("id"))) ? "btn-disabled-primary\" original-title=\"You already own this item.\"" : "\""; ?> data-se="item-buyforfree" data-item-name="<?php echo htmlspecialchars($Asset->title); ?>" data-item-id="<?php echo $Asset->id; ?>" data-expected-price="<?php echo $Asset->tickets; ?>" data-product-id="<?php echo $Asset->id; ?>" data-expected-seller-id="<?php echo $Asset->uid; ?>" data-bc-requirement="0" data-seller-name="<?php echo htmlspecialchars($Creator->username); ?>">
                                         Take One
                                        <span class="btn-text">Take One</span>
                                    </div>
                                </div>
                            </div>
						   <?php 
						   }
						   ?>
                           <div class="clear">
                           </div>
                           <div class="footnote">
                              <div id="ctl00_cphRoblox_Sold">
                                 (<span data-se="item-numbersold"><?php echo $AssetClass->GetAmountSold(); ?></span> 
                                 Sold)
                              </div>
                           </div>
                        </div>
                        <div class="clear"></div>
                        <span>
                        <!-- <span class="FavoriteStar" data-se="item-numberfavorited">
                        FAVORITES GO HERE -GENO
                        </span> -->
                        </span>
                     </div>
                     <div class="clear"></div>
                     <div class="SocialMediaContainer">
                     </div>
                  </div>
                  <div class="clear"></div>
               </div>
               <div class="PrivateSales divider-top invisible" >
                  <h2>Private Sales</h2>
                  <div id="UserSalesTab" >
                     <div class="empty">
                        Sorry, no one is privately selling this item at the moment.
                     </div>
                     <div class="pgItemsForResale">
                        <span id="ctl00_cphRoblox_pgItemsForResale"><a disabled="disabled">First</a>&nbsp;<a disabled="disabled">Previous</a>&nbsp;<a disabled="disabled">Next</a>&nbsp;<a disabled="disabled">Last</a>&nbsp;</span>
                     </div>
                  </div>
                  <div class="clear"></div>
               </div>
               <div id="Tabs">
                  <ul id="TabHeader" class="WhiteSquareTabsContainer">
                     <li id="RecommendationsTabHeader" contentid="RecommendationsTab" class="SquareTabGray ItemTabs selected">
                        <span><a id="RecommendationsLink" href="#RecommendationsTab">
                        Recommendations</a></span>
                     </li>
                     <li id="CommentaryTabHeader" contentid="CommentaryTab" class="SquareTabGray ItemTabs ">
                        <span><a id="CommentaryLink" href="#CommentaryTab">
                        Commentary</a></span>
                     </li>
                  </ul>
                  <div class="StandardPanelContainer">
                     <div id="ScriptReviewTab" class="StandardPanelWhite TabContent selected">
                     </div>
                     <div id="RecommendationsTab" class="StandardPanelWhite TabContent selected">
                        <div class="AssetRecommenderContainer">
                           <table id="ctl00_cphRoblox_AssetRec_dlAssets" cellspacing="0" align="Center" border="0" style="height:175px;width:800px;border-collapse:collapse;">
                              <tr>
                                 <td>
                                    <div class="PortraitDiv" style="width: 140px;overflow: hidden;margin:auto;" visible="True" data-se="recommended-items-0">
                                       <div class="AssetThumbnail">
                                          <a id="ctl00_cphRoblox_AssetRec_dlAssets_ctl00_AssetThumbnailHyperLink" class=" notranslate" title="Heat Vision Goggles" class=" notranslate" href="/Heat-Vision-Goggles-item?id=10748238" style="display:inline-block;height:110px;width:110px;cursor:pointer;"><img src="http://t2.rbxcdn.com/bcbad97117b3288c21fd5939fede1abe" height="110" width="110" border="0" onerror="return Roblox.Controls.Image.OnError(this)" alt="Heat Vision Goggles" class=" notranslate" /></a>
                                       </div>
                                       <div class="AssetDetails">
                                          <div class="AssetName noTranslate">
                                             <a id="ctl00_cphRoblox_AssetRec_dlAssets_ctl00_AssetNameHyperLinkPortrait" href="/Heat-Vision-Goggles-item?id=10748238">Heat Vision Goggles</a>
                                          </div>
                                          <div class="AssetCreator">
                                             <span class="stat-label">Creator:</span> <span class="Detail stat"><a id="ctl00_cphRoblox_AssetRec_dlAssets_ctl00_CreatorHyperLinkPortrait" class="notranslate" href="User.aspx?ID=<?php echo htmlspecialchars($Asset->uid); ?>"><?php echo htmlspecialchars($Creator->username); ?></a></span>
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
                     <div id="CommentaryTab" class="StandardPanelWhite TabContent " >
                        <div id="ctl00_cphRoblox_CommentsPane_CommentsUpdatePanel">
                           <div id="AjaxCommentsPaneData" data-comments-floodcheck="3600"></div>
                           <div class="AjaxCommentsContainer">
                              <div class="Comments" data-asset-id="<?php echo $Asset->id; ?>"></div>
                              <div class="CommentsItemTemplate">
                                 <div class="Comment text">
                                    <div class="Commenter">
                                       <div class="Avatar" data-user-id="%CommentAuthorID" data-image-size="small">
                                       </div>
                                    </div>
                                    <div class="PostContainer">
                                       <div class="Post">
                                          <div class="Audit">
                                             <span class="ByLine footnote">
                                                <div class="UserOwnsAsset" title="User has this item" alt="User has this item" style="display:none;"></div>
                                                Posted %CommentCreated ago by <a href="/user.aspx?id=%CommentAuthorID">%CommentAuthor</a>
                                             </span>
                                             <div class="ReportAbuse">
                                                <span class="AbuseButton">
                                                <a href="AbuseReport/Comment.aspx?ID=%CommentID&amp;RedirectUrl=%PageURL">Report Abuse</a>
                                                </span>
                                             </div>
                                             <div style="clear:both;"></div>
                                          </div>
                                          <div class="Content">
                                             %CommentContent
                                          </div>
                                          <div id="Actions" class="Actions" >
                                             <a data-comment-id="%CommentID" class="DeleteCommentButton">Delete Comment</a>
                                          </div>
                                       </div>
                                       <div class="PostBottom"></div>
                                    </div>
                                    <div style="clear:both;"></div>
                                 </div>
                              </div>
                           </div>
                        </div>
                        <script type="text/javascript">
                           Roblox.CommentsPane.Resources = {
                               //<sl:translate>
                               defaultMessage:         'Write a comment!',
                               floodCheckString:		'You may only post a comment once every ',
                               seconds:				' seconds',
                               noCommentsFound:		'No comments found.',
                               moreComments:			'More comments',
                               sorrySomethingWentWrong:'Sorry, something went wrong.',
                               charactersRemaining:	' characters remaining',
                               emailVerifiedABTitle:	'Verify Your Email',
                               emailVerifiedABMessage: "You must verify your email before you can comment. You can verify your email on the <a href='/My/Account.aspx?confirmemail=1'>Account</a> page.",
                               linksNotAllowedTitle:   'Links Not Allowed',
                               linksNotAllowedMessage: 'Comments should be about the item or place on which you are commenting. Links are not permitted.',
                               accept:					'Verify',
                               decline:				'Cancel',
                               tooManyCharacters:		'Too many characters!',
                               tooManyNewlines:		'Too many newlines!'
                               //</sl:translate>
                              };
                           
                              Roblox.CommentsPane.Limits =
                              [	{ limit: '10'
                                   , character: "\n"
                                   , message: Roblox.CommentsPane.Resources.tooManyNewlines
                                   }
                              ,	{ limit: '200'
                                   , character: undefined
                                   , message: Roblox.CommentsPane.Resources.tooManyCharacters
                                   }
                              ];
                           
                              Roblox.CommentsPane.FilterIsEnabled = true;
                              Roblox.CommentsPane.FilterRegex = "(([a-zA-Z0-9-]+\\.[a-zA-Z]{2,4}[:\\#/\?]+)|([a-zA-Z0-9]\\.[a-zA-Z0-9-]+\\.[a-zA-Z]{2,4}))";
                              Roblox.CommentsPane.FilterCleanExistingComments = false;
                           
                           Roblox.CommentsPane.initialize();
                        </script>
                     </div>
                  </div>
               </div>
			   <!--
               <div id="FreeGames">
                  <div class='SEOLinksContainer'>
                     <span><b>Other free games and items:</b></span>
                     <ul class='freegames'>
                        <li><a class='notranslate' href='/pikachu6613s-Place-place?id=19399758' title='Free Games: pikachu6613's Place'>pikachu6613's Place</a></li>
                        <li><a class='notranslate' href='/Opened-Gift-of-many-thanks-item?id=19399848' title='Free Games: Opened Gift of many thanks!'>Opened Gift of many thanks!</a></li>
                        <li><a class='notranslate' href='/acustomsign-item?id=19399857' title='Free Games: acustomsign'>acustomsign</a></li>
                        <li><a class='notranslate' href='/Oven-1-item?id=19399859' title='Free Games: Oven 1'>Oven 1</a></li>
                        <li><a class='notranslate' href='/kalebrocks87s-Place-place?id=19399868' title='Free Games: kalebrocks87's Place'>kalebrocks87's Place</a></li>
                        <li><a class='notranslate' href='/coldude12934s-Place-place?id=19399958' title='Free Games: coldude12934's Place'>coldude12934's Place</a></li>
                     </ul>
                  </div>
               </div>
            </div> -->
            <div class="Ads_WideSkyscraper">
               <div style="width: 160px">
                  <span id='3132383439333439' class="GPTAd skyscraper" data-js-adtype="gptAd">
                     <script type="text/javascript">
                        googletag.cmd.push(function () {
                            googletag.display("3132383439333439");
                        });
                     </script>
                  </span>
                  <div class="ad-annotations " style="width: 160px">
                     <span class="ad-identification">Advertisement</span>
                     <a class="BadAdButton" href="/Ads/ReportAd.aspx" title="click to report an offensive ad">Report</a>
                  </div>
               </div>
            </div>
            <div class="clear">
            </div>
         </div>
         <div id="ItemPurchaseAjaxData"
            data-authenticateduser-isnull="<?php echo ($userAuth) ? "False" : "True"; ?>"
            data-user-balance-robux="<?php echo ($userAuth !== false) ? $userAuth->GetUserInfo("robux") : 0; ?>"
            data-user-balance-tickets="<?php echo ($userAuth !== false) ? $userAuth->GetUserInfo("tickets") : 0; ?>"
            data-user-bc="<?php echo ($userAuth !== false && $userAuth->GetUserInfo("membershiptype") !== "None") ? 1 : 0; ?>"
            data-continueshopping-url="/Catalog"
            data-imageurl="http://t0.rbxcdn.com/ae2560793de679afb5f88e5dfbab5521" 
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
                continueShoppingText : "Continue Shopping",
                customizeCharacterText : "Customize Character",
                orText : "or",
                rentText : "rent",
                accessText: "access to "
            }
            //</sl:translate>
         </script>
         <div id="ctl00_cphRoblox_CreateSetPanelDiv" class="createSetPanelPopup">
         </div>
         <div class="GenericModal modalPopup unifiedModal smallModal" style="display:none;">
            <div class="Title"></div>
            <div class="GenericModalBody">
               <div>
                  <div class="ImageContainer roblox-item-image"  data-image-size="small" data-no-overlays data-no-click>
                     <img class="GenericModalImage" alt="generic image" />
                  </div>
                  <div class="Message"></div>
                  <div style="clear:both"></div>
               </div>
               <div class="GenericModalButtonContainer">
                  <a class="ImageButton btn-neutral btn-large roblox-ok" >OK<span class="btn-text">OK</span></a> 
               </div>
            </div>
         </div>
         <div id="BCOnlyModal" class="modalPopup unifiedModal smallModal" style="display:none;">
            <div style="margin:4px 0px;">
               <span>Builders Club Only</span>
            </div>
            <div class="simplemodal-close">
               <a class="ImageButton closeBtnCircle_20h" style="margin-left:400px;"></a>
            </div>
            <div class="unifiedModalContent" style="padding-top:5px; margin-bottom: 3px; margin-left: 3px; margin-right: 3px">
               <div class="ImageContainer" >
                  <img class="GenericModalImage BCModalImage" alt="Builder's Club" src="http://images.rbxcdn.com/ae345c0d59b00329758518edc104d573.png" />
                  <div id="BCMessageDiv" class="BCMessage Message">
                     You need  to buy this item!
                  </div>
               </div>
               <div style="clear:both;"></div>
               <div style="clear:both;"></div>
               <div class="GenericModalButtonContainer" style="padding-bottom: 13px">
                  <div class="ButtonUpgradeNow">
                     <a id="BClink" href="/Upgrades/BuildersClubMemberships.aspx" style="display:block; height:50px; width:173px;"></a>
                  </div>
                  <div style="clear:both;"></div>
               </div>
               <div style="clear:both;"></div>
            </div>
         </div>
         <script type="text/javascript">
            function showBCOnlyModal(modalId) {
                var modalProperties = { overlayClose: true, escClose: true, opacity: 80, overlayCss: { backgroundColor: "#000" } };
                if (typeof modalId === "undefined")
                    $("#BCOnlyModal").modal(modalProperties);
                else
                    $("#" + modalId).modal(modalProperties);
            }
            $(document).ready(function () {
                $('#NULL').click(function () {
                    showBCOnlyModal("BCOnlyModal");
                    return false;
                });
            });
         </script>
         <div class="GenericModal modalPopup unifiedModal smallModal" style="display:none;">
            <div class="Title"></div>
            <div class="GenericModalBody">
               <div>
                  <div class="ImageContainer roblox-item-image"  data-image-size="small" data-no-overlays data-no-click>
                     <img class="GenericModalImage" alt="generic image" />
                  </div>
                  <div class="Message"></div>
                  <div style="clear:both"></div>
               </div>
               <div class="GenericModalButtonContainer">
                  <a class="ImageButton btn-neutral btn-large roblox-ok" >OK<span class="btn-text">OK</span></a> 
               </div>
            </div>
         </div>
         <script type="text/javascript"> 
            Roblox.Resources = {};
            Roblox.Resources.PlaceProductPromotion = {
                //<sl:translate>
                anErrorOccurred: 'An error occurred, please try again.'
                , youhaveAdded: "You have added "
                , toYourGame: " to your game, "
                , youhaveRemoved: "You have removed "
                , fromYourGame: " from your game, "
                , ok: "OK"
                , success: "Success!"
                , error: "Error"
                , sorryWeCouldnt: "Sorry, we couldn't remove the item from your game. Please try again."
             , notForSale: "This item is not for sale."
             , rent: "Rent"
                //<sl:translate>
            };
            
            var commentsLoaded = false;
            
            //Tabs
            function SwitchTabs(nextTabElem) {
                $('.WhiteSquareTabsContainer .selected,  .TabContent.selected').removeClass('selected');
                nextTabElem.addClass('selected');
                $('#' + nextTabElem.attr('contentid')).addClass('selected');
            
                var label = $.trim(nextTabElem.attr('contentid'));
                if(label == "CommentaryTab" && !commentsLoaded) {
                    Roblox.CommentsPane.getComments(0);
                    commentsLoaded = true;
                    if(Roblox.SuperSafePrivacyMode != undefined) {
                        Roblox.SuperSafePrivacyMode.initModals();
                    }
                    return false;
                }
            }
            
                SwitchTabs($('#RecommendationsTabHeader'));
            
            $('.WhiteSquareTabsContainer li').bind('click', function (event) {
                event.preventDefault();
                SwitchTabs($(this));
            });
            
            
            function confirmDelete() {
                Roblox.GenericConfirmation.open({
                    //<sl:translate>
                    titleText: "Delete Item",
                    bodyContent: "Are you sure you want to permanently DELETE this item from your inventory?",
                    //</sl:translate>
                    onAccept: function () {
                        javascript: __doPostBack('ctl00$cphRoblox$btnDelete', '');
                    },
                    acceptColor: Roblox.GenericConfirmation.blue,
                    //<sl:translate>
                    acceptText: "OK"
                    //</sl:translate>
                });
            }
            
            function confirmSubmit() {
                Roblox.GenericConfirmation.open({
                    //<sl:translate>
                    titleText: "Create New Badge Giver",
                    bodyContent: "This will add a new badge giver model to your inventory. Are you sure you want to do this?",
                    //</sl:translate>
                    onAccept: function () {
                        window.location.href = $('#ctl00_cphRoblox_btnSubmit').attr('href');
                    },
                    acceptColor: Roblox.GenericConfirmation.blue,
                    //<sl:translate>
                    acceptText: "OK"
                    //</sl:translate>
                });
            }
            
            modalProperties = { escClose: true, opacity: 80, overlayCss: { backgroundColor: "#000"} };
            
            // Code for Modal Popups
            $(function() {
            
                $(".btn-disabled-primary").removeClass("Button").tipsy({ gravity: 's' }).attr("href", "javascript: return false;");
            });
            function ModalClose(popup) {
                $.modal.close('.' + popup);
            }
         </script>
         <div style="clear:both"></div>
      </div>
   </div>
</div>
<?php
require_once($_SERVER["STATIC"]."/footer.php");
?>