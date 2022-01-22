<?php
require_once($_SERVER["STATIC"]."/settings.php");
require_once($_SERVER["STATIC"]."/authentication.php");
require_once($_SERVER["STATIC"]."/package_compiler.php");
AddCSS(CSS_DEFAULT_PACKAGE);
AddCSS(PackageCompiler::CompilePackage("page", ["/CSS/Pages/Upgrades/CardRedemption.css", "/CSS/PartialViews/Navigation.css", "/CSS/Base/CSS/Ads.css"], null));
AddJS(JS_DEFAULT_PACKAGE);
AddJS(PackageCompiler::CompilePackage("page", ["/js/Gamecard.js", "/js/GiftCard.js", "/js/GenericConfirmation.js", "/js/jquery.simplemodal-1.3.5.js", "/js/GenericModal.js"], ["/js/GPTAdScript.js"]));
require_once($_SERVER["STATIC"]."/header.php");
?>
        
        <div id="BodyWrapper">
            <div id="RepositionBody"><div id="Body" style=''>
                
    
    <div class="StandardBox">
        <div id="RedeemHeader">Redeem ROBLOX cards</div>
        
        
        <div style="clear:both"></div>
        <div id="RedeemContainer" class="StandardBoxGray">
            
				<?php if ($userAuth === false) { ?>
                <span style="margin-bottom:5px;font-size:14px;font-weight:bold;">How To Use</span>
                <p>You must be logged in to Redeem ROBLOX Cards. <a href='/Login/Default.aspx?ReturnUrl=<?php echo urlencode("http://".$_SERVER['HTTP_HOST']."/gamecard/Default.aspx"); ?>' >Login now</a> to redeem and start playing!</p>
                <?php } else { ?>
                        <table style="height:320px;">
                            <tr>
                                
                                <td style="width: 438px;">
                                    <div>
                                        <div id="HowToUse">How to Use</div>
                                        
                                        <a href="/Upgrades/GiftCards.aspx" target="_blank">
                                            <img style="margin-left:22px" src="https://s3.amazonaws.com/images.roblox.com/627204f674f8ae93f4d32db40ca1d9f7.png" alt="How to redeem"/>
                                        </a>
                                        
                                        <br />
                                        <ol>
                                            <li><span>Buy a ROBLOX game card at one of the participating retailers shown below, or receive a ROBLOX gift card from someone.</span></li>
                                            <li><span>Redeem your card inthe section to the right.</span></li>
                                            <li><span>Combine cards for more ROBLOX credit.</span></li>
                                            <li><span>Spend your ROBLOX credit on Robux and Builders Club!</span></li>
                                        </ol>
                                    </div>
                                    <div class="OnePaymentFormDiv">Purchases can be made with only one form of payment. Game card credits cannot be combined with other forms of payment.</div>
                                </td>
                                
                                <td style="width: 1px; margin: 0px; padding: 0px; border: 0px; background-color: #a9a9a9"></td>
                                
                                <td style="vertical-align: bottom;">
                                    
                                    <div style="margin-left: 90px;margin-bottom:20px;">
                                        <img src="https://s3.amazonaws.com/images.roblox.com/82f3215e93d509b06e64c4ef34f09ef7.png" width="141" height="37" alt="Enter Your PIN" /><br />
                                        <div style="margin-top:10px; height:30px;">
                                            <input style="width:141px;*margin-left:-90px;" id="pin" type="text" />
                                            <div class="GreenButton" style="margin-left:10px;margin-top:3px;" onclick="Roblox.GameCard.redeemCode();"><span>Redeem</span></div>
                                            <img id="busy" src="https://s3.amazonaws.com/images.roblox.com/21e504e643e6c21e0c90e5a1b03325f9.gif" align="top" height="30px" width="30px" style="visibility:hidden;" alt="Loading"/>
                                        </div>
                                        <div style="font-weight:bold; margin-top:10px;">
                                            Your Balance:
                                            <span id="balance" class="Money">$0.00</span>
                                        </div>                         
                                    </div>
                                    
                                    <div style="height:90px;margin-left: 14px;padding-top: 10px;">
                                        
                                        <table id="success" class="SuccessBox" style="display:none;">
                                            <tr>
                                                <td width="60px"><img src="https://s3.amazonaws.com/images.roblox.com/7373772141a4fbe5ea31b4063f70c92f.png" /></td>
                                                <td>
                                                    <p id="SuccessMessage" class="GameCardText"></p>
                                                    <p id="SuccessMessageSubText" class="GameCardText"></p>
                                                    <p id="Message" class="GameCardMessage"></p>
                                                </td>
                                            </tr>
                                        </table>
                                        
                                        <table id="error" class="ErrorBox" style="display:none;">
                                            <tr>
                                                <td width="60px"><img src="https://s3.amazonaws.com/images.roblox.com/8ebb2881fce3e607b89fd0ecd9273f64.png" /></td>
                                                <td><span id="errorText" class="GameCardText"></span></td>
                                            </tr>
                                        </table>
                                    </div>   
                                </td>
                            </tr>
                        </table>
				<?php } ?>
				
        </div>
        <div id="MoreInfo">
            
                <div class="StandardBoxGray" >
                    <div>
                        <p class="GameCardPromo">Get ROBLOX credit and spend it on:</p>
                        <img src="https://s3.amazonaws.com/images.roblox.com/a33ef57e02fc3023c8415ccba7694f38.png" /><span class="BigLinks GamecardBoxTextAligned">Robux</span><br />
                        <img id="BuyBC" src="https://s3.amazonaws.com/images.roblox.com/ce969a0d2f62396386e678229533f681.png" /><span class="BigLinks GamecardBoxTextAligned">Classic Builders Club </span><br />
                        <img id="BuyTBC" src="https://s3.amazonaws.com/images.roblox.com/c727f8d945ac06b9e35a226f7751aa0c.png" /><span class="BigLinks GamecardBoxTextAligned">Turbo Builders Club <span style="font-weight:normal;">(6 & 12 months)</span></span><br />
                        <img src="https://s3.amazonaws.com/images.roblox.com/f874457af275fbe787a1b7d8e7ddec80.png" /><span class="BigLinks GamecardBoxTextAligned">Outrageous Builders Club  <span style="font-weight:normal;">(6 & 12 months)</span></span>
                    </div>
                </div>
            <?php if ($userAuth !== false) { ?>
            <div class="StandardTabGrayActive"><span>Where to Buy</span></div>
            <div class="StandardBoxGray">
            
                <div id="WhereToBuyBlurb" style="margin:15px 60px 30px; line-height:18px;">
                    Some ROBLOX cards come with a free gear item or hat! The free items change each month, so check back often to see the new exclusive items!
                    The items are awarded in the month that the card is redeemed - not the month that the ROBLOX card is purchased - so redeem your ROBLOX card today!
                </div>
                <table style="margin-left: 100px; text-align:center;">
                    
                        <tr>
                            <td class="WhereToBuyTableCell" style="vertical-align:top;"><a href="http://www.walmart.com/cservice/ca_storefinder.gsp" target="_blank"><img class="partnerLogo" src="https://s3.amazonaws.com/images.roblox.com/e8e2984cae805a72423de1e7fcb54cee.png" /></a></td>
                            <td class="WhereToBuyTableCellRight">
                                

                            </td>
                        <tr>
                            <td class="WhereToBuyTableCell" style="vertical-align:top;"><a href="http://www.gamestop.com/StoreLocator.aspx" target="_blank"><img class="partnerLogo" src="https://s3.amazonaws.com/images.roblox.com/6ddbeff26708605cf66fd8a50df3c66a.png" /></a></td>
                            <td class="WhereToBuyTableCellRight">
                                

                            </td>
                        </tr>
                    
                        <tr>
                            <td class="WhereToBuyTableCell" style="vertical-align:top;"><a href="http://sites.target.com/site/en/spot/page.jsp?title=store_locator_new" target="_blank"><img class="partnerLogo" src="https://s3.amazonaws.com/images.roblox.com/5f458d8d8b475d458016e6c170830060.png" /></a></td>
                            <td class="WhereToBuyTableCellRight">
                                

                            </td>
                        </tr>
                    
                        <tr>
                            <td class="WhereToBuyTableCell" style="vertical-align:top;"><a href="http://www.7-eleven.com/locator.aspx" target="_blank"><img class="partnerLogo" src="https://s3.amazonaws.com/images.roblox.com/c884ad375f9e50d635800c23b068a9fb.png" /></a></td>
                            <td class="WhereToBuyTableCellRight">
                                

                            </td>
                        </tr>
                    
                        <tr>
                            <td class="WhereToBuyTableCell" style="vertical-align:top;"><a href="http://www.bestbuy.com/site/olspage.jsp?id=cat12090&type=page" target="_blank"><img class="partnerLogo" src="https://s3.amazonaws.com/images.roblox.com/d750b85f57b532cc3c67447d189c3d1c.png" /></a></td>
                            <td class="WhereToBuyTableCellRight">
                                

                            </td>
                        </tr>
                    
                        <tr>
                            <td class="WhereToBuyTableCell" style="vertical-align:top;"><a href="http://www.cvs.com/CVSApp/store/storefinder.jsp" target="_blank"><img class="partnerLogo" src="https://s3.amazonaws.com/images.roblox.com/1dc2e651dea7b8afb865d9935356824e.png" /></a></td>
                            <td class="WhereToBuyTableCellRight">
                               

                            </td>
                        </tr>
                    
                        <tr>
                            <td class="WhereToBuyTableCell" style="vertical-align:top;"><a href="http://www.toysrus.com/storeLocator/index.jsp" target="_blank"><img class="partnerLogo" src="https://s3.amazonaws.com/images.roblox.com/47dba5430bf0b00916ecfa15d8057567.png" /></a></td>
                            <td class="WhereToBuyTableCellRight">
                                

                            </td>
                        </tr>
                    
                        <tr>
                            <td class="WhereToBuyTableCell" style="vertical-align:top;"><a href="https://www-ssl.futureshop.ca/en-CA/stores/store-locator.aspx" target="_blank"><img class="partnerLogo" src="https://s3.amazonaws.com/images.roblox.com/9ffc695e77c57d3483b643a97b4e12e8.png" /></a></td>
                            <td class="WhereToBuyTableCellRight">
                                

                            </td>
                        </tr>
                    
                        <tr>
                            <td class="WhereToBuyTableCell" style="vertical-align:top;"><a href="http://m.sainsburys.co.uk/mt/www.sainsburys.co.uk/sol/storelocator/storelocator_landing.jsp" target="_blank"><img class="partnerLogo" src="https://s3.amazonaws.com/images.roblox.com/bbdbc538edb79e434c5517c79c9db8ee.png" /></a></td>
                            <td class="WhereToBuyTableCellRight">
                                

                            </td>
                        </tr>
                    
                        <tr>
                            <td class="WhereToBuyTableCell" style="vertical-align:top;"><a href="http://www.fye.com/Store-Locator_stcVVcatId474286VVviewcat.htm" target="_blank"><img class="partnerLogo" src="https://s3.amazonaws.com/images.roblox.com/56a7f5c558da7abbf85a0c90df163afe.jpg" /></a></td>
                            <td class="WhereToBuyTableCellRight">
                                

                            </td>
                        </tr>
                    
                        <tr>
                            <td class="WhereToBuyTableCell" style="vertical-align:top;"><a href="http://www.ebgames.com/browse/storesearch.aspx" target="_blank"><img class="partnerLogo" src="https://s3.amazonaws.com/images.roblox.com/8f2a1e6aefd75a387bb825f2ad7b8a3a.png" /></a></td>
                            <td class="WhereToBuyTableCellRight">
                                

                            </td>
                        </tr>
                    
                    </table>
                    <p style="text-align:center">Available at most US locations.</p>
                    <p style="text-align:center">All Sales are final. Please see our <a href="/info/TermsOfService.aspx">Terms & Conditions</a> for more information.</p>
            
            </div>
			<?php } ?>
        </div>
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
            <a href="../Upgrades/PaymentMethods.aspx?ap=0" id="ctl00_cphRoblox_BCCompareModal_PurchaseLink" class="MediumButton" style="margin-left:auto;margin-right:auto;cursor: pointer; text-decoration:none;">Purchase</a>
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


    <div id="GameCardSubstituteModal" class="blueAndWhite" style="width:460px;padding:2px;background:white;display:none;*position:absolute;*top:-150px">
        <div>
            <div style="margin-bottom:15px;">
                <div style="background-color:black; color:white; font: bold 17px Arial; text-align:center; margin:0 0 10px; padding:4px 0;">
                    Redemption Successful!
                </div>
                <div style="float:left;width:100px;padding-left:15px;">
                    <img src="https://s3.amazonaws.com/images.roblox.com/e4ea14a2abc036fb2f3a62132e8a15a5.png" alt="Robux" />
                </div>
                <div style="float:left;padding:10px 0 35px;width:320px;line-height: 20px;font:bold 13px Arial;">
                    <div>You are already a Builders Club member,</div>
                    <div><span id="ProductName" style="color:Green">1000 Robux</span> has been credited to you instead.</div>
                </div>
                <div style="clear:both; text-align:center">
                    <a class="ImageButton btn-large btn-neutral roblox-ok simplemodal-close">OK<span class="btn-text">OK</span></a>
                </div>
            </div>
        </div>
    </div>

    <script type="text/javascript">
        function showGameCardSubstituteModal(productName) {
            var modalProperties = { overlayClose: true, escClose: true, opacity: 80, overlayCss: { backgroundColor: "#000"} };
            $("#ProductName").text(productName);
            $("#GameCardSubstituteModal").modal(modalProperties);
        }

        $(function () {
            //<sl:translate>
            Roblox.GameCard.Resources = {
                unexpectedError: "An unexpected error occured. Please try your request again later.",
                unrecognizedPin: "Unrecognized PIN format."
            };
            //</sl:translate>
        });
    </script>
    
    <script type="text/javascript">
        
    </script>
    
                <div style="clear:both"></div>
            </div>
        </div></div> 
        </div>
<?php
$_PS->FooterJS = "if(typeof __utmSetVar !== 'undefined'){ __utmSetVar(''); }if(typeof __utmSetVar !== 'undefined'){ __utmSetVar('Roblox_Home_Top_728x90'); }";
require_once($_SERVER["STATIC"]."/footer.php");
?>