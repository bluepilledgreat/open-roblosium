<?php
require_once($_SERVER["STATIC"]."/connection.php");
require_once($_SERVER["STATIC"]."/settings.php");
require_once($_SERVER["STATIC"]."/profanity_filter.php");
require_once($_SERVER["STATIC"]."/package_compiler.php");
require_once($_SERVER["STATIC"]."/authentication.php");
if (!empty($_POST))
{
	do {
		$username = $_POST['ctl00$cphRoblox$ctl00$UserName'];
		$password = $_POST['pass'];
		$passwordConfirm = $_POST['passConfirm'];
		$gender = ($_POST['ctl00$cphRoblox$ctl00$Gender'] == "FemaleBtn" ? "Female" : "Male");
		// BDAY variables:
		$bdayDay = (int)$_POST['ctl00$cphRoblox$ctl00$lstDays'];
		$bdayMonth = (int)$_POST['ctl00$cphRoblox$ctl00$lstMonths'];
		$bdayYear = (int)$_POST['ctl00$cphRoblox$ctl00$lstYears'];
		// username checks
		if (strlen($username) < 3 || strlen($username) > 20)
			break;
		if (!ProfanityFilter::IsAppropriateForSignup($username))
			break;

		$stmt = $conn->prepare("SELECT * FROM users WHERE username=:username");
		$stmt->bindParam(":username", $username);
		$stmt->execute();
		if ($stmt->rowCount() >= 1)
			break;
		// password checks
		if ($password != $passwordConfirm)
			break;
		if (strlen($password) < 6 || strlen($password) > 20)
			break; // TODO: check letter count and number count
		$password = password_hash($password, PASSWORD_BCRYPT, ["cost" => 12]);
		// birthday checks
		if (!checkdate($bdayMonth, $bdayDay, $bdayYear)) 
			break;
		// lets check for time travellers
		if ($bdayYear > date("Y")) // TODO: check if they're ahead of time in the current year
			break;
		$bday = $bdayMonth . "/" . $bdayDay . "/" . $bdayYear;
		// add to database
		$stmt = $conn->prepare("INSERT INTO users (username, password, email, birthday, gender, bio, robux, tickets, membershiptype, membershipstart, membershipend, reg_ip, latest_ip, mac, lastonline, registered) ".
		"VALUES (:username, :password, '', :birthday, :gender, '', 10, 100, 'None', 0, 0, '127.0.0.1', '127.0.0.1', '', 0, :registered)");
		$stmt->bindParam(":username", $username);
		$stmt->bindParam(":password", $password);
		$stmt->bindParam(":birthday", $bday);
		$stmt->bindParam(":gender", $gender);
		$stmt->bindValue(":registered", time());
		$stmt->execute();
		// create auth token and give it to the user
		$userAuth = (new UserAuthentication($username))->Fix();
		if ($userAuth)
		{
			setrawcookie(".ROBLOSECURITY", $userAuth->GetAuthenticationToken(), 2147483647, "/", $_SERVER['SERVER_NAME']);
			header("Location: /home");
		}
		else // whoops...?
		{
			die(require_once("../RobloxDefaultErrorPage.aspx"));
		}
	} while (0); // do statement so we can use break
}

AddCSS(CSS_DEFAULT_PACKAGE);
AddCSS(PackageCompiler::CompilePackage("page", ["/CSS/PartialViews/Navigation.css","/CSS/Base/CSS/Ads.css","/CSS/Pages/Signup/Signup.css"], null));
AddJS(JS_DEFAULT_PACKAGE);
AddJS(PackageCompiler::CompilePackage("page", ["/js/SignupFormValidator.js","/js/GenericConfirmation.js","/js/jquery.simplemodal-1.3.5.js","/js/GenericModal.js"], ["/js/GPTAdScript.js"]));
require_once($_SERVER["STATIC"]."/header.php");
?>
        
        <div id="BodyWrapper">
            <div id="RepositionBody">
                <div id="Body" style=''>
                    

<div class="SignupWrapper">
    <div class="title">
        <h1>Sign up to build & make friends</h1>
    </div>

