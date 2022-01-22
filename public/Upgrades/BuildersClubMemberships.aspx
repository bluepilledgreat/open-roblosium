<?php
// ROBLOSIUM 2013
require_once($_SERVER["STATIC"]."/settings.php");
require_once($_SERVER["STATIC"]."/package_compiler.php");
AddCSS(CSS_DEFAULT_PACKAGE);
AddCSS(PackageCompiler::CompilePackage("page", ["/CSS/Pages/Upgrades/BuildersClubProductsGrid.css", "/CSS/Pages/CashOut/CashOut.css", "/CSS/Pages/Upgrades/BuildersClubPanel.css", "/CSS/PartialViews/Navigation.css", "/CSS/Base/CSS/AdFormatClasses.css"], null));
AddJS(JS_DEFAULT_PACKAGE);
AddJS(PackageCompiler::CompilePackage("page", ["/js/Upgrades/BuildersClubProductsGrid.js", "/js/GenericModal.js", "/js/GenericConfirmation.js", "/js/jquery.simplemodal-1.3.5.js"], ["GPTAdScript.js"]));
$_PS->UseJQueryUILib = true;
require_once($_SERVER["STATIC"]."/header.php");
?>
        <div id="BodyWrapper">
            <div id="RepositionBody"><div id="Body" style='width:970px;'>
                
    		   
<div id="BCPageContainer">
	<div id="UserDataInfo" data-auth="false" data-active-bc="false"></div>
	<div class="header">
		<span><h1>Upgrade to ROBLOX Builders Club</h1></span>
	</div>
	<div class="left-column">
		<table cellspacing="0" border="0">
			<thead class="product-title">
				<tr>
					<td class="center-bold">
						<h2 class="product-space">Free</h2>
						<img src="https://s3.amazonaws.com/images.roblox.com/77add140640c3388e6c9603bc5983846.png" alt="bc" />
					</td>
					<td class="center-bold">
						<h2 class="product-space">Classic</h2>
						<img src="https://s3.amazonaws.com/images.roblox.com/ba707f47bb20a1f4804da461fb5d3c31.png" alt="bc" />
					</td>
					<td class="center-bold">
						<h2 class="product-space">Turbo</h2>
						<img src="https://s3.amazonaws.com/images.roblox.com/d7eb3ed186e351d99ce8c11503675721.png" alt="tbc" />
					</td>
					<td class="center-bold">
						<h2 class="product-space">Outrageous</h2>
						<img src="https://s3.amazonaws.com/images.roblox.com/ca1d0aef06c5fc06a2d8b23aea5e20d2.png" alt="obc" />
					</td>
				</tr>
			</thead>
			
	<tbody class="product-summary summary-big">
			<tr>
				<td class="divider-top">
					<span class="product-description">Daily ROBUX</span>
					<span class="nbc-product">No</span>
				</td>
				<td class="divider-top bc-product ">
					R$15
				</td>
				<td class="divider-top tbc-product 		emphasis
">
					R$35
				</td>
				<td class="divider-top obc-product 		emphasis
">
					R$60
				</td>
			</tr>
			<tr>
				<td class="divider-top">
					<span class="product-description">Active Places</span>
					<span class="nbc-product">1</span>
				</td>
				<td class="divider-top bc-product ">
					10
				</td>
				<td class="divider-top tbc-product 		emphasis
">
					25
				</td>
				<td class="divider-top obc-product 		emphasis
">
					100!
				</td>
			</tr>
			<tr>
				<td class="divider-top">
					<span class="product-description">Join Groups</span>
					<span class="nbc-product">5</span>
				</td>
				<td class="divider-top bc-product ">
					10
				</td>
				<td class="divider-top tbc-product ">
					20
				</td>
				<td class="divider-top obc-product ">
					100!
				</td>
			</tr>
			<tr>
				<td class="divider-top">
					<span class="product-description">Create Groups</span>
					<span class="nbc-product">No</span>
				</td>
				<td class="divider-top bc-product ">
					10
				</td>
				<td class="divider-top tbc-product ">
					20
				</td>
				<td class="divider-top obc-product ">
					100!
				</td>
			</tr>
			<tr>
				<td class="divider-top">
					<span class="product-description">Signing Bonus</span>
					<span class="nbc-product">No</span>
				</td>
				<td class="divider-top bc-product ">
					R$100
				</td>
				<td class="divider-top tbc-product ">
					R$100
				</td>
				<td class="divider-top obc-product ">
					R$100
				</td>
			</tr>
			<tr>
				<td class="divider-top">
					<span class="product-description">Paid Access</span>
					<span class="nbc-product">10%</span>
				</td>
				<td class="divider-top bc-product ">
					70%
				</td>
				<td class="divider-top tbc-product ">
					70%
				</td>
				<td class="divider-top obc-product ">
					70%
				</td>
			</tr>
	</tbody>

