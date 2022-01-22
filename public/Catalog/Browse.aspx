<?php
require_once($_SERVER["STATIC"]."/settings.php");
require_once($_SERVER["STATIC"]."/authentication.php");
require_once($_SERVER["STATIC"]."/package_compiler.php");
require_once($_SERVER["STATIC"]."/utilities.php");
AddCSS(CSS_DEFAULT_PACKAGE);
AddCSS(PackageCompiler::CompilePackage("page", ["/CSS/PartialViews/Navigation.css", "/CSS/Base/CSS/Ads.css", "/CSS/Pages/Catalog.css"], null));
AddJS(JS_DEFAULT_PACKAGE);
AddJS(PackageCompiler::CompilePackage("page", ["/js/GenericConfirmation.js", "/js/jquery.simplemodal-1.3.5.js", "/js/GenericModal.js"], ["/js/GPTAdScript.js"]));

// PRESET VARS
$ResultsPerPage = 24;
$PageNumber = $_GET["PageNumber"] ?? 1;
$Category = $_GET["Category"] ?? 1;

// ERROR IF INVALID CATEGORY
if(!$_S->CatalogCategories[$Category])
{
	die(header("Location: /RobloxDefaultErrorPage.aspx?code=500"));
}

// STATUS LABEL
$StatusLabel = '<a href="#breadcrumbs=category" class="breadCrumbFilter bolded selected" data-filter="category">'.$_S->CatalogCategories[$Category]["name"].'</a>';

// FILTER SETUP
// 1. REGEX FOR GETTING MULTIPLE GENRES
$QueryString = preg_replace("/(?<=^|&)(\w+)(?==)/", "$1[]", $_SERVER["QUERY_STRING"]);
parse_str($QueryString, $QueryString);

// 2. IS GENRES SET
if(isset($QueryString["Genres"])) 
{
	$i = 0;
	foreach($QueryString["Genres"] as $GenreKey) 
	{
		if($i > 1)
			$GenreLabel = "Genres: ". ($i + 1) . " selected";
		else if($i < 3 && $i > 0)
			$GenreLabel = $GenreLabel . " / ". $_S->Genres[$GenreKey]["name"];
		else
			$GenreLabel = $_S->Genres[$GenreKey]["name"];
		$i++;
	}
	@$GenreQuery = " AND (genre LIKE \"%".implode("%\" AND genre LIKE \"%", $QueryString["Genres"]) . "%\")";
	$StatusLabel = '<a href="#breadcrumbs=category" class="breadCrumbFilter bolded" data-filter="category">'. $_S->CatalogCategories[$Category]["name"] . '</a> » ' . '<a href="#breadcrumbs=genres" class="breadCrumbFilter selected" data-filter="genres">' . $GenreLabel . "</a>";
}

// 3. IS SEARCH?
if(isset($_GET["Keyword"]) && $_GET["Keyword"] !== "")
{
	$SearchQuery = " AND title LIKE \"%".htmlspecialchars($_GET["Keyword"])."%\"";
	$StatusLabel = '<a href="#breadcrumbs=category" class="breadCrumbFilter bolded" data-filter="category">'. $_S->CatalogCategories[$Category]["name"] . '</a> » ' . '<a href="#breadcrumbs=keyword" class="breadCrumbFilter selected" data-filter="genres">' . htmlspecialchars($_GET["Keyword"]) . "</a>";
}

// GET TOTAL ITEM COUNT
$stmt = $conn->prepare("SELECT * FROM assets WHERE (assettype = ".implode(" OR assettype=", $_S->CatalogCategories[$Category]["subcategories"]).")".@@$GenreQuery.@@$SearchQuery);
$stmt->execute();
$TotalItems = $stmt->rowCount();

// PAGINATION
$NumOfPages = (ceil($TotalItems/$ResultsPerPage) == 0) ? 1 : ceil($TotalItems/$ResultsPerPage);

// GET ITEMS FOR CATALOG + COUNT
if(!isset($_GET["Subcategory"])) 
{
	$stmt = $conn->prepare("SELECT * FROM assets WHERE (assettype = ".implode(" OR assettype=", $_S->CatalogCategories[$Category]["subcategories"]).")".@$GenreQuery.@$SearchQuery." ORDER BY id DESC LIMIT :t1, :t2");
}
else
{
	$stmt = $conn->prepare("SELECT * FROM assets WHERE assettype = :t0 ORDER BY id DESC LIMIT :t1, :t2");
	$stmt->BindValue(":t0", $_GET["Subcategory"], PDO::PARAM_INT);
}