<div class="SignupBox divider-right">
        
 
 <div class="formRow">
    <label class="form-label" for="birthdate">Birthday</label>
    <div class="rightFormColumn">
        <div class="inputColumn radio">
        <select name="ctl00$cphRoblox$ctl00$lstMonths" id="lstMonths" tabindex="1" class="form-select" onchange="Roblox.SignupFormValidator.checkBirthday()">
	<option value="0">Month</option>
	<option value="1">Jan</option>
	<option value="2">Feb</option>
	<option value="3">Mar</option>
	<option value="4">Apr</option>
	<option value="5">May</option>
	<option value="6">Jun</option>
	<option value="7">Jul</option>
	<option value="8">Aug</option>
	<option value="9">Sep</option>
	<option value="10">Oct</option>
	<option value="11">Nov</option>
	<option value="12">Dec</option>

</select>
	    <select name="ctl00$cphRoblox$ctl00$lstDays" id="lstDays" tabindex="2" class="form-select" onchange="Roblox.SignupFormValidator.checkBirthday()">
	<option value="0">Day</option>
	<option value="1">1</option>
	<option value="2">2</option>
	<option value="3">3</option>
	<option value="4">4</option>
	<option value="5">5</option>
	<option value="6">6</option>
	<option value="7">7</option>
	<option value="8">8</option>
	<option value="9">9</option>
	<option value="10">10</option>
	<option value="11">11</option>
	<option value="12">12</option>
	<option value="13">13</option>
	<option value="14">14</option>
	<option value="15">15</option>
	<option value="16">16</option>
	<option value="17">17</option>
	<option value="18">18</option>
	<option value="19">19</option>
	<option value="20">20</option>
	<option value="21">21</option>
	<option value="22">22</option>
	<option value="23">23</option>
	<option value="24">24</option>
	<option value="25">25</option>
	<option value="26">26</option>
	<option value="27">27</option>
	<option value="28">28</option>
	<option value="29">29</option>
	<option value="30">30</option>
	<option value="31">31</option>

</select>
	    <select name="ctl00$cphRoblox$ctl00$lstYears" id="lstYears" tabindex="3" class="form-select" onchange="Roblox.SignupFormValidator.checkBirthday(false)" style="margin: 0;">
	<option value="0">Year</option>
	<?php
	foreach(range(date("Y"),1910) as $year) { ?>
	<option value="<?php echo $year; ?>"><?php echo $year; ?></option>
	<?php } ?>

</select>
        </div>
        <div class="validation">
            <table id="birthdayError" class="validator-container">
	<tr>
		<td><div class="validator-tooltip-top"></div><div class="validator-tooltip-main">
                <p id="birthdayErrorParagraph">Invalid birthday</p>
            </div><div class="validator-tooltip-bottom"></div></td>
	</tr>
