<?php
require_once($_SERVER["STATIC"]."/settings.php");
require_once($_SERVER["STATIC"]."/authentication.php");
require_once($_SERVER["STATIC"]."/package_compiler.php");
if ($_S->AnimatedLandingRedirect && $userAuth === false)
	die(header("Location: /Landing/Animated"));
elseif ($userAuth)
	die(header("Location: /home"));
$_PS->HeaderAds = false;
AddCSS(CSS_DEFAULT_PACKAGE);
AddCSS(PackageCompiler::CompilePackage("page", ["/CSS/PartialViews/Navigation.css", "/CSS/Base/CSS/AdFormatClasses.css"], null));
AddJS(JS_DEFAULT_PACKAGE);
$_PS->ASPNetFormTagEnabled = false;
require_once($_SERVER["STATIC"]."/header.php");
?>
<div id="Body" style="width:970px;">
                
    

    
    <script type="text/javascript">
        //Code for A|B|C test- just one/all goto burning ma
            switch (0) {
                case 0:
                    break;
                case 1:
                    $("#PlayNowButton").css('visibility', 'hidden');
                    $(function () {
                        $('.FeaturedGameHeader').css('visibility', 'hidden');
                        $('.FeaturedGameHeader').css('height', '0px');
                        $('.FeaturedGamePlayButton').css('height', '290px');
                    });
                    break;
                case 2:
                    $('.SignUpAndPlay').attr('href', "");
                    $('.SignUpAndPlay').click(function () {
                        $('.VisitButtonPlay').click();
                        return false;
                    });
                    $(function () {
                        $('#ctl00_cphRoblox_MoneyMachine_PlayNowButton').attr('href', "");
                        $('#ctl00_cphRoblox_MoneyMachine_PlayNowButton').click(function () {
                            $('.VisitButtonPlay').click();
                            return false;
                        });
                    });

                    //set href of FeaturedGamesPlay to "burning man"s
                    break;
            }
            //Code for bigPlayNowButtonLocation A|B test
            if(false){
                $(function () {
					$('#ctl00_cphRoblox_rbxVisitButtons_FeaturedGameButton').attr('placeid', 1818);
					$('#FeaturedGameButton').attr('placeid', 1818);
                });
            }
            //else is already acting as needed
        </script>
        
    
    <div class="TopPanel" style="float: left; margin: 0px;position:relative;">
        <div id="ctl00_cphRoblox_FrontPageLogin" class="FrontPageLoginBox">
            

<div id="LoginViewContainer">
    

            <script type="text/javascript" language="javascript">
                function dologin() {
                    document.getElementById("username").value = document.getElementById("txtUsername").value;
                    document.getElementById("password").value = document.getElementById("txtPassword").value;
                    document.forms[1].submit();
                }
            </script>

<form action="/NewLogin" method="POST" id="sign_in">
<div class="DarkGradientBox">
    <div class="DGB_Header">Member Login</div>
    <div style="padding:0px;">
        <div class="form-outer">  
        <div class="form-inner label-column">
            <div for="txtUsername" class="DGB_Label" style="top:0px;margin-bottom:10px;">Username:</div> 
            <div for="txtPassword" class="DGB_Label passwordInput" style="*top:2px;">Password:</div>
        </div>
        <div class="form-inner input-column">
            <input type="text" name="Username" class="DGB_TextBox" id="txtUsername" tabindex="1" style="margin-bottom:10px;margin-right:0px;">
            <input type="password" name="Password" onkeypress="if (event.which || event.keyCode){if ((event.which == 13) || (event.keyCode == 13)) {dologin(); return false;} else {return true;}}" id="txtPassword" class="DGB_TextBox" style="margin-right:0px;" tabindex="2">
            <span id="ForgetPasswordPrompt"><a href="/Login/ResetPasswordRequest.aspx">Forget your password?</a></span> 
            <div class="clear"></div>
        </div>
        </div>


        <div style="margin-top: 9px; text-align: center;">
            <a class="ControlLoginButton" onclick="$('#sign_in').submit(); return false;" href="#" ref="form-login" tabindex="3">Sign In</a>
        </div>       

    </div>
</div>
</form> 
</div>


            <div id="ctl00_cphRoblox_SeparateSignup" class="separateSignUpFromLoginWithBorder">
	            
<div id="SplashPageConnect" class="fbSplashPageConnect">
	<a class="facebook-login" href="/facebook/signin?returnTo=%2FMy%2FHome.aspx" target="_top" ref="form-facebook">
		<span class="left"></span>
		<span class="middle">Login with Facebook<span>Login with Facebook</span></span>
		<span class="right"></span>
	</a>