// PDO PARAMS
$stmt->BindValue(":t1", ($PageNumber - 1), PDO::PARAM_INT);
$stmt->BindParam(":t2", $ResultsPerPage, PDO::PARAM_INT);
$stmt->execute();

// return data
$ItemsArr = $stmt->fetchAll(PDO::FETCH_OBJ);
$ItemCount = $stmt->rowCount();

$_PS->Title = "Avatar Items, Virtual Avatars, Virtual Goods";
require_once($_SERVER["STATIC"]."/header.php");
?>
<div id="BodyWrapper">
   <div id="RepositionBody">
      <div id="Body" style='width:970px;'>
         <div id="catalog" data-empty-search-enabled="true" style="font-size: 12px;">
            <div class="header" style="height:60px;">
               <div style="float:left;">
                  <h1><a href="/catalog/" id="CatalogLink">Catalog</a></h1>
               </div>
               <div class="CatalogSearchBar">
                  <input id="keywordTextbox" name="name" type="text" class="translate text-box text-box-small" value="<?php echo (isset($_GET["Keyword"])) ? htmlspecialchars($_GET["Keyword"]) : ""; ?>" />
                  <div style="height:23px;border:1px solid #a7a7a7;padding:2px 2px 0px 2px;margin-right:6px;float:left;position:relative">
                     <!--[if IE7]>
                     <div style="height:19px;width:131px;position:absolute;top:2px;left:2px;border:1px solid white"></div>
                     <div style="height:19px;width:15px;position:absolute;top:2px;right:2px;border:1px solid #aaa"></div>
                     <![endif]-->
                     <select id="categoriesForKeyword" style="">
                        <?php foreach($_S->CatalogCategories as $CategoryItem)
						{ ?>
						<option value="<?php echo $CategoryItem["id"]; ?>" <?php echo ($CategoryItem["id"] == $Category) ? "selected=selected" : ""; ?>><?php echo $CategoryItem["name"]; ?></option>
						<?php } ?>
                     </select>
                  </div>
                  <a id="submitSearchButton" href="#" class="btn-control btn-control-large top-level">Search</a>
               </div>
            </div>
            <div class="left-nav-menu divider-right">
               <a id="BrowseCategoriesButton" class="browseDropdownButton  roblox-hierarchicaldropdownbutton"></a>
               <div id="dropdown" class="browsedropdown roblox-hierarchicaldropdown">
                  <ul id="dropdownUl">
                     <li class="subcategories" data-delay="never">
                        <a href="#category=featured" class="assetTypeFilter" data-category="0">Featured</a>
                        <ul class="slideOut" style="top:-1px;">
                           <li class="slideHeader"><span>Featured Types</span></li>
                           <li><a href="#category=featured" class="assetTypeFilter" data-types="0" data-category="0">All Featured Items</a></li>
                           <li><a href="#category=featured" class="assetTypeFilter" data-types="8" data-category="0">Featured Hats</a></li>
                           <li><a href="#category=featured" class="assetTypeFilter" data-types="5" data-category="0">Featured Gear</a></li>
                           <li><a href="#category=featured" class="assetTypeFilter" data-types="9" data-category="0">Featured Faces</a></li>
                           <li><a href="#category=featured" class="assetTypeFilter" data-types="10" data-category="0">Featured Packages</a></li>
                        </ul>
                     </li>
                     <li class="subcategories">
                        <a href="#category=collectibles" class="assetTypeFilter collectiblesLink" data-category="2">Collectibles</a>
                        <ul class="slideOut" style="top:-32px;">
                           <li class="slideHeader"><span>Collectible Types</span></li>
                           <li><a href="#category=collectibles" class="assetTypeFilter" data-types="2" data-category="2">All Collectibles</a></li>
                           <li><a href="#category=collectibles" class="assetTypeFilter" data-types="9" data-category="2">Collectible Faces</a></li>
                           <li><a href="#category=collectibles" class="assetTypeFilter" data-types="8" data-category="2">Collectible Hats</a></li>
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
                           <li><a href="#" class="assetTypeFilter" data-types="8" data-category="3">Hats</a></li>
                           <li><a href="#" class="assetTypeFilter" data-types="11" data-category="3">Shirts</a></li>
                           <li><a href="#" class="assetTypeFilter" data-types="12" data-category="3">T-Shirts</a></li>
                           <li><a href="#" class="assetTypeFilter" data-types="13" data-category="3">Pants</a></li>
                           <li><a href="#" class="assetTypeFilter" data-types="10" data-category="3">Packages</a></li>
                        </ul>
                     </li>
                     <li class="subcategories">
                        <a href="#category=bodyparts" class="assetTypeFilter" data-category="4">Body Parts</a>
                        <ul class="slideOut" style="top:-128px;">
                           <li class="slideHeader"><span>Body Part Types</span></li>
                           <li><a href="#category=bodyparts" class="assetTypeFilter" data-types="4" data-category="4">All Body Parts</a></li>
                           <li><a href="#category=bodyparts" class="assetTypeFilter" data-types="14" data-category="4">Heads</a></li>
                           <li><a href="#category=bodyparts" class="assetTypeFilter" data-types="9" data-category="4">Faces</a></li>
                           <li><a href="#category=bodyparts" class="assetTypeFilter" data-types="10" data-category="4">Packages</a></li>
                        </ul>
                     </li>
                     <li class="subcategories">
                        <a href="#category=gear" class="assetTypeFilter" data-category="5">Gear</a>
                        <ul class="slideOut" style="top:-159px;" style="border-right:0px;">
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
                     <li><a href="#category=decals" class="assetTypeFilter" data-category="7">Decals</a></li>
                     <li><a href="#category=audio" class="assetTypeFilter" data-category="8">Audio</a></li>
                  </ul>
               </div>
               <div style="padding-top:20px;">
                  <h2>Filters</h2>
               </div>
               <div style="margin-left:5px">
                  <div class="filter-title">Category</div>
                  <ul>
					<?php foreach($_S->CatalogCategories as $CategoryItem)
					{ ?>
					<li><a href="#category=<?php echo $CategoryItem["name"]; ?>" class="assetTypeFilter<?php echo ($CategoryItem["id"] == $Category) ? " selected" : ""; ?>" data-keepfilters="true" data-category="<?php echo $CategoryItem["id"]; ?>"><?php echo $CategoryItem["name"]; ?></a></li>
					<?php } ?>
                  </ul>
                  <div class="filter-title">Genre</div>
                  <ul id="genresUl">
                     <li><a href="#" id="AllGenresLink" onclick="Roblox.Pages.Catalog.ClearGenres();"<?php echo (!isset($Genre)) ? ' class="selected"' : ''; ?>>All Genres</a></li>
                     <?php foreach($_S->Genres as $GenreItem)
					 { 
					 if($GenreItem["hidden"] == false) 
					 {
					 ?>
					 <li>
                        <input type="checkbox" id="genre-<?php echo $GenreItem["id"]; ?>" class="genreFilter" data-genreId="<?php echo $GenreItem["id"]; ?>"<?php if(isset($QueryString["Genres"])) echo (in_array($GenreItem["id"], $QueryString["Genres"])) ? " checked" : ""; ?>>
                        <label for="genre-<?php echo $GenreItem["id"]; ?>"><?php echo $GenreItem["name"]; ?></label>
                     </li>
					 <?php
					 }
					 } ?>
                  </ul>
                  <div class="filter-title">Creators</div>
                  <ul>
                     <li><a href="#creator=0" class="creatorFilter selected" data-creatorId="0">All Creators</a></li>
                     <li><a href="#creator=1" class="creatorFilter" data-creatorId="1">ROBLOX</a></li>
                     <li><input id="creatorTextbox" name="name" type="text" value="Name" class="Watermark translate text-box text-box-small" /> <a href="#" id="submitCreatorButton" class="btn-control btn-control-small">Go</a></li>
                  </ul>
                  <div class="filter-title">Currency / Price</div>
                  <ul class="separatorForLegend" style="border:0">
                     <li><a href="#price=0" class="priceFilter selected" data-currencytype="0">All Currency</a></li>
                     <li><a href="#price=1" class="priceFilter" data-currencytype="1">Robux</a></li>
                     <li><a href="#price=2" class="priceFilter" data-currencytype="2">Tickets</a></li>
                     <li><a href="#price=5" class="priceFilter" data-currencytype="5">Free</a></li>
                     <li class="NotForSale">
                        <input type="checkbox" id="includeNotForSaleCheckbox" value="true" />
                        <label for="includeNotForSaleCheckbox">Show unavailable items</label>
                     </li>
                  </ul>
               </div>
               <div id="legend" class="divider-top">
                  <div class="header" id="legendheader">
                     <h3>Legend</h3>
                  </div>
                  <div id="legendcontent" style="overflow: hidden;display:none">
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
               <?php echo $StatusLabel; ?>
               <div id="secondRow">
			   <div style="float:left;padding-top:5px">
			   <?php if($ItemCount == 0)
			   {
				?>
				<span>No items found.</span>
				<?php
			   }
			   else
			   {
				?>
				<span>Showing <span class="notranslate"><?php echo $PageNumber; ?></span> - <span class="notranslate"><?php echo ($ItemCount < $ResultsPerPage) ? ($ResultsPerPage - ($ResultsPerPage - $ItemCount)) : $ResultsPerPage; ?></span> of <span class="notranslate"><?php echo $TotalItems; ?></span> results</span>
				<?php
			   }
			   ?>
			   </div>
                  <div id="SortOptions">
                     Sort by: 
                     <select id="SortMain">
                        <option value="0" selected=selected >Relevance</option>
                        <option value="1">Most Favorited</option>
                        <option value="2">Bestselling</option>
                        <option value="3">Recently updated</option>
                        <option value="5">Price (High to Low)</option>
                        <option value="4">Price (Low to High)</option>
                     </select>
                     <select id="SortAggregation" style=display:none >
                        <option value="3" selected=selected >All Time</option>
                        <option value="1">Past week</option>
                        <option value="0">Past day</option>
                     </select>
                     <select id="SortCurrency" style=display:none >
                        <option value="0" selected=selected >in Robux</option>
                        <option value="1">in Tickets</option>
                     </select>
                  </div>
                  <div style="clear:both"></div>
               </div>
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
			   ?>
               <div class="PagingContainerDivTop">
                  <span class="pager previous" id="pagingprevious"></span>
                  <span class="page text">
                  Page <input class="Paging_Input translate" type="text" value="<?php echo $PageNumber; ?>"/> of <?php echo $NumOfPages; ?>
                  <span class="paging_pagenums_container"></span>
                  </span>
                  <span class="pager next <?php echo ($NumOfPages == 1) ? "disabled" : ""; ?>" id="pagingnext"></span>
               </div>
            </div>
            <div style="clear:both;padding-top:20px"></div>
         </div>
         <div id="AddToGearInstructionsPanel" class="PurchaseModal">
            <div id="simplemodal-close" class="simplemodal-close">
               <a></a>
            </div>
            <div class="titleBar" style="text-align: center">
               Add Gear to Your Game
            </div>
            <div class="PurchaseModalBody">
               <div class="PurchaseModalMessage">
                  <div class="PromoteModalErrorMessage errorStatusBar"></div>
                  <div class="PurchaseModalMessageText">
                     <span>
                     <img src="/images/img-addgear-screenshot.jpg"/>
                     </span>
                     <br/>
                     To add gear to your game, find an item in the catalog and click the "Add to Game" button. The item will automatically be allowed in game, and you'll receive a commission on every copy sold from your game page. (You can only add gear that's for sale.)
                  </div>
               </div>
               <div class="PurchaseModalButtonContainer">
                  <div class="ImageButton btn-blue-ok-sharp simplemodal-close" ></div>
               </div>
               <div class="PurchaseModalFooter footnote"></div>
            </div>
         </div>
         <script type="text/javascript">
            Roblox.require('Pages.Catalog', function (catalog) {
                catalog.init({"Subcategory":null,"Category":0,"CurrencyType":0,"SortType":0,"SortAggregation":3,"SortCurrency":0,"Gears":null,"Genres":null,"Keyword":null,"PageNumber":<?php echo $PageNumber; ?>,"CreatorID":0,"PxMin":0,"PxMax":0,"IncludeNotForSale":false,"LegendExpanded":false,"ResultsPerPage":42}, <?php echo $NumOfPages; ?>);
                catalog.initDropdown();
            });
            
            $('.Paging_Input').val('1'); /* what?! party.js overwrites paging_input on any pageback */
            
            $(function () {
                if (window.location.search.indexOf('&showInstructions=true') > -1) {
                    var modalProperties = { escClose: true, opacity: 80, overlayCss: { backgroundColor: "#000"} };
                    $('#AddToGearInstructionsPanel').modal(modalProperties);
                }
            });
         </script>
         <!--[if IE]>
         <script type="text/javascript">
            $(function () {
                $('.CatalogItemInner').live('mouseenter', function () {
                    $(this).parents('.SmallCatalogItemView').css('z-index', '6');
                });
                $('.CatalogItemInner').live('mouseleave', function () {
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