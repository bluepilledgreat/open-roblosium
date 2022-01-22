<?php
require_once($_SERVER["STATIC"]."/settings.php");
require_once($_SERVER["STATIC"]."/package_compiler.php");
$_PS->HeaderAds = false;
AddCSS(CSS_DEFAULT_PACKAGE);
AddCSS(PackageCompiler::CompilePackage("page", ["/CSS/PartialViews/Navigation.css", "/CSS/Base/CSS/AdFormatClasses.css", "/CSS/Base/CSS/GamesNew.css"], null));
AddJS(JS_DEFAULT_PACKAGE);
AddJS(PackageCompiler::CompilePackage("page", ["/js/GamesNew.js"], null));
$_PS->ASPNetFormTagEnabled = false;
require_once($_SERVER["STATIC"]."/header.php");
?>
<div id="BodyWrapper">
            <div id="RepositionBody">
                <div id="Body" style="width:auto; min-width:970px;">
                    






<div id="ResponsiveWrapper">
    

    <div id="GamesPageRightColumn">
        <div id="GamesPageRightColumnSidebar" class="sidebar-no-ad">
            <div id="GamePageAdDiv1" class="ads-container">
<div style="width: 300px">
    <span id="3337303031383633" class="GPTAd rectangle" data-js-adtype="gptAd">
        <script type="text/javascript">
            googletag.cmd.push(function () {
                googletag.display("3337303031383633");
            });
        </script>
    </span>
    <a class="ad" title="Upgrade Now" href="#" target="_top">
            <img src="/UserAds/2.png" alt="Upgrade Now" height="250" width="300">
        </a>
<div class="ad-annotations " style="width: 300px">
        <span class="ad-identification">Advertisement</span>
            <a class="BadAdButton" href="/Ads/ReportAd.aspx" title="click to report an offensive ad">Report</a>
    </div>
</div>            </div>
                <div id="GamePageAdDiv2" class="ads-container">
<div style="width: 300px">
    <span id="3337303031383633" class="GPTAd rectangle" data-js-adtype="gptAd">
        <script type="text/javascript">
            googletag.cmd.push(function () {
                googletag.display("3337303031383633");
            });
        </script>
    </span>
    <a class="ad" title="Upgrade Now" href="#" target="_top">
            <img src="/UserAds/2.png" alt="Upgrade Now" height="250" width="300">
        </a>
<div class="ad-annotations " style="width: 300px">
        <span class="ad-identification">Advertisement</span>
            <a class="BadAdButton" href="/Ads/ReportAd.aspx" title="click to report an offensive ad">Report</a>
    </div>
</div>                </div>
        
            </div>
    </div>     
    
    <div id="GamesPageLeftColumn">


        <div id="GamesPageHeader">
            <h1><span class="games-filter-resetter">Games</span></h1>
        </div>

        
        <div id="FiltersAndSort">
            <div class="filter">
                <h3>Filter By: </h3>
                <select id="SortFilter" data-default="default">
                    <option data-hidetimefilter value="default">Default</option>
                    <option data-hidetimefilter value="0">Popular</option>
                    <option data-hidetimefilter value="8">Top Earning</option>
                    <option value="2">Top Favorite</option>
                    <option data-hidetimefilter data-hidegenrefilter value="3">Featured</option>
                    <option value="9">Top Paid</option>
                    <option   value="11">Top Rated</option> 
                    <option data-hidetimefilter value="PersonalServers">Personal Servers</option>
                </select>
            </div>

            <div class="filter">
                <h3>Time: </h3>
                <select id="TimeFilter" data-default="0">
                    <option value="0">Now</option>
                    <option value="1">Past Day</option>
                    <option value="2">Past Week</option>
                    <option value="4">All Time</option>
                </select>
            </div>

            <div class="filter">
                <h3>Genre: </h3>
                <select id="GenreFilter" data-default="1">
                        <option value="1">All</option>
                        <option value="13">Adventure</option>
                        <option value="19">Building</option>
                        <option value="15">Comedy</option>
                        <option value="10">Fighting</option>
                        <option value="20">FPS</option>
                        <option value="11">Horror</option>
                        <option value="8">Medieval</option>
                        <option value="17">Military</option>
                        <option value="12">Naval</option>
                        <option value="21">RPG</option>
                        <option value="9">Sci-Fi</option>
                        <option value="14">Sports</option>
                        <option value="7">Town and City</option>
                        <option value="16">Western</option>
                </select>
            </div>
            
            <div id="GamesPageSearch">
                <input id="searchbox" class="translate" type="text" name="search" style="color:#888;height:20px;" onKeyPress="if (event.keyCode == 13) { return Roblox.GamesDisplayShared.search(); }" />
                <div class="SearchIconButton" onclick="Roblox.GamesDisplayShared.search()"></div>
            </div>

        </div>

        <div id="GamesListsContainer">





