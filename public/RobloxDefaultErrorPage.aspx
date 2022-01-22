<?php
$errorCode = (isset($errorCode) ? $errorCode : (isset($_GET["code"]) ? (int)$_GET["code"] : 400));
require_once($_SERVER["STATIC"]."/settings.php");
require_once($_SERVER["STATIC"]."/package_compiler.php");
$_PS->Title = "ROBLOX Error";
$_PS->HeaderAds = false;
$_PS->NavigationOptions = false;
$_PS->HeaderTipsy = true;
AddCSS(CSS_DEFAULT_PACKAGE);
AddCSS(PackageCompiler::CompilePackage("page", ["/CSS/PartialViews/Navigation.css"], null));
AddJS(JS_SIMPLE_PACKAGE);
require_once($_SERVER["STATIC"]."/header.php");
?>
		<div id="Body" class="simple-body">
            
<?php
switch($errorCode)
{
	case 404:
		echo '<div id="ErrorPage">    
    <img src=\'http://images.rbxcdn.com/44bf8b61b3c2d5f76837b2209dfb99b0.png\' alt="Alert" class="ErrorAlert"/>
    
    <h1><span id="ctl00_cphRoblox_ErrorTitle">Requested page not found</span></h1>
    <h3><span id="ctl00_cphRoblox_ErrorMessage">You may have clicked an expired link or mistyped the address.</span></h3>
    <p><span id="ctl00_cphRoblox_CustomerServiceMessage"></span></p>
    <pre><span id="ctl00_cphRoblox_errorMsgLbl"></span></pre>

    <div class="divideTitleAndBackButtons">&nbsp;</div>

    <div class="CenterNavigationButtonsForFloat">
        <a class="btn-small btn-neutral" title="Go to Previous Page Button" onclick="history.back();return false;" href="#">Go to Previous Page <span class="btn-text"> Go to Previous Page</span></a>
        <a class="btn-neutral btn-small" title="Return Home" href="/Default.aspx">Return Home <span class="btn-text">Return Home</span></a>
        <div style="clear:both"></div>
    </div>
</div>';
		break;
	default: // 400 and 500
		echo '<div id="ErrorPage">    
    <img src=\'http://images.rbxcdn.com/44bf8b61b3c2d5f76837b2209dfb99b0.png\' alt="Alert" class="ErrorAlert"/>
    
    <h1><span id="ctl00_cphRoblox_ErrorTitle">Unexpected error with your request</span></h1>
    <h3><span id="ctl00_cphRoblox_ErrorMessage">Please try again after a few moments.</span></h3>
    <p><span id="ctl00_cphRoblox_CustomerServiceMessage">If you continue to receive this page, please contact customer service at <a href="mailto:'.$_S->Emails->CustomerSupport.'">'.$_S->Emails->CustomerSupport.'</a>.</span></p>
    <pre><span id="ctl00_cphRoblox_errorMsgLbl"></span></pre>

    <div class="divideTitleAndBackButtons">&nbsp;</div>

    <div class="CenterNavigationButtonsForFloat">
        <a class="btn-small btn-neutral" title="Go to Previous Page Button" onclick="history.back();return false;" href="#">Go to Previous Page <span class="btn-text"> Go to Previous Page</span></a>
        <a class="btn-neutral btn-small" title="Return Home" href="/Default.aspx">Return Home <span class="btn-text">Return Home</span></a>
        <div style="clear:both"></div>
    </div>
</div>';
		break;
}
?>

		</div>
<?php
require_once($_SERVER["STATIC"]."/footer.php");
?>