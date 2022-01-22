<?php
// ROBLOSIUM 2013
require_once($_SERVER["STATIC"]."/settings.php");
require_once($_SERVER["STATIC"]."/package_compiler.php");
AddCSS(CSS_DEFAULT_PACKAGE);
AddCSS(PackageCompiler::CompilePackage("page", ["/CSS/Pages/Upgrades/BuyRobux.css", "/CSS/PartialViews/Navigation.css"], null));
AddJS(JS_DEFAULT_PACKAGE);
AddJS(PackageCompiler::CompilePackage("page", ["/js/GenericConfirmation.js"], null));
$_PS->UseJQueryUILib = true;
require_once($_SERVER["STATIC"]."/header.php");
?>
                <div id="BodyWrapper">
                    <div id="RepositionBody">
                        <div id="Body" style="width:970px">
                            <div style="width:100%;">
    <div style="margin-left:5px;">
        <h1 style="padding:0;">Buy ROBUX</h1>
        <div>
            <img width="48px" height="48px" alt="R$" src="https://s3.amazonaws.com/images.roblox.com/72019d3cb1b2c8e1660b03b7423124c7.png" style="float:left;" />
            <div class="rdar-text">
                Use ROBUX to buy virtual goods for your character - shirts, pants, hats, faces, and even heads!
            <br />
                You can also buy gear, like hammers, potions, jet boots, swords, and BLOXI Cola.
            </div>
            <div class="clear"></div>
        </div>
    </div>
    <div class="robux-products-container">
            <div class="bottom-40">
                <div class="robux-product-body">
                    <a  href="/Upgrades/PaymentMethods.aspx?ap=42" class="btn-small btn-primary robux-buy">Buy</a>
                    <div class="robux-membership">
                        Standard Member
                    </div>
                    <h3>
                        400 Robux $4.95
                    </h3>
                    <div class="divider-bottom"></div>
                    <div style="font-size: 11px;">
Builder&#39;s Club Members get 450 ROBUX for $4.95  <a href = "/Upgrades/BuildersClubMemberships.aspx" > Upgrade Now!</a>
                    </div>
                </div>
                <div class="robux-title">
                    400
                </div>
                <div class="clear"></div>
            </div>
            <div class="bottom-40">
                <div class="robux-product-body">
                    <a  href="/Upgrades/PaymentMethods.aspx?ap=45" class="btn-small btn-primary robux-buy">Buy</a>
                    <div class="robux-membership">
                        Standard Member
                    </div>
                    <h3>
                        800 Robux $9.95
                    </h3>
                    <div class="divider-bottom"></div>
                    <div style="font-size: 11px;">
Builder&#39;s Club Members get 1000 ROBUX for $9.95  <a href = "/Upgrades/BuildersClubMemberships.aspx" > Upgrade Now!</a>
                    </div>
                </div>
                <div class="robux-title">
                    800
                </div>
                <div class="clear"></div>
            </div>
            <div class="bottom-40">
                <div class="robux-product-body">
                    <a  href="/Upgrades/PaymentMethods.aspx?ap=10" class="btn-small btn-primary robux-buy">Buy</a>
                    <div class="robux-membership">
                        Standard Member
                    </div>
                    <h3>
                        2000 ROBUX $24.95
                    </h3>
                    <div class="divider-bottom"></div>
                    <div style="font-size: 11px;">
Builder&#39;s Club Members get 2750 ROBUX for $24.95  <a href = "/Upgrades/BuildersClubMemberships.aspx" > Upgrade Now!</a>
                    </div>
                </div>
                <div class="robux-title">
                    2000
                </div>
                <div class="clear"></div>
            </div>
            <div class="bottom-40">
                <div class="robux-product-body">
                    <a  href="/Upgrades/PaymentMethods.aspx?ap=46" class="btn-small btn-primary robux-buy">Buy</a>
                    <div class="robux-membership">
                        Standard Member
                    </div>
                    <h3>
                        4500 ROBUX $49.95
                    </h3>
                    <div class="divider-bottom"></div>
                    <div style="font-size: 11px;">
Builder&#39;s Club Members get 6000 ROBUX for $49.95  <a href = "/Upgrades/BuildersClubMemberships.aspx" > Upgrade Now!</a>
                    </div>
                </div>
                <div class="robux-title">
                    4500
                </div>
                <div class="clear"></div>
            </div>
            <div class="bottom-40">
                <div class="robux-product-body">
                    <a  href="/Upgrades/PaymentMethods.aspx?ap=19" class="btn-small btn-primary robux-buy">Buy</a>
                    <div class="robux-membership">
                        Standard Member
                    </div>
                    <h3>
                        10000 ROBUX $99.95
                    </h3>
                    <div class="divider-bottom"></div>
                    <div style="font-size: 11px;">
Builder&#39;s Club Members get 15000 ROBUX for $99.95  <a href = "/Upgrades/BuildersClubMemberships.aspx" > Upgrade Now!</a>
                    </div>
                </div>
                <div class="robux-title">
                    10000
                </div>
                <div class="clear"></div>
            </div>
            <div class="bottom-40">
                <div class="robux-product-body">
                    <a  href="/Upgrades/PaymentMethods.aspx?ap=21" class="btn-small btn-primary robux-buy">Buy</a>
                    <div class="robux-membership">
                        Standard Member
                    </div>
                    <h3>
                        22500 ROBUX $199.95
                    </h3>
                    <div class="divider-bottom"></div>
                    <div style="font-size: 11px;">
Builder&#39;s Club Members get 35000 ROBUX for $199.95  <a href = "/Upgrades/BuildersClubMemberships.aspx" > Upgrade Now!</a>
                    </div>
                </div>
                <div class="robux-title">
                    22500
                </div>
                <div class="clear"></div>
            </div>
        <div style="font-size: 10px;">
            Prices for Turbo and Outrageous Builder's Club are the same as for regular Builder's Club. All sales are final. Please see our <a href="/info/terms-of-service">Terms & Conditions</a> for more information.
        </div>
    </div>
</div>


                            <div style="clear:both"></div>
                        </div>
                    </div>
                </div>
<?php
require_once($_SERVER["STATIC"]."/footer.php");
?>