<div class="games-list-container hidden" id="GamesListContainer11"
    data-sortfilter="11"
    data-gamefilter="1"
    data-minbclevel="0">
    <div class="games-list-header games-filter-changer">
	    <h2>Top Rated</h2>
    </div>
    <div class="show-in-multiview-mode-only">
        <div class="see-all-button games-filter-changer btn-medium btn-neutral">
            See All
        </div>
    </div>

    <div class="games-list">
        <div class="show-in-multiview-mode-only">
            <div class="horizontally-scrollable">
            </div>

            <div class="scroller prev hidden">
                <div class="arrow">
                    <img src="http://images.rbxcdn.com/bf9c0660cdeb6283b71aa9237716519e.png" />
                </div>
            </div>
            <div class="scroller next">
                <div class="arrow">
                    <img src="http://images.rbxcdn.com/ab6e44a9d9ebfde2244da961275acd06.png" />
                </div>
            </div>
        </div>
    </div>
</div>





<div class="games-list-container hidden" id="GamesListContainerBC"
    data-sortfilter="0"
    data-gamefilter="1"
    data-minbclevel="1">
    <div class="games-list-header games-filter-changer">
	    <h2>Builders Club</h2>
    </div>
    <div class="show-in-multiview-mode-only">
        <div class="see-all-button games-filter-changer btn-medium btn-neutral">
            See All
        </div>
    </div>

    <div class="games-list">
        <div class="show-in-multiview-mode-only">
            <div class="horizontally-scrollable">
            </div>

            <div class="scroller prev hidden">
                <div class="arrow">
                    <img src="http://images.rbxcdn.com/bf9c0660cdeb6283b71aa9237716519e.png" />
                </div>
            </div>
            <div class="scroller next">
                <div class="arrow">
                    <img src="http://images.rbxcdn.com/ab6e44a9d9ebfde2244da961275acd06.png" />
                </div>
            </div>
        </div>
    </div>
</div>





<div class="games-list-container hidden" id="GamesListContainer8"
    data-sortfilter="8"
    data-gamefilter="1"
    data-minbclevel="0">
    <div class="games-list-header games-filter-changer">
	    <h2>Top Earning</h2>
    </div>
    <div class="show-in-multiview-mode-only">
        <div class="see-all-button games-filter-changer btn-medium btn-neutral">
            See All
        </div>
    </div>

    <div class="games-list">
        <div class="show-in-multiview-mode-only">
            <div class="horizontally-scrollable">
            </div>

            <div class="scroller prev hidden">
                <div class="arrow">
                    <img src="http://images.rbxcdn.com/bf9c0660cdeb6283b71aa9237716519e.png" />
                </div>
            </div>
            <div class="scroller next">
                <div class="arrow">
                    <img src="http://images.rbxcdn.com/ab6e44a9d9ebfde2244da961275acd06.png" />
                </div>
            </div>
        </div>
    </div>
</div>





<div class="games-list-container hidden" id="GamesListContainer9"
    data-sortfilter="9"
    data-gamefilter="1"
    data-minbclevel="0">
    <div class="games-list-header games-filter-changer">
	    <h2>Top Paid</h2>
    </div>
    <div class="show-in-multiview-mode-only">
        <div class="see-all-button games-filter-changer btn-medium btn-neutral">
            See All
        </div>
    </div>

    <div class="games-list">
        <div class="show-in-multiview-mode-only">
            <div class="horizontally-scrollable">
            </div>

            <div class="scroller prev hidden">
                <div class="arrow">
                    <img src="http://images.rbxcdn.com/bf9c0660cdeb6283b71aa9237716519e.png" />
                </div>
            </div>
            <div class="scroller next">
                <div class="arrow">
                    <img src="http://images.rbxcdn.com/ab6e44a9d9ebfde2244da961275acd06.png" />
                </div>
            </div>
        </div>
    </div>
</div>