</table>

            <div id="birthdayGood" class="validator-checkmark"></div>
        </div>
        <div class="clear" style="font-size:0;"></div>
        <span class="tip-text">Enter your birthday for a personalized experience.<br/>It will not be given to any third party.</span>
    </div>
    
    </div>

    <div class="formRow">
        <label class="form-label" for="gender">Gender:</label>

        <div class="formRadio signupPage">
            <input id="MaleBtn" type="radio" name="ctl00$cphRoblox$ctl00$Gender" value="MaleBtn" onclick="Roblox.SignupFormValidator.checkGender();" tabindex="4" /><label for="MaleBtn">Male</label> 
            <input id="FemaleBtn" type="radio" name="ctl00$cphRoblox$ctl00$Gender" value="FemaleBtn" onclick="Roblox.SignupFormValidator.checkGender();" tabindex="5" /><label for="FemaleBtn">Female</label> 
        </div>

        <div class="validation">
            <div id="genderError" class="validator-container" style="position:absolute">
                <div class="validator-tooltip-top"></div>
                <div class="validator-tooltip-main">
                    <p>Required field</p>
                </div>
                <div class="validator-tooltip-bottom"></div>
            </div>
            <div id="genderGood" class="validator-checkmark"></div>
        </div>
    </div>

    <div class="formRow">
    <label class="form-label" for="username">Desired Username:</label>
    <div class="rightFormColumn">
        <div class="inputColumn">
            <input name="ctl00$cphRoblox$ctl00$UserName" type="text" id="UserName" tabindex="6" class="text-box text-box-large" onblur="Roblox.SignupFormValidator.checkUsername()" />
        </div>
        <div class="validation">
            <table id="UsernameError" class="validator-container">
            <tr><td><div class="validator-tooltip-top"></div><div class="validator-tooltip-main">
                <div id="usernameErrorMessage"></div>
            </div><div class="validator-tooltip-bottom"></div></td></tr>
            </table>
        
            <div id="usernameGood" class="validator-checkmark"></div>
        </div>
        <div class="clear" style="font-size:0;"></div>
        <span class="tip-text">3-20 alphanumeric characters, no spaces. <br />Do not use your real name.</span>
    </div>

    </div>
    <div class="formRow">
    <label class="form-label" for="password1">Password:</label>
    <div class="rightFormColumn">
        <div class="inputColumn">
            <input name="pass" value="" id="Password" class="text-box text-box-large"  TabIndex="7" type="password" onkeyup="Roblox.SignupFormValidator.checkPassword();"/>
        </div>
        <div class="validation">
            <table id="passwordError" class="validator-container">
            <tr><td><div class="validator-tooltip-top"></div><div class="validator-tooltip-main">
                <div id="passwordErrorMessage"></div>
            </div><div class="validator-tooltip-bottom"></div></td></tr>
            </table>
            <div id="passwordGood" class="validator-checkmark"></div>
        </div>
        <div class="clear" style="font-size:0;"></div>
        <span class="tip-text">6-20 characters, minimum of 4 letters & 2 numbers</span>
    </div>
    </div>
    <div class="formRow">
        <label class="form-label" for="password2">Confirm Password:</label>
        <div class="inputColumn">
            <input name="passConfirm" value="" id="PasswordConfirm" class="text-box text-box-large" TabIndex="8" type="password" onkeyup="Roblox.SignupFormValidator.checkPasswordConfirm();"/>
        </div>
        <div class="validation">
            <table id="passwordConfirmError" class="validator-container">
            <tr><td><div class="validator-tooltip-top"></div><div class="validator-tooltip-main">
                <div id="PasswordConfirmMessage"></div>
            </div><div class="validator-tooltip-bottom"></div></td></tr>
            </table>
            <div id="passwordConfirmGood" class="validator-checkmark"></div>
        </div>
    </div>

    <div class="clear" style="font-size:0;"></div>
    
     
    <div class="CreateAccountWrapper" style="text-align:center" >
        <a onclick="return Roblox.SignupFormValidator.ValidateForm();" data-se="SignUpButton" class="btn-large btn-primary" href="javascript:WebForm_DoPostBackWithOptions(new WebForm_PostBackOptions(&quot;ctl00$cphRoblox$ctl00$ctl00&quot;, &quot;&quot;, true, &quot;&quot;, &quot;&quot;, false, true))">
            Sign Up
            <span class="btn-text">
                Sign Up
            </span>
        </a>
    </div>

<script type="text/javascript">
    $(function () {
 
        //<sl:translate>
        Roblox.SignupFormValidator.Resources = {
        doesntMatch : "Doesn't match",
        requiredField : "Required field",
        tooLong : "Too long",
        tooShort : "Too short",
        containsInvalidCharacters : "Contains invalid characters",
        needsFourLetters : "Needs 4 letters",
        needsTwoNumbers : "Needs 2 numbers",
        noSpaces : "No spaces allowed",
        weakKey : "Weak key combination.",
        invalidName : "Can't be your character name",
        alreadyTaken : "Already taken",
        cantBeUsed : "Can't be used",
        password : "password"
        };
        //</sl:translate>
    });
</script>       


</div>
<div class="UpperRightBox divider-bottom">
    <span style="margin-top: 5px;float: left;">Already registered?</span> 
    <a href="/Login/" class="btn-small btn-negative" style="margin-left:5px;">Login<span class="btn-text">Login</span></a>

</div>
<div class="LowerRightBox">
    
    <span>Are you on Facebook? </span>
	
<div id="SplashPageConnect" class="fbSplashPageConnect">
	<a class="facebook-login"  href="/facebook/signin?returnTo=%2Fhome" target="_top" ref="form-facebook">
		<span class="left"></span>
		<span class="middle">Login with Facebook<span>Login with Facebook</span></span>
		<span class="right"></span>
	</a>