<tbody class="product-grid">
			<tr>
		<td class="product-cell divider-left">
				<div class="product-nbc divider-bottom"></div>
		</td>
		<td class="product-cell divider-left">
				<div class="		product-cell
">
						<div class="product-text">
		<h3>Monthly</h3>
	</div>

					<a  data-pid="1" data-rank="BC" data-duration="Monthly" class="btn-medium btn-primary product-button">$5.95</a>
				</div>
		</td>
		<td class="product-cell divider-left">
				<div class="		product-cell
">
						<div class="product-text">
		<h3>Monthly</h3>
	</div>

					<a  data-pid="34" data-rank="TBC" data-duration="Monthly" class="btn-medium btn-primary product-button">$11.95</a>
				</div>
		</td>
		<td class="product-cell divider-left">
				<div class="		product-cell
">
						<div class="product-text">
		<h3>Monthly</h3>
	</div>

					<a  data-pid="28" data-rank="OBC" data-duration="Monthly" class="btn-medium btn-primary product-button">$19.95</a>
				</div>
		</td>
			</tr>
			<tr>
		<td class="product-cell divider-left">
				<div class="product-nbc divider-bottom"></div>
		</td>
		<td class="product-cell divider-left">
				<div class="		product-cell
">
						<div class="product-text">
		<h3>6 Months</h3>
	</div>

					<a  data-pid="6" data-rank="BC" data-duration="6 Months" class="btn-medium btn-primary product-button">$29.95</a>
				</div>
		</td>
		<td class="product-cell divider-left">
				<div class="		product-cell
">
						<div class="product-text">
		<h3>6 Months</h3>
	</div>

					<a  data-pid="36" data-rank="TBC" data-duration="6 Months" class="btn-medium btn-primary product-button">$44.95</a>
				</div>
		</td>
		<td class="product-cell divider-left">
				<div class="		product-cell
">
						<div class="product-text">
		<h3>6 Months</h3>
	</div>

					<a  data-pid="30" data-rank="OBC" data-duration="6 Months" class="btn-medium btn-primary product-button">$69.95</a>
				</div>
		</td>
			</tr>
			<tr>
		<td class="product-cell divider-left">
				<div class="product-nbc divider-bottom"></div>
		</td>
		<td class="product-cell divider-left">
				<div class="		product-cell
">
						<div class="product-text">
		<h3>12 Months</h3>
	</div>

					<a  data-pid="8" data-rank="BC" data-duration="12 Months" class="btn-medium btn-primary product-button">$57.95</a>
				</div>
		</td>
		<td class="product-cell divider-left">
				<div class="		product-cell
">
						<div class="product-text">
		<h3>12 Months</h3>
	</div>

					<a  data-pid="37" data-rank="TBC" data-duration="12 Months" class="btn-medium btn-primary product-button">$85.95</a>
				</div>
		</td>
		<td class="product-cell divider-left">
				<div class="		product-cell product-popular
">
						<div class="product-text">
		<div><h3>12 Months</h3></div>
		<h4 style="position:relative; top: -2px;">Most Popular</h4>
	</div>

					<a  data-pid="31" data-rank="OBC" data-duration="12 Months" class="btn-medium btn-primary product-button">$129.95</a>
				</div>
		</td>
			</tr>
			<tr>
		<td class="product-cell divider-left">
				<div class="product-nbc divider-bottom"></div>
		</td>
		<td class="product-cell divider-left">
				<div class="		product-cell