<div class="games-list-container hidden" id="GamesListContainer0"
    data-sortfilter="0"
    data-gamefilter="1"
    data-minbclevel="0">
    <div class="games-list-header games-filter-changer">
	    <h2>Popular</h2>
    </div>
    <div class="show-in-multiview-mode-only">
        <div class="see-all-button games-filter-changer btn-medium btn-neutral">
            See All
        </div>
    </div>

    <div class="games-list">
        <div class="show-in-multiview-mode-only">
            <div class="horizontally-scrollable">
            </div>

            <div class="scroller prev hidden">
                <div class="arrow">
                    <img src="http://images.rbxcdn.com/bf9c0660cdeb6283b71aa9237716519e.png" />
                </div>
            </div>
            <div class="scroller next">
                <div class="arrow">
                    <img src="http://images.rbxcdn.com/ab6e44a9d9ebfde2244da961275acd06.png" />
                </div>
            </div>
        </div>
    </div>
</div>





<div class="games-list-container hidden" id="GamesListContainer2"
    data-sortfilter="2"
    data-gamefilter="1"
    data-minbclevel="0">
    <div class="games-list-header games-filter-changer">
	    <h2>Top Favorite</h2>
    </div>
    <div class="show-in-multiview-mode-only">
        <div class="see-all-button games-filter-changer btn-medium btn-neutral">
            See All
        </div>
    </div>

    <div class="games-list">
        <div class="show-in-multiview-mode-only">
            <div class="horizontally-scrollable">
            </div>

            <div class="scroller prev hidden">
                <div class="arrow">
                    <img src="http://images.rbxcdn.com/bf9c0660cdeb6283b71aa9237716519e.png" />
                </div>
            </div>
            <div class="scroller next">
                <div class="arrow">
                    <img src="http://images.rbxcdn.com/ab6e44a9d9ebfde2244da961275acd06.png" />
                </div>
            </div>
        </div>
    </div>
</div>





<div class="games-list-container hidden" id="GamesListContainer3"
    data-sortfilter="3"
    data-gamefilter="1"
    data-minbclevel="0">
    <div class="games-list-header games-filter-changer">
	    <h2>Featured</h2>
    </div>
    <div class="show-in-multiview-mode-only">
        <div class="see-all-button games-filter-changer btn-medium btn-neutral">
            See All
        </div>
    </div>

    <div class="games-list">
        <div class="show-in-multiview-mode-only">
            <div class="horizontally-scrollable">
            </div>

            <div class="scroller prev hidden">
                <div class="arrow">
                    <img src="http://images.rbxcdn.com/bf9c0660cdeb6283b71aa9237716519e.png" />
                </div>
            </div>
            <div class="scroller next">
                <div class="arrow">
                    <img src="http://images.rbxcdn.com/ab6e44a9d9ebfde2244da961275acd06.png" />
                </div>
            </div>
        </div>
    </div>
</div>





<div class="games-list-container hidden" id="GamesListContainerPersonalServers"
    data-sortfilter="0"
    data-gamefilter="2"
    data-minbclevel="0">
    <div class="games-list-header games-filter-changer">
	    <h2>Personal Servers</h2>
    </div>
    <div class="show-in-multiview-mode-only">
        <div class="see-all-button games-filter-changer btn-medium btn-neutral">
            See All
        </div>
    </div>

    <div class="games-list">
        <div class="show-in-multiview-mode-only">
            <div class="horizontally-scrollable">
            </div>

            <div class="scroller prev hidden">
                <div class="arrow">
                    <img src="http://images.rbxcdn.com/bf9c0660cdeb6283b71aa9237716519e.png" />
                </div>
            </div>
            <div class="scroller next">
                <div class="arrow">
                    <img src="http://images.rbxcdn.com/ab6e44a9d9ebfde2244da961275acd06.png" />
                </div>
            </div>
        </div>
    </div>
</div>

            <div id="DivToHideOverflowFromLastGamesList">
            </div>

        </div>
    </div>
</div>

<script type="text/javascript">
    Roblox.SearchBox = {};
    Roblox.SearchBox.Resources = {
        //<sl:translate>
        search: "Search"
        //</sl:translate>
    };
    Roblox.GamesPageContainerBehavior.Resources = {
        //<sl:translate>
        pageTitle: "ROBLOX Games - Browse our selection of free online games"
        //</sl:translate>
    };
    
    var defaultGamesLists = "11,BC,8,9,0";
    Roblox.GamesPageContainerBehavior.FilterValueToGamesListsIdSuffixMapping = {"default": defaultGamesLists.split(',')};
    
    Roblox.GamesPageContainerBehavior.IsUserLoggedIn = false;
    Roblox.GamesPageContainerBehavior.adRefreshRateMilliSeconds = 3000;
</script>

                    <div style="clear:both"></div>
                </div>
            </div>
        </div></div>
<?php
require_once($_SERVER["STATIC"]."/footer.php");
?>