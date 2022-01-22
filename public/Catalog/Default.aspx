<?php
require_once($_SERVER["STATIC"]."/settings.php");
require_once($_SERVER["STATIC"]."/authentication.php");
require_once($_SERVER["STATIC"]."/package_compiler.php");
require_once($_SERVER["STATIC"]."/utilities.php");
AddCSS(CSS_DEFAULT_PACKAGE);
AddCSS(PackageCompiler::CompilePackage("page", ["/CSS/PartialViews/Navigation.css", "/CSS/Base/CSS/Ads.css", "/CSS/Pages/Catalog.css"], null));
AddJS(JS_DEFAULT_PACKAGE);
AddJS(PackageCompiler::CompilePackage("page", ["/js/GenericConfirmation.js", "/js/jquery.simplemodal-1.3.5.js", "/js/GenericModal.js"], ["/js/GPTAdScript.js"]));

// GET ITEMS FOR CATALOG
$stmt = $conn->prepare("SELECT * FROM assets WHERE assettype = ".implode(" OR assettype=", $_S->CatalogCategories[1]["subcategories"])." ORDER BY id DESC LIMIT 0, 24");
$stmt->execute();

// SET VARS
$ItemCount = $stmt->rowCount();
$ItemsArr = $stmt->fetchAll(PDO::FETCH_OBJ);