">
						<div class="product-text">
		<h3>Lifetime</h3>
	</div>

					<a  data-pid="9" data-rank="BC" data-duration="Lifetime" class="btn-medium btn-primary product-button">$199.95</a>
				</div>
		</td>
		<td class="product-cell divider-left">
				<div class="		product-cell
">
						<div class="product-text">
		<h3>Lifetime</h3>
	</div>

					<a  data-pid="38" data-rank="TBC" data-duration="Lifetime" class="btn-medium btn-primary product-button">$299.95</a>
				</div>
		</td>
		<td class="product-cell divider-left">
				<div class="		product-cell
">
						<div class="product-text">
		<h3>Lifetime</h3>
	</div>

					<a  data-pid="53" data-rank="OBC" data-duration="Lifetime" class="btn-medium btn-primary product-button">$349.95</a>
				</div>
		</td>
			</tr>
</tbody>
	<tbody class="product-summary summary-small">
			<tr>
				<td class="divider-top">
					<span class="product-description">Ad Free</span>
					<span class="nbc-product">No</span>
				</td>
				<td class="divider-top bc-product 		emphasis
">
					✔
				</td>
				<td class="divider-top tbc-product 		emphasis
">
					✔
				</td>
				<td class="divider-top obc-product 		emphasis
">
					✔
				</td>
			</tr>
			<tr>
				<td class="divider-top">
					<span class="product-description">Sell Stuff</span>
					<span class="nbc-product">No</span>
				</td>
				<td class="divider-top bc-product 		emphasis
">
					✔
				</td>
				<td class="divider-top tbc-product 		emphasis
">
					✔
				</td>
				<td class="divider-top obc-product 		emphasis
">
					✔
				</td>
			</tr>
			<tr>
				<td class="divider-top">
					<span class="product-description">Virtual Hat</span>
					<span class="nbc-product">No</span>
				</td>
				<td class="divider-top bc-product 		emphasis
">
					✔
				</td>
				<td class="divider-top tbc-product 		emphasis
">
					✔
				</td>
				<td class="divider-top obc-product 		emphasis
">
					✔
				</td>
			</tr>
			<tr>
				<td class="divider-top">
					<span class="product-description">Bonus Gear</span>
					<span class="nbc-product">No</span>
				</td>
				<td class="divider-top bc-product 		emphasis
">
					✔
				</td>
				<td class="divider-top tbc-product 		emphasis
">
					✔
				</td>
				<td class="divider-top obc-product 		emphasis
">
					✔
				</td>
			</tr>
			<tr>
				<td class="divider-top">
					<span class="product-description">Create Badges</span>
					<span class="nbc-product">No</span>
				</td>
				<td class="divider-top bc-product 		emphasis
">
					✔
				</td>
				<td class="divider-top tbc-product 		emphasis
">
					✔
				</td>
				<td class="divider-top obc-product 		emphasis
">
					✔
				</td>
			</tr>
			<tr>
				<td class="divider-top">
					<span class="product-description">BC Beta Features</span>
					<span class="nbc-product">No</span>
				</td>
				<td class="divider-top bc-product 		emphasis
">
					✔
				</td>
				<td class="divider-top tbc-product 		emphasis
">
					✔
				</td>
				<td class="divider-top obc-product 		emphasis
">
					✔
				</td>
			</tr>
			<tr>
				<td class="divider-top">
					<span class="product-description">Personal Servers</span>
					<span class="nbc-product">No</span>
				</td>
				<td class="divider-top bc-product 		emphasis
">
					✔
				</td>
				<td class="divider-top tbc-product 		emphasis
">
					✔
				</td>
				<td class="divider-top obc-product 		emphasis
">
					✔
				</td>
			</tr>
			<tr>
				<td class="divider-top">
					<span class="product-description">Trade System</span>
					<span class="nbc-product">No</span>
				</td>
				<td class="divider-top bc-product 		emphasis
">
					✔
				</td>
				<td class="divider-top tbc-product 		emphasis
">
					✔
				</td>
				<td class="divider-top obc-product 		emphasis
">
					✔
				</td>
			</tr>
			<tr>
				<td class="divider-top">
					<span class="product-description">Mega Places</span>
					<span class="nbc-product">No</span>
				</td>
				<td class="divider-top bc-product 		emphasis
">
					✔
				</td>
				<td class="divider-top tbc-product 		emphasis
