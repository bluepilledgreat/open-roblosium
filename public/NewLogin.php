<?php
require_once($_SERVER["STATIC"]."/settings.php");
require_once($_SERVER["STATIC"]."/connection.php");
require_once($_SERVER["STATIC"]."/authentication.php");
require_once($_SERVER["STATIC"]."/package_compiler.php");
$errorMessage = false;
if (isset($_POST["Username"]))
{
	do {
		$loginAuth = (new UserAuthentication($_POST["Username"]))->Fix();
		if (!$loginAuth)
		{
			$errorMessage = "Your username or password is incorrect.";
			break;
		}
		if (password_verify($_POST["Password"], $loginAuth->GetUserInfo("password")))
		{
			setrawcookie(".ROBLOSECURITY", $loginAuth->GetAuthenticationToken(), 2147483647, "/", $_SERVER['HTTP_HOST']);
			header("Location: /home?nl=true");
		}
		else
		{
			$errorMessage = "Your username or password is incorrect.";
		}
	} while (0);
}
AddCSS(CSS_DEFAULT_PACKAGE);
AddCSS(PackageCompiler::CompilePackage("page", ["/CSS/Pages/IDE/Login.css","/CSS/Base/CSS/iFrameLogin.css","/CSS/Pages/Login/Login.css","/CSS/PartialViews/Navigation.css"], null));
AddJS(JS_DEFAULT_PACKAGE);
AddJS(PackageCompiler::CompilePackage("page", ["/js/jquery.validate.js","/js/jquery.validate.unobtrusive.js","/js/Login/Login.js","/js/GenericConfirmation.js"], null));
$_PS->HeaderAds = false;
$_PS->ASPNetFormTagEnabled = false;
require_once($_SERVER["STATIC"]."/header.php");
?>
        <div id="BodyWrapper">
            <div id="RepositionBody">
                <div id="Body" style="width:970px">
                    
<!--[if IE 7]>
<style>        
    #signInButtonPanel a 
    {
        margin-right: 143px;
    }
</style>
<![endif]-->
<h1>Login to ROBLOX</h1>
<div>
<form action="/newlogin" id="loginForm" method="post">
<?php if($errorMessage) { ?>
<div class="validation-summary-errors"><?php echo $errorMessage; ?></div>
<?php } ?>
            <div id="loginarea" class="divider-bottom">
                <div id="leftArea">
                    <div id="loginPanel">   
                        <table id="logintable">
                            <tr id="username">
                                <td><label class="form-label" for="Username">Username:</label></td>
                                <td><input class="text-box text-box-medium" data-val="true" data-val-required="The Username field is required." id="Username" name="Username" type="text" value="<?php echo (isset($_POST["Username"]) ? $_POST["Username"] : ""); ?>" /></td>
                            </tr>
                            <tr id="password">
                                <td><label class="form-label" for="Password">Password:</label></td>
                                <td><input class="text-box text-box-medium" data-val="true" data-val-required="The Password field is required." id="Password" name="Password" type="password" /></td>
                            </tr>
                        </table>
                        <div>
                        </div>
                        <div>
                            <div id="forgotPasswordPanel">
                                <a class="text-link" href="/Login/ResetPasswordRequest.aspx" target="_blank">Forgot your password?</a>
                            </div>
                            <div id="signInButtonPanel">
                                <a  roblox-js-onclick class="btn-medium btn-neutral">Sign In</a>
                                <a  roblox-js-oncancel class="btn-medium btn-negative">Cancel</a>
                            </div>
                            <div class="clearFloats">
                            </div>
                        </div>
                        <span id="fb-root">
                                    <div id="SplashPageConnect" class="fbSplashPageConnect">
                                        <a class="facebook-login" href="/Facebook/SignIn?returnTo=/My/Home.aspx" ref="form-facebook">
                                            <span class="left"></span>
                                            <span class="middle">Login with Facebook<span>Login with Facebook</span></span>
                                            <span class="right"></span>
                                        </a>       
                                    </div>
                        </span>
                    </div>
                </div>
                <div id="rightArea" class="divider-left">
                    <div id="signUpPanel" class="FrontPageLoginBox">
                        <p class="text">Not a member?</p>
                        <h2>Sign Up to Build & Make Friends</h2>
                        <p class="text">What is your birthday?</p>
                        <select id="MonthSelect" class="form-select" name="Month">
                            <option>Month</option>
                        </select>
                        <select id="DaySelect" class="form-select" name="Day">
                            <option>Day</option>
                        </select>
                        <select id="YearSelect" class="form-select" name="Year">
                            <option>Year</option>
                        </select>
                        <p class="footnote" id="disclaimer">Your birthday will not be given out to any third party!</p>
<a  roblox-js-onsignup class="btn-medium btn-primary">Sign Up</a>                    </div>
                </div>
            </div>
<input id="ReturnUrl" name="ReturnUrl" type="hidden" value="" /></form></div>
<script type="text/javascript">
    if (typeof Roblox === "undefined") {
        Roblox = {};
    }
    if (typeof Roblox.Login === "undefined") {
        Roblox.Login = {};
    }

    Roblox.Login.Resources = {
        //<sl:translate>
        january: "January"
		, february: "February"
		, march: "March"
		, april: "April"
		, may: "May"
		, june: "June"
		, july: "July"
		, august: "August"
		, september: "September"
		, october: "October"
		, november: "November"
		, december: "December"
        //</sl:translate>
    };
</script>
<div id="guestarea">
    <h2>You don't need an account to play ROBLOX</h2>
    <br/>
    <p class="text">You can start playing right now, in guest mode! <a  href="/Games.aspx" class="btn-small btn-neutral" id="guestButton">Play as Guest</a></p>
    
</div>
<script type="text/javascript">
    $(function() {{ RobloxEventManager.triggerEvent('rbx_evt_abtest', { experiment: 'MVCLoginPage', variation: 'MVCLoginPage'});}});
</script>
                    <div style="clear:both"></div>
                </div>
            </div>
        </div>
<?php
require_once($_SERVER["STATIC"]."/footer.php");
?>