</div>
    <div class="Termsandconditions">
    By clicking Sign Up, you agree to our <a id="ctl00_cphRoblox_HyperLinkToS" href="/info/terms-of-service" target="_blank">Terms of Service</a>, <a id="ctl00_cphRoblox_HyperLinkEULA" href="../Info/EULA.htm" target="_blank">Licensing Agreement</a>, and <a id="ctl00_cphRoblox_HyperLinkPrivacy" href="../Info/Privacy.aspx?layout=null" target="_blank">Privacy Policy</a>. We will not share your information with 3rd parties. 
    </div>
    
    <div style="padding-top:3px;">
        <div id="a15b1695-1a5a-49a9-94f0-9cd25ae6c3b2">
    <a href="//privacy.truste.com/privacy-seal/Roblox-Corporation/validation?rid=2428aa2a-f278-4b6d-9095-98c4a2954215" title="TRUSTe Children privacy certification" target="_blank">
        <img style="border: none" src="/images/kids-seal.png" alt="TRUSTe Children privacy certification"/>
    </a>
</div>
    </div>
</div>

</div>


                    <div style="clear:both"></div>
                </div>
            </div>
        </div> 
        </div>
        
            
<?php
require_once($_SERVER["STATIC"]."/footer.php");
?>
<script type="text/javascript"> 
// signup functionality
$("a[data-se='SignUpButton']").click(function() {
    if (Roblox.SignupFormValidator.ValidateForm())
    {
        $('#aspnetForm').submit();
    }
});
</script>


        
        </div></div>
    </div>
    <div id="ChatContainer" style="position:fixed;bottom:0;right:0;z-index:1000;">
        
        
    </div>

    
        
        <script src="https://ssl.google-analytics.com/urchin.js" type="text/javascript"></script>
        <script type="text/javascript">
            _uacct = "UA-486632-1";
            _udn = "roblox.com";
            _uccn = "rbx_campaign";
            _ucmd = "rbx_medium";
            _ucsr = "rbx_source";
            urchinTracker();
            __utmSetVar('Visitor/Anonymous');
            </script>
    

    

<script type="text/javascript">
//<![CDATA[
if(typeof __utmSetVar !== 'undefined'){ __utmSetVar(''); }if(typeof __utmSetVar !== 'undefined'){ __utmSetVar('Roblox_Default_Top_728x90'); }//]]>
</script>
</form>
    
<form id="LoginForm" action = "https://www.roblox.com/login/dologin.aspx" method="post">
<input type="hidden" id="IsSyncUp" name="IsSyncUp" />
<input type="hidden" id="FacebookAssociation" name="FacebookAssociation" />
<input type="hidden" id="SNAccessToken" name="SNAccessToken" />
</form>

    
    
<div id="InstallationInstructions"  class="modalPopup blueAndWhite" style="display:none;overflow:hidden" >
    <a id="CancelButton2" onclick="return Roblox.Client._onCancel();" class="ImageButton closeBtnCircle_35h ABCloseCircle"></a>
    <div style="padding-bottom:10px;text-align:center">
        <br /><br />
    </div>
</div>


<div id="pluginObjDiv" style="height:1px;width:1px;visibility:hidden;position: absolute;top: 0;"></div>
<iframe id="downloadInstallerIFrame" style="visibility:hidden;height:0;width:1px;position:absolute"></iframe>


<script type='text/javascript' src='https://s3.amazonaws.com/js.roblox.com/8bcdddfb9aa61c2e1d92e5b8b5afff52.js'></script>

<script type="text/javascript">
    Roblox.Client._skip = '/install/unsupported.aspx';
    Roblox.Client._CLSID = '';
    Roblox.Client._installHost = '';
    Roblox.Client.ImplementsProxy = false;
    Roblox.Client._silentModeEnabled = false;
    Roblox.Client._bringAppToFrontEnabled = false;

         Roblox.Client._installSuccess = function() { urchinTracker('InstallSuccess'); };

    $(function () {
        Roblox.Client.Resources = {
            //<sl:translate>
            here: "here",
            youNeedTheLatest: "You need Our Plugin for this.  Get the latest version from ",
            plugInInstallationFailed: "Plugin installation failed!",
            errorUpdating: "Error updating: "
            //</sl:translate>
        };
    });

</script>

<div id="PlaceLauncherStatusPanel" style="display:none;width:300px">
    <div class="modalPopup blueAndWhite PlaceLauncherModal" style="min-height: 160px">
        <div id="Spinner" class="Spinner" style="margin:0 1em 1em 0; padding:20px 0;">
            <img src="https://s3.amazonaws.com/images.roblox.com/e998fb4c03e8c2e30792f2f3436e9416.gif" alt="Progress" />
        </div>
        <div id="status" style="min-height:40px;text-align:center;margin:5px 20px">
            <div id="Starting" class="PlaceLauncherStatus MadStatusStarting" style="display:block">
                Starting Roblox...
            </div>
            <div id="Waiting" class="PlaceLauncherStatus MadStatusField">Connecting to Players...</div>
            <div id="StatusBackBuffer" class="PlaceLauncherStatus PlaceLauncherStatusBackBuffer MadStatusBackBuffer"></div>
        </div>
        <div style="text-align:center;margin-top:1em">
            <input type="button" class="Button CancelPlaceLauncherButton translate" value="Cancel" />
        </div>
    </div>