">
					✔
				</td>
				<td class="divider-top obc-product 		emphasis
">
					✔
				</td>
			</tr>
	</tbody>











		</table>
	</div>
	<div class="right-column">
<div id="RightColumnWrapper">
    <div class="cell cellDivider">
        For billing and payment questions: <span class="SL_swap" id="CsEmailLink"><a href="mailto:info@roblox.com">info@roblox.com</a></span>
    </div>
    <div class="">

<div class="GenericModal modalPopup unifiedModal smallModal" style="display:none;">
        <div class="Title"></div>
        <div class="GenericModalBody">
            <div>
                <div class="ImageContainer">
                    <img class="GenericModalImage" alt="generic image" />
                </div>
                <div class="Message"></div>
            </div>
            <div class="clear"></div>
            <div id="GenericModalButtonContainer" class="GenericModalButtonContainer">
                <a class="ImageButton btn-neutral btn-large roblox-ok">OK<span class="btn-text">OK</span></a>
            </div>  
        </div>
    </div>    </div>
    <div class="cell cellDivider">
        <h3>Buy ROBUX</h3>
        <p>Use ROBUX to buy virtual goods for your character - shirts, pants, hats, faces,
            and even heads! You can also buy gear, like hammers, potions, jet boots, swords,
            and BLOXI Cola.</p>
        <p>
            <a  href="/upgrades/robux.aspx" class="btn-medium btn-primary">Buy ROBUX</a>
        </p>
        <h3>Buy ROBUX with</h3><br /><br />
        <a href="/micropay"><img src="https://s3.amazonaws.com/images.roblox.com/d3ac0f6384162cef74cfd79f7692612e.png" alt="boku" /></a><br /><br />
        <a href="/rixtypin"><img src="https://s3.amazonaws.com/images.roblox.com/93e037df4111777c7463d97eadebc59e.png" alt="rixty" /></a><br /><br />
        <a href="http://itunes.apple.com/us/app/roblox-mobile/id431946152?mt=8"><img src="https://s3.amazonaws.com/images.roblox.com/70deff83e869746b0bbc41a86f420844.png" alt="itunes" /></a>
    </div>
    <div class="cell cellDivider">
        <h3>Gift Cards</h3><br />
        <a href="/gamecard" class="giftCardImage"><img src="https://s3.amazonaws.com/images.roblox.com/bf9f4b65f937ad01f07ae6714eaba723.png" alt="giftcard" /></a>
        <div>
                <div><a href="/gamecard" class="redeemLink">Redeem card</a></div>
            <div style="clear: both"></div>
        </div>
    </div>
    <div class="cell cellDivider">
        <h3>Game Cards</h3>
        <a href="/gamecards"><img alt="ROBLOX Gamecards" src="https://s3.amazonaws.com/images.roblox.com/863c65342816d665de28411cf47cde42.png" /></a>
        <div class="gameCardControls">
            <div class="gameCardButton">
                <a  href="/gamecards" class="btn-small btn-primary">Where to Buy</a>
            </div>
            <div><a href="/gamecard" class="redeemLink">Redeem Card</a></div>
            <div style="clear: both"></div>
        </div>
    </div>
    <div class="cell">
        <h3>Need Builders Club Now?</h3>
        <p>Fill out our fun, interactive form, and print it out or send it your friends and family!</p>
        <a  href="/my/share/pleaseupgrademe.aspx" class="btn-small btn-primary">Please Upgrade Me!</a>
        <p>Warning: "Please Upgrade Me!" may be very convincing.</p>
        <h3>Parents</h3>
        <p>Learn more about builders club and how we help <a href="/parents/buildersclub.aspx">keep kids safe.</a></p>
        <h3>Other Accounts</h3>
        <p>To cancel the memberships for one or more other accounts, please contact customer service at info@Roblox.com. Please Note: You can cancel monthly recurring memberships any time before the renewal date. 6 and 12 month memberships cannot be canceled. Memberships are not refundable.</p>
    </div>
</div>	</div>
<div id="dialog-confirmation" style="display: none;"></div>
</div>