</div>
                <div class="CenterSignupText">
                    <span class="not-a-member">Not a member?</span>
                    <a href="Login/NewAge.aspx" class="btn-medium btn-neutral" style="vertical-align: bottom; margin-left:5px;">Sign Up<span class="btn-text">Sign Up</span></a>
                </div>
            </div> 
        </div>
        

        <div class="FrontPageVideoIntro">
               
                    <object class="videoURL">
                        <param name="movie" value="http://www.youtube.com/v/97dyt7MXWpo&amp;fs=1&amp;rel=0">
                        <param name="allowFullScreen" value="true">
                        <param name="allowscriptaccess" value="always">
                        <param name="wmode" value="transparent">
                        <embed wmode="transparent" src="http://www.youtube.com/v/97dyt7MXWpo&amp;fs=1&amp;rel=0&amp;autoplay=1" type="application/x-shockwave-flash" allowscriptaccess="always" allowfullscreen="true" allownetworking="internal" width="380" height="250">
                    </object>
                
            </div>
            <div style="float:right">
	            
                
				

	<div id="FeaturedGameButtonContainer" style="height: 1px;">
			<div class="FeaturedGameButton VisitButtonPlay" id="FeaturedGameButton" ref="bigplaynow" placeid="41324860"></div>
	</div>
		   

<script type="text/javascript">
	var play_placeId = 0;
        function redirectPlaceLauncherToLogin() {
            location.href = "/login/default.aspx?ReturnUrl=" + encodeURIComponent("/Default.aspx");
        }
        function redirectPlaceLauncherToRegister() {
            location.href = "/login/NewAge.aspx?ReturnUrl=" + encodeURIComponent("/Default.aspx");
        }
        function fireEventAction(action) {
            RobloxEventManager.triggerEvent('rbx_evt_popup_action', { action: action });
        }
	$(function () { $('.VisitButtonPlay').click(function () {play_placeId=$(this).attr('placeid');Roblox.CharacterSelect.placeid = play_placeId;Roblox.CharacterSelect.show();});$('.FeaturedGameButton').click(function () {});Roblox.CharacterSelect.robloxLaunchFunction = function (genderTypeID) { if (genderTypeID == 3) { var isInsideRobloxIDE = 'website'; if (Roblox && Roblox.Client && Roblox.Client.isIDE && Roblox.Client.isIDE()) { isInsideRobloxIDE = 'Studio'; };GoogleAnalyticsEvents.FireEvent(['Play Location', 'Guest', isInsideRobloxIDE]);GoogleAnalyticsEvents.FireEvent(['Play', 'Guest', '', 0]);$(function(){ RobloxEventManager.triggerEvent('rbx_evt_play_guest', {age:'Unknown',gender:'Female'});});} else { var isInsideRobloxIDE = 'website'; if (Roblox && Roblox.Client && Roblox.Client.isIDE && Roblox.Client.isIDE()) { isInsideRobloxIDE = 'Studio'; };GoogleAnalyticsEvents.FireEvent(['Play Location', 'Guest', isInsideRobloxIDE]);GoogleAnalyticsEvents.FireEvent(['Play', 'Guest', '', 1]);$(function(){ RobloxEventManager.triggerEvent('rbx_evt_play_guest', {age:'Unknown',gender:'Male'});});}play_placeId = (typeof $(this).attr('placeid') === 'undefined') ? play_placeId : $(this).attr('placeid'); Roblox.Client.WaitForRoblox(function() { RobloxLaunch.RequestGame('PlaceLauncherStatusPanel', play_placeId, genderTypeID); }); return false;};});;
</script>
            </div> 
    </div>    

    <!-- right column -->
    <div class="overrideColumn2c">
        <div id="ctl00_cphRoblox_boxAdPanel" style="padding-left:5px;">
	
            <div style="height: 282px;">
                <div style="float:left;width:310px;" id="FrontPageRectangleAd">
                    
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
</div>

                </div>
            </div>
        