</div>


<script type='text/javascript' src='https://s3.amazonaws.com/js.roblox.com/507606ba77acf2ff29dd3ec7cb668f06.js'></script>

    <div id="videoPrerollPanel" style="display:none">
        <div id="videoPrerollTitleDiv">
            Gameplay sponsored by:
        </div>
        <div id="videoPrerollMainDiv"></div>
        <div id="videoPrerollCompanionAd"></div>
        <div id="videoPrerollLoadingDiv">
            Loading <span id="videoPrerollLoadingPercent">0%</span> - <span id="videoPrerollMadStatus" class="MadStatusField">Starting game...</span><span id="videoPrerollMadStatusBackBuffer" class="MadStatusBackBuffer"></span>
            <div id="videoPrerollLoadingBar">
                <div id="videoPrerollLoadingBarCompleted">
                </div>
            </div>
        </div>
        <div id="videoPrerollJoinBC">
            <span>Get more with Builders Club!</span>
            <a href="/Upgrades/BuildersClubMemberships.aspx?ref=vpr" target="_blank" id="videoPrerollJoinBCButton"></a>
        </div>
    </div>
    <script type="text/javascript">
        Roblox.VideoPreRoll.showVideoPreRoll = false;
        Roblox.VideoPreRoll.loadingBarMaxTime = 30000;
        Roblox.VideoPreRoll.videoOptions.key = "robloxcorporation";
        Roblox.VideoPreRoll.videoOptions.categories = "NonBC,IsLoggedIn,AgeUnknown,GenderUnknown";
             Roblox.VideoPreRoll.videoOptions.id = "games";
        Roblox.VideoPreRoll.videoLoadingTimeout = 11000;
        Roblox.VideoPreRoll.videoPlayingTimeout = 23000;
        Roblox.VideoPreRoll.videoLogNote = "NotWindows";
        Roblox.VideoPreRoll.logsEnabled = true;
        Roblox.VideoPreRoll.excludedPlaceIds = "32373412";
            
                Roblox.VideoPreRoll.specificAdOnPlacePageEnabled = true;
                Roblox.VideoPreRoll.specificAdOnPlacePageId = 96623001;
                Roblox.VideoPreRoll.specificAdOnPlacePageCategory = "stooges";
            
            
                Roblox.VideoPreRoll.specificAdOnPlacePage2Enabled = true;
                Roblox.VideoPreRoll.specificAdOnPlacePage2Id = 122911678;
                Roblox.VideoPreRoll.specificAdOnPlacePage2Category = "lego";
            
        $(Roblox.VideoPreRoll.checkEligibility);
    </script>

<div id="GuestModePrompt_BoyGirl" class="Revised GuestModePromptModal" style="display:none;">
    <div class="simplemodal-close">
        <a class="ImageButton closeBtnCircle_20h" style="cursor: pointer; margin-left:455px;top:7px; position:absolute;"></a>
    </div>
    <div class="Title">
        Choose Your Character
    </div>
    <div style="min-height: 275px; background-color: white;">
        <div style="clear:both; height:25px;"></div>

        <div style="text-align: center;">
            <div class="VisitButtonsGuestCharacter VisitButtonBoyGuest" style="float:left; margin-left:45px;"></div>
            <div class="VisitButtonsGuestCharacter VisitButtonGirlGuest" style="float:right; margin-right:45px;"></div>
        </div>
        <div style="clear:both; height:25px;"></div>
        <div class="RevisedFooter" >
            <div style="width:200px;margin:10px auto 0 auto;">
                <a href="#" onclick="redirectPlaceLauncherToRegister(); return false;"><div class="RevisedCharacterSelectSignup"></div></a>
                <a class="HaveAccount" href="#" onclick="redirectPlaceLauncherToLogin();return false;">I have an account</a>
            </div>
        </div>
    </div>