$_PS->Title = "Avatar Items, Virtual Avatars, Virtual Goods";
require_once($_SERVER["STATIC"]."/header.php");
?>
<div id="BodyWrapper">
   <div id="RepositionBody">
      <div id="Body" style='width:970px;'>
         <style type="text/css">
            #Body {
            padding: 10px;
            }
         </style>
         <div id="catalog" data-empty-search-enabled="true">
            <div class="header" style="height:60px;">
               <div style="float:left;">
                  <h1><a href="/catalog/" id="CatalogLink">Catalog</a></h1>
               </div>
               <div class="CatalogSearchBar">
                  <input id="keywordTextbox" name="name" type="text" class="translate text-box text-box-small" value="" />
                  <div style="height:23px;border:1px solid #a7a7a7;padding:2px 2px 0px 2px;margin-right:6px;float:left;position:relative">
                     <!--[if IE7]>
                     <div style="height:19px;width:131px;position:absolute;top:2px;left:2px;border:1px solid white"></div>
                     <div style="height:19px;width:15px;position:absolute;top:2px;right:2px;border:1px solid #aaa"></div>
                     <![endif]-->
                     <select id="categoriesForKeyword" style="">
                        <option value="1">All Categories</option>
                        <option value="0">Featured</option>
                        <option value="2">Collectibles</option>
                        <option value="3">Clothing</option>
                        <option value="4">Body Parts</option>
                        <option value="5">Gear</option>
                        <option value="8">Decals</option>
                        <option value="6">Models</option>
                        <option value="9">Audio</option>
                     </select>
                  </div>
                  <a id="submitSearchButton" href="#" class="btn-control btn-control-large top-level">Search</a>
               </div>
            </div>
            <div class="left-nav-menu divider-right">
               <a id="BrowseCategoriesButton" class="browseDropdownButton hover roblox-hierarchicaldropdownbutton"></a>
               <div id="dropdown" class="splashdropdown roblox-hierarchicaldropdown">
                  <ul id="dropdownUl" class="clearfix">
                     <li class="subcategories" data-delay="never">
                        <a href="#category=featured" class="assetTypeFilter" data-category="0">Featured</a>
                        <ul class="slideOut" style="top:-1px;">
                           <li class="slideHeader"><span>Featured Types</span></li>
                           <li><a href="#category=featured" class="assetTypeFilter" data-types="0" data-category="0">All Featured Items</a></li>
                           <li><a href="#category=featured" class="assetTypeFilter" data-types="9" data-category="0">Featured Hats</a></li>
                           <li><a href="#category=featured" class="assetTypeFilter" data-types="5" data-category="0">Featured Gear</a></li>
                           <li><a href="#category=featured" class="assetTypeFilter" data-types="10" data-category="0">Featured Faces</a></li>
                           <li><a href="#category=featured" class="assetTypeFilter" data-types="11" data-category="0">Featured Packages</a></li>
                        </ul>
                     </li>
                     <li class="subcategories">
                        <a href="#category=collectibles" class="assetTypeFilter collectiblesLink" data-category="2">Collectibles</a>
                        <ul class="slideOut" style="top:-32px;">
                           <li class="slideHeader"><span>Collectible Types</span></li>
                           <li><a href="#category=collectibles" class="assetTypeFilter" data-types="2" data-category="2">All Collectibles</a></li>
                           <li><a href="#category=collectibles" class="assetTypeFilter" data-types="10" data-category="2">Collectible Faces</a></li>
                           <li><a href="#category=collectibles" class="assetTypeFilter" data-types="9" data-category="2">Collectible Hats</a></li>
                           <li><a href="#category=collectibles" class="assetTypeFilter" data-types="5" data-category="2">Collectible Gear</a></li>
                        </ul>
                     </li>
                     <li class="slideHeader DropdownDivider divider-bottom" data-delay="ignore"></li>
                     <li data-delay="always">
                        <a href="#category=all" class="assetTypeFilter" data-category="1">All Categories</a>
                     </li>
                     <li class="subcategories">
                        <a href="#category=clothing" class="assetTypeFilter" data-category="3">Clothing</a>
                        <ul class="slideOut" style="top:-97px;">
                           <li class="slideHeader"><span>Clothing Types</span></li>
                           <li><a href="#" class="assetTypeFilter" data-types="3" data-category="3">All Clothing</a></li>
                           <li><a href="#" class="assetTypeFilter" data-types="9" data-category="3">Hats</a></li>
                           <li><a href="#" class="assetTypeFilter" data-types="12" data-category="3">Shirts</a></li>
                           <li><a href="#" class="assetTypeFilter" data-types="13" data-category="3">T-Shirts</a></li>
                           <li><a href="#" class="assetTypeFilter" data-types="14" data-category="3">Pants</a></li>
                           <li><a href="#" class="assetTypeFilter" data-types="11" data-category="3">Packages</a></li>
                        </ul>
                     </li>
                     <li class="subcategories">
                        <a href="#category=bodyparts" class="assetTypeFilter" data-category="4">Body Parts</a>
                        <ul class="slideOut" style="top:-128px;">
                           <li class="slideHeader"><span>Body Part Types</span></li>
                           <li><a href="#category=bodyparts" class="assetTypeFilter" data-types="4" data-category="4">All Body Parts</a></li>
                           <li><a href="#category=bodyparts" class="assetTypeFilter" data-types="15" data-category="4">Heads</a></li>
                           <li><a href="#category=bodyparts" class="assetTypeFilter" data-types="10" data-category="4">Faces</a></li>
                           <li><a href="#category=bodyparts" class="assetTypeFilter" data-types="11" data-category="4">Packages</a></li>
                        </ul>
                     </li>
                     <li class="subcategories">
                        <a href="#category=gear" class="assetTypeFilter" data-category="5">Gear</a>
                        <ul class="slideOut" style="top:-159px; width:auto;" style="border-right:0px;">
                           <div>
                              <li class="slideHeader"><span>Gear Categories</span></li>
                              <li><a href="#geartype=All Gear" class="gearFilter" data-category="5" data-types="All">All Gear</a></li>
                              <li><a href="#geartype=Melee Weapon" class="gearFilter" data-category="5" data-types="1">Melee Weapon</a></li>
                              <li><a href="#geartype=Ranged Weapon" class="gearFilter" data-category="5" data-types="2">Ranged Weapon</a></li>
                              <li><a href="#geartype=Explosive" class="gearFilter" data-category="5" data-types="3">Explosive</a></li>
                              <li><a href="#geartype=Power Up" class="gearFilter" data-category="5" data-types="4">Power Up</a></li>
                              <li><a href="#geartype=Navigation Enhancer" class="gearFilter" data-category="5" data-types="5">Navigation Enhancer</a></li>
                              <li><a href="#geartype=Musical Instrument" class="gearFilter" data-category="5" data-types="6">Musical Instrument</a></li>
                           </div>
                           <div id="gearSecondColumn">
                              <li><a href="#geartype=Social Item" class="gearFilter" data-category="5" data-types="7">Social Item</a></li>
                              <li><a href="#geartype=Building Tool" class="gearFilter" data-category="5" data-types="8">Building Tool</a></li>
                              <li><a href="#geartype=Personal Transport" class="gearFilter" data-category="5" data-types="9">Personal Transport</a></li>
                           </div>
                        </ul>
                     </li>
                     <li><a href="#category=models" class="assetTypeFilter" data-category="6">Models</a></li>
                     <li><a href="#category=decals" class="assetTypeFilter" data-category="8">Decals</a></li>
                     <li><a href="#category=audio" class="assetTypeFilter" data-category="9">Audio</a></li>
                  </ul>
               </div>
               <div id="legend" class="">
                  <div class="header expanded" id="legendheader">
                     <h3>Legend</h3>
                  </div>
                  <div id="legendcontent" style="overflow: hidden; ">
                     <img src="http://images.rbxcdn.com/4fc3a98692c7ea4d17207f1630885f68.png" style="margin-left: -13px" />
                     <div class="legendText"><b>Builders Club Only</b><br/>
                        Only purchasable by Builders Club members.
                     </div>
                     <img src="http://images.rbxcdn.com/793dc1fd7562307165231ca2b960b19a.png" style="margin-left: -13px" />
                     <div class="legendText"><b>Limited Items</b><br/>
                        Owners of these discontinued items can re-sell them to other users at any price.
                     </div>
                     <img src="http://images.rbxcdn.com/d649b9c54a08dcfa76131d123e7d8acc.png" style="margin-left: -13px" />
                     <div class="legendText"><b>Limited Unique Items</b><br/>
                        A limited supply originally sold by ROBLOX. Each unit is labeled with a serial number. Once sold out, owners can re-sell them to other users.
                     </div>
                  </div>
               </div>
            </div>
            <div class="right-content divider-left">
               <a  href="/upgrades/robux.aspx" class="btn-medium btn-primary">Buy Robux</a>        
               <h2>Featured Items on ROBLOX</h2>
               <div style="clear:both;"></div>
               <?php
			   // Return items from ItemsArr
			   foreach($ItemsArr as $Item) 
			   { 
			   $CreatorInfo = (object)(new UserAuthentication($Item->uid))->GetAllUserInfo();
			   ?>
			   <div class="CatalogItemOuter SmallOuter">
                  <div class="SmallCatalogItemView SmallView">
                     <div class="CatalogItemInner SmallInner">
                        <div class="roblox-item-image image-small" data-item-id="<?php echo $Item->id; ?>" data-image-size="small"></div>
                        <div id="textDisplay">
                           <div class="CatalogItemName notranslate"><a class="name notranslate" href="/<?php echo constructSeoPageUrl($Item->title, "item", ["id" => $Item->id]); ?>" title="<?php echo htmlspecialchars($Item->title); ?>"><?php echo htmlspecialchars($Item->title); ?></a></div>
                           <?php echo ($Item->robux > 0) ? '<div class="robux-price"><span class="robux notranslate">'.$Item->robux.'</span></div>' : ''; ?>
						   <?php echo ($Item->tickets > 0) ? '<div class="tickets-price"><span class="tickets notranslate">'.$Item->tickets.'</span></div>' : ''; ?>
						   <?php echo ($Item->robux == 0 && $Item->tickets == 0) ? '<div><span class="NotAPrice">Free</span></div>' : ''; ?>
                        </div>
                        <div class="CatalogHoverContent">
                           <div><span class="CatalogItemInfoLabel">Creator:</span> <span class="HoverInfo notranslate"><a href="/User.aspx?ID=<?php echo $Item->uid; ?>"><?php echo $CreatorInfo->username; ?></a></span></div>
                           <div><span class="CatalogItemInfoLabel">Updated:</span> <span class="HoverInfo"><?php echo time_elapsed_string('@' . $Item->item_updated); ?></span></div>
                        </div>
                     </div>
                  </div>
               </div>
			   <?php
			   }
			   if($ItemCount == 0)
			   { 
				?>
				<div style="float:left;padding-top:5px">
                    <span>No items found.</span>
				</div>
			   <?php
			   }
			   ?>
               <div style="clear:both;padding-top: 50px;text-align:center;font-weight: bold;">
                  <a href="#featured=all" class="assetTypeFilter" data-category="0">See all featured items</a>
               </div>
            </div>
            <div style="clear:both" style="padding-top:20px"></div>
         </div>
         <script type="text/javascript">
            Roblox.require('Pages.Catalog', function (catalog) {
                var pagestate = { "Category": 1, "CurrencyType": 0, "SortType": 0, "SortAggregation": 3, "SortCurrency": 0, "AssetTypes": null, "Gears": null, "Genres": null, "Keyword": null, "PageNumber": 1, "Creator": null, "PxMin": 0, "PxMax": 0 };
                catalog.init(pagestate, 1);
            });
         </script>
         <!--[if IE]>
         <script type="text/javascript">
            $(function () {
                $('.BigInner').live('mouseenter', function () {                
                    $(this).parents('.BigView').css('z-index', '6');
            $('.SmallView').css('z-index', '1');
                });
                $('.BigInner').live('mouseleave', function () {                
            $(this).parents('.BigView').css('z-index', '1');
            $('.SmallView').css('z-index', '6');
                });
            $('.SmallInner').live('mouseenter', function () {
            $('.SmallView').css('z-index', '1');
                    $(this).parents('.SmallCatalogItemView').css('z-index', '6');
                });
                $('.SmallInner').live('mouseleave', function () {
            $('.SmallView').css('z-index', '1');
                    $(this).parents('.SmallCatalogItemView').css('z-index', '1');
                });
            });
         </script>
         <![endif]-->
         <div style="clear:both"></div>
      </div>
   </div>
</div>
<?php
require_once($_SERVER["STATIC"]."/footer.php");
?>