<div id="BuyBCComparePanel" class="modalPopup blueAndWhite" style="width: 500px; min-height: 100px; display: none; *position:relative; *top:-150px;">
    <div id="simplemodal-close" class="simplemodal-close">
        <a id="ctl00_cphRoblox_BCCompareModal_A2" class="ImageButton closeBtnCircle_35h" style="cursor: pointer; margin-left:486px; position:absolute; top:-15px;"></a>
    </div>
    <div id="BCCompareModal" style="border:none;">


    <div id="ctl00_cphRoblox_BCCompareModal_BCCompareModalUpdatePanel" class="BCCompareModalUpdatePanel">
	

        <div id="BuyBCComparePanelTopInfo" style="width:390px;">
            <div id="ComparePanelImg" style="margin-bottom:15px;text-align: center;margin-top:-10px;">
                <span style="font-weight:bold;font-size:13px;">Product Selected</span>
                <br />
                <img id="ctl00_cphRoblox_BCCompareModal_BuyBCComparePanelImage" src="" style="border-width:0px;margin-top:5px;" />
            </div>
            <span id="ctl00_cphRoblox_BCCompareModal_BCCompareConversionInfo"></span>
        </div>
                    
        <div style="border:1px solid #D3D3D3;">
        <br/>
            <table id="ctl00_cphRoblox_BCCompareModal_verid" class="BuyBCComparePanelTable" cellspacing="0" cellpadding="0" align="Center" border="0" style="border-collapse:collapse;margin-left:auto;margin-right:auto;width:450px;">
		<tr class="BCCompareHeaderRow">
			<th class="titlecolumn"></th><th style="padding:10px 0px 5px 8px;width:130px;color:#666;text-align: left;">Your Current <br/> Membership</th><th class="BCCompareModalRow" style="padding:10px 0px 5px 8px;border-top:1px solid #000;text-align: left;">Your New <br/> Membership</th>
		</tr><tr class="BBCCompareRow">
			<td class="titlecolumn">
                        Builders Club Type
                    </td><td id="ctl00_cphRoblox_BCCompareModal_currentBC" style="width:130px;color:#666;">None</td><td class="BCCompareModalRow"></td>
		</tr><tr class="BBCCompareRow">
			<td class="titlecolumn">
                        Recurring
                    </td><td style="width:130px;color:#666;">No</td><td class="BCCompareModalRow">No<span class="subscriptionHelp" style="margin-left:3px;position:absolute;font-size:16px;color:Red;">*</span>
                    </td>
		</tr><tr class="BBCCompareRow">
			<td style="border-bottom:none;">Expiration</td><td style="border-bottom:none;width:130px;color:#666;">xx/xx/xx</td><td class="BCCompareModalRow" style="border-bottom:1px solid #000;">xx/xx/xx</td>
		</tr>
	</table>
                <div class="subscriptionHelp" style="margin-bottom:15px;margin-left:15px;"><span style="color:Red;">*</span> You will be automatically billed every month starting xx/xx/xx </div>
                
                <script type="text/javascript">
                    $(function () {
                        $('.subscriptionHelp').hide();
                    });
                </script>
                
        </div>
        <div id="BCCompareButtons" style="width:390px;margin-top:15px;height:50px">
            <a href="PaymentMethods.aspx?ap=0" id="ctl00_cphRoblox_BCCompareModal_PurchaseLink" class="MediumButton" style="margin-left:auto;margin-right:auto;cursor: pointer; text-decoration:none;">Purchase</a>
        </div>
        


            
</div>
    </div>
</div> 

<script type="text/javascript">
    function BCCompareClick(preloaded) {
        if (preloaded == null) { preloaded = false; }
        if ($('#HasBCMembership').length > 0 && $('#HasBCMembership')[0].value == "False") { return; }
        var modalProperties = { overlayClose: true, escClose: true, opacity: 80, overlayCss: { backgroundColor: "#000"} };
        if (!preloaded) {
            $('.BCCompareModalUpdatePanel').html('<div style="background: url(/images/ProgressIndicator4.gif) center no-repeat;height:420px;width:100%;" >&nbsp;</div>');
        }
        $("#BuyBCComparePanel").modal(modalProperties);
    }
</script>

    
                <div style="clear:both"></div>
            </div>
        </div></div> 
        </div>
<?php
require_once($_SERVER["STATIC"]."/footer.php");
?>