</div>
<script type="text/javascript">
    function checkRobloxInstall() {
                 window.location= '/install/unsupported.aspx'; return false;
    }
        if (typeof MadStatus === "undefined") {
            MadStatus = {};
        }

        MadStatus.Resources = {
            //<sl:translate>
            accelerating: "Accelerating",
			aggregating: "Aggregating",
			allocating: "Allocating",
            acquiring: "Acquiring",
			automating: "Automating",
			backtracing: "Backtracing",
			bloxxing: "Bloxxing",
			bootstrapping: "Bootstrapping",
			calibrating: "Calibrating",
			correlating: "Correlating",
			denoobing: "De-noobing",
			deionizing: "De-ionizing",
			deriving: "Deriving",
            energizing: "Energizing",
			filtering: "Filtering",
			generating: "Generating",
			indexing: "Indexing",
			loading: "Loading",
			noobing: "Noobing",
			optimizing: "Optimizing",
			oxidizing: "Oxidizing",
			queueing: "Queueing",
			parsing: "Parsing",
			processing: "Processing",
			rasterizing: "Rasterizing",
			reading: "Reading",
			registering: "Registering",
			rerouting: "Re-routing",
			resolving: "Resolving",
			sampling: "Sampling",
			updating: "Updating",
			writing: "Writing",
            blox: "Blox",
			countzero: "Count Zero",
			cylon: "Cylon",
			data: "Data",
			ectoplasm: "Ectoplasm",
			encryption: "Encryption",
			event: "Event",
			farnsworth: "Farnsworth",
			bebop: "Bebop",
			fluxcapacitor: "Flux Capacitor",
			fusion: "Fusion",
			game: "Game",
			gibson: "Gibson",
			host: "Host",
			mainframe: "Mainframe",
			metaverse: "Metaverse",
			nerfherder: "Nerf Herder",
			neutron: "Neutron",
			noob: "Noob",
			photon: "Photon",
			profile: "Profile",
			script: "Script",
			skynet: "Skynet",
			tardis: "TARDIS",
			virtual: "Virtual",
            analogs: "Analogs",
			blocks: "Blocks",
			cannon: "Cannon",
			channels: "Channels",
			core: "Core",
			database: "Database",
			dimensions: "Dimensions",
			directives: "Directives",
			engine: "Engine",
			files: "Files",
			gear: "Gear",
			index: "Index",
			layer: "Layer",
			matrix: "Matrix",
			paradox: "Paradox",
			parameters: "Parameters",
			parsecs: "Parsecs",
			pipeline: "Pipeline",
			players: "Players",
			ports: "Ports",
			protocols: "Protocols",
			reactors: "Reactors",
			sphere: "Sphere",
			spooler: "Spooler",
			stream: "Stream",
			switches: "Switches",
			table: "Table",
			targets: "Targets",
			throttle: "Throttle",
			tokens: "Tokens",
			torpedoes: "Torpedoes",
			tubes: "Tubes"
            //</sl:translate>
        };
</script>

<script type='text/javascript' src='https://s3.amazonaws.com/js.roblox.com/5225bbbcf23c8bfd5e9425ee18202d88.js'></script>

<script type="text/javascript">
    var Roblox = Roblox || {};
    Roblox.UpsellAdModal = Roblox.UpsellAdModal || {};

    Roblox.UpsellAdModal.Resources = {
        //<sl:translate>
        title: "Remove Ads Like This",
        body: "Builders Club members do not see external ads like these.",
        accept: "Upgrade Now",
        decline: "No, thanks"
        //</sl:translate>
    };
</script>  

<div class="ConfirmationModal modalPopup unifiedModal smallModal" data-modal-handle="confirmation" style="display:none;">
    <a class="genericmodal-close ImageButton closeBtnCircle_20h"></a>
    <div class="Title"></div>
    <div class="GenericModalBody">
        <div class="TopBody">
            <div class="ImageContainer roblox-item-image"  data-image-size="small" data-no-overlays data-no-click>
                <img class="GenericModalImage" alt="generic image" />
            </div>
            <div class="Message"></div>
        </div>
        <div class="ConfirmationModalButtonContainer">
            <a href roblox-confirm-btn><span></span></a>
            <a href roblox-decline-btn><span></span></a>
        </div>
        <div class="ConfirmationModalFooter">
        
        </div>  
    </div>   
    <script type="text/javascript">
        //<sl:translate>
        Roblox.GenericConfirmation.Resources = { yes: "Yes", No: "No" }
        //</sl:translate>
    </script>
</div>


    
</body>                
</html>
