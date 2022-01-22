<?php
// ROBLOSIUM 2013
require_once($_SERVER["STATIC"]."/settings.php");
require_once($_SERVER["STATIC"]."/package_compiler.php");
AddCSS(CSS_DEFAULT_PACKAGE);
AddJS(PackageCompiler::CompilePackage("iframelogin", ["/js/jquery.ba-postmessage.min.js", "/js/iFrameLogin.js"], null));
require_once($_SERVER["STATIC"]."/simple_head.php");
?>
<body style="background: #E1E1E1;" data-parent-url="<?php echo isset($_GET["parentUrl"]) ? $_GET["parentUrl"] : urlencode("http://".$_SERVER['HTTP_HOST']."/Login/iFrameLogin.aspx"); ?>" data-captchaon="false" data-clientipaddress="207.241.229.236" data-redirecttohttp ="true">
 <div id="NotLoggedInPanel">
	<form name="FacebookLoginForm" method="post" action="/Login/iFrameLogin.aspx?loginRedirect=True&amp;parentUrl=http%253a%252f%252fwww.roblox.com%252fForum%252fShowForum.aspx%253fForumID%253d18" id="FacebookLoginForm">
<div>
<input type="hidden" name="__VIEWSTATE" id="__VIEWSTATE" value="/wEPDwUKMjA5OTM1NzI4OQ9kFgICAQ9kFgICARAWAh4GYWN0aW9uBYYBL0xvZ2luL2lGcmFtZUxvZ2luLmFzcHg/bG9naW5SZWRpcmVjdD1UcnVlJnBhcmVudFVybD1odHRwJTI1M2ElMjUyZiUyNTJmd3d3LnJvYmxveC5jb20lMjUyZkZvcnVtJTI1MmZTaG93Rm9ydW0uYXNweCUyNTNmRm9ydW1JRCUyNTNkMThkZGS+ClvCUNqvKD9qB/zNrYkJWVsi9Q==" />
</div>


<script src="/ScriptResource.axd?d=YtUw4NG9Lcj6QYFANjy1P7da-Ue_ZSOQmkKyeRwBH6qnRklRAHYgi5587nnexjeo4zYZqrn5ZHlU4nNhi2MDBNkqJNmrejnNfiiJYqkb9t_y9RTL0TIHBgSH2qgbsawPlRWTGYJxkohsyFBXaHpfsfrAAws9LKE2xbRkp9l0mdRFgehhjDZTNJ8cKCOKoSnGK6BopKqF_9HHB_hDWaWyjkSgC0m6WuXllE3zptrcgyciYJqjokumdsPcANYMSMr_2inSQ8E39PCNbFor2zKAit1rRoRKlbiSIErmXsP1_MVjvukp0" type="text/javascript"></script>
<script src="../Services/Secure/LoginService.js" type="text/javascript"></script>
<div>

	<input type="hidden" name="__EVENTVALIDATION" id="__EVENTVALIDATION" value="/wEWAwKv1bHEBwKvruq2CALSxeCRD0GtFA8wmVlykiEX6ZWeGkRSSPAb" />
</div>
        
        <div id="LoginForm">
            <div class="newLogin" id="newLoginContainer">                
                <div class="UserNameDiv">
                    <label class="form-label"  for="UserName">Username</label>
                    <br /><input name="UserName" type="text" id="UserName" class="text-box text-box-medium LoginFormInput" name="UserName" style="width: 144px;" />
                </div>
                <div class="PasswordDiv">
                    <label class="form-label" for="Password">Password</label>
                    <br /><input name="Password" type="password" id="Password" class="text-box text-box-medium LoginFormInput" style="width:152px;" />
                </div>
				<div style="clear:both"></div>
                <div id="iFrameCaptchaControl">
                    
                </div>
				<div id="ErrorMessage" style="color:Red"></div>
                <div class="LoginFormFieldSet">
					<span id="NotAMemberLink" class="footnote" style="position: absolute;top: 50%;margin-top: -8px;">
						Not a member?
						<a href="/Login/Signup.aspx" target="_top">Sign up!</a>
					</span>
                    <span id="ForgotPasswordLink" class="footnote" style="display: none;position: absolute;top: 50%;margin-top: -8px;">
					    <a href="ResetPasswordRequest.aspx" target="_top">Forgot your password?</a>
                    </span>
                    <a class="btn-small btn-neutral" id="LoginButton" tabindex="4" style="float:right; margin-top:8px;">Login</a>
					
					<span id="LoggingInStatus" style="display: none; position: absolute; right: 8px;margin-top: -11px;top: 50%;">
						<img src="https://s3.amazonaws.com/images.roblox.com/6ec6fa292c1dcdb130dcf316ac050719.gif" style="margin-right: 5px;width: 20px;height: 20px;" alt="" />
						<span style="top: -5px;position: absolute;position: relative;">Logging in...</span>
					</span>
                </div>
				<div id="SocialNetworkSignIn">
					<div id="fb-root"></div>
					 
					<div id="facebookSignIn">
						<a class="facebook-login"  href="/Facebook/SignIn?returnTo=http%253a%252f%252fwww.roblox.com%252fForum%252fShowForum.aspx%253fForumID%253d18" target="_top" ref="form-facebook">
  	                        <span class="left"></span>
                            <span class="middle">Login with Facebook<span>Login with Facebook</span></span>
                            <span class="right"></span>
	                    </a>
					</div>
					
				</div>
            </div>
        </div>
    </form>
  </div>
	<script type="text/javascript">
	    $(function () {
	        Roblox.iFrameLogin.Resources = {
	            //<sl:translate>
	            invalidCaptchaEntry: 'Invalid Captcha entry'
	            //</sl:translate>
	        };
	        Roblox.iFrameLogin.init();
	    });
	</script>
</body>
</html>