</div>
        
        <div class="SidePanel" style="">
            <h2>Roblox News</h2>
            <div id="ctl00_cphRoblox_NewsFeed1_pRobloxNews">
	
    
    <div id="RobloxNews" style="float: none; width: 100%; overflow: visible;">
        <div style="margin-bottom: 15px;">
            
                
                    <div style="background: url(/images/BulletPointArrow.png) no-repeat center left;padding-left: 13px;margin-bottom: 10px;">
                        <a href="http://blog.roblox.com/2013/10/a-look-back-at-a-summer-full-of-bloxcons/?utm_source=rss&amp;utm_medium=rss&amp;utm_campaign=a-look-back-at-a-summer-full-of-bloxcons" ref="news-article" class="roblox-interstitial">A Look Back at a Summer Full of BLOXcons</a>
                    </div>
                
                    <div style="background: url(/images/BulletPointArrow.png) no-repeat center left;padding-left: 13px;margin-bottom: 10px;">
                        <a href="http://blog.roblox.com/2013/10/redeem-roblox-cards-in-october-and-get-halloween-items/?utm_source=rss&amp;utm_medium=rss&amp;utm_campaign=redeem-roblox-cards-in-october-and-get-halloween-items" ref="news-article" class="roblox-interstitial">Redeem ROBLOX Cards in October and Get Halloween Items</a>
                    </div>
                
                    <div style="background: url(/images/BulletPointArrow.png) no-repeat center left;padding-left: 13px;margin-bottom: 10px;">
                        <a href="http://blog.roblox.com/2013/10/lower-floor-prices-for-clothing/?utm_source=rss&amp;utm_medium=rss&amp;utm_campaign=lower-floor-prices-for-clothing" ref="news-article" class="roblox-interstitial">Lower Floor Prices for Clothing</a>
                    </div>
                
                    <div style="background: url(/images/BulletPointArrow.png) no-repeat center left;padding-left: 13px;margin-bottom: 10px;">
                        <a href="http://blog.roblox.com/2013/10/new-movements-set-stage-for-keyframe-animation-system/?utm_source=rss&amp;utm_medium=rss&amp;utm_campaign=new-movements-set-stage-for-keyframe-animation-system" ref="news-article" class="roblox-interstitial">New Movements Set the Stage for Keyframe Animation System</a>
                    </div>
                
                
        </div>
        <a href="http://blog.roblox.com/" class="SeeMore roblox-interstitial">See More</a><img border="0" alt="See more! " src="http://images.rbxcdn.com/efe86a4cae90d4c37a5d73480dea4cb1.png" style="width:9px; height:9px;">
        
    </div>

</div>
        </div>
    </div>
    
    <!-- left column -->
    <div class="overrideColumn1c">
        <div style="margin: 5px 0; width: 550px;"><a href="/Games.aspx" class="RobloxFreeBuildingBanner" style="background-image: url('http://images.rbxcdn.com/f0a141183a3c750815c53e4ad0d07d56.jpg');"></a></div>
        
        
        
            
        
    </div>  

    <br clear="all">    
    <img src="http://media.fastclick.net/w/tre?ad_id=20713;evt=13114;cat1=14473;cat2=14474" id="ctl00_cphRoblox_fastclick" border="0" height="1" width="1">

    <script type="text/javascript">
        FacebookLogout = function() {
            var appid = '190191627665278';
            FBLogout(appid);
        };

        // handle a session response from any of the auth related calls
        function handleLogout(response) {
            // if we dont have a session, just hide the user info
            if (!response.authResponse) {
                clearDisplay();
                return;
            }

            
            return;
            
            var modalProperties = { escClose: true, opacity: 80, overlayCss: { backgroundColor: "#000" }, position: [120, 0] };
            $("#ConfirmFacebookLogout").modal(modalProperties);
        }
    </script>

        <div id="ConfirmFacebookLogout" class="GuestModePromptModal" style="width:400px; display:none">
            <div id="GuestDialog" style="background-color: white;">
                <div style="height:20px;"></div>
        
                <p style="font-size:medium;font-weight:bold;text-align:center; margin-left:10px;margin-right:10px">You are currently logged into Facebook. Also log out of Facebook?</p>     
        
                <div style="height:20px;"></div>

                <div style="display:inline-block;" class="simplemodal-close">
                    <div style="float:left; margin-left:70px;">
                        <a onclick="FB.logout(clearSession);" id="ctl00_cphRoblox_AccountSyncUp" tabindex="8" class="GreenButton" href="javascript:__doPostBack('ctl00$cphRoblox$AccountSyncUp','')">
                            <span>Logout</span>
                        </a>
                    </div>

                    <div style="margin-right:50px;" class="simplemodal-close overrideDontLogout">
                        <a id="ctl00_cphRoblox_LinkButton1" tabindex="8" class="RedButton" href="javascript:__doPostBack('ctl00$cphRoblox$LinkButton1','')">
                            <span>Don't Logout</span>
                        </a>
                    </div>
                </div>
                <div style="height:20px;"></div>
            </div>
        </div>

                <div style="clear:both"></div>
            </div>
<?php
require_once($_SERVER["STATIC"]."/footer.php");
?>