<?php
// ROBLOSIUM 2013
require_once($_SERVER["STATIC"]."/settings.php");
require_once($_SERVER["STATIC"]."/package_compiler.php");
require_once($_SERVER["STATIC"]."/authentication.php");
require_once($_SERVER["STATIC"]."/profanity_filter.php");
if ($userAuth === false)
	die(header("Location: /NewLogin"));
$blurb = $userAuth->GetUserInfo("bio");
if (isset($_GET["action"]))
{
	switch(strtolower($_GET["action"]))
	{
		case "update":
		{
			// update blurb
			if ($blurb != $_POST["PersonalBlurb"] && strlen($_POST["PersonalBlurb"]) <= 1000)
			{
				$blurb = ProfanityFilter::Censor($_POST["PersonalBlurb"]);
				$stmt = $conn->prepare("UPDATE users SET bio=:blurb WHERE id=:id");
				$stmt->bindParam(":blurb", $blurb);
				$stmt->bindValue(":id", $userAuth->GetUserInfo("id"));
				$stmt->execute();
			}
			die(header("Location: /My/Account.aspx?"));
			break;
		}
	}
}
AddCSS(CSS_DEFAULT_PACKAGE);
AddCSS(PackageCompiler::CompilePackage("page", ["/CSS/Pages/CashOut/CashOut.css", "/CSS/Pages/Accounts/AccountMVC.css", "/CSS/PartialViews/Navigation.css"], null));
AddJS(JS_DEFAULT_PACKAGE);
AddJS(PackageCompiler::CompilePackage("page", ["/js/jquery.validate.js", "/js/jquery.validate.unobtrusive.js", "/js/GenericModal.js", "/js/SignupFormValidator.js", "/js/My/AccountMVC.js", "/js/AddEmail.js", "/js/SuperSafePrivacyIndicator.js", "/js/GenericConfirmation.js"], null));
$over13 = $userAuth->IsOver13();
$_PS->SubmenuEnabled = true;
$_PS->ASPNetFormTagEnabled = false;
$birthday = explode("/", $userAuth->GetUserInfo("birthday"));
require_once($_SERVER["STATIC"]."/header.php");
?>
<div id="Body" style="width:970px">
   <div id="AccountPageContainer" data-missingparentemail="false" data-userabove13="<?php echo $over13 ? "true" : "false"; ?>" data-currentdateyear="<?php echo date('Y'); ?>" data-currentdatemonth="<?php echo date('n'); ?>" data-currentdateday="<?php echo date('j'); ?>">
      <div id="AccountPageLeft" class="divider-right">
	     <form action="/my/account.aspx/update" id="UpdateAccountForm" method="post">
         <h3 style="
            ">Billing Settings</h3>
         <p style="
            margin-top: 4px;
            ">For billing and payment questions: <a href="mailto:info@roblox.com">info@roblox.com</a></p>
         <div class="tab-content active" id="settings_tab">
            <div id="AccountSettings" class="settings-section">
               <h3 style="margin-bottom: 2px;">Account Settings</h3>
               <div class="SettingSubTitle" id="UsernameSetting" data-robux-remaining="0" data-email-verified="True" data-alerturl="https://s3.amazonaws.com/images.roblox.com/cbb24e0c0f1fb97381a065bd1e056fcb.png" data-change-username-verifyurl="/account/username/verifyupdate" data-change-username-url="/account/username/update" data-buy-robux-url="/upgrades/robux">
                  <span class="settingLabel form-label">Username:</span> <span id="username"><?php echo $userAuth->GetUserInfo("username"); ?></span>
                  <a class="btn-small btn-primary" id="changeUsername" style="
                     margin-left: 16px;
                     ">Change My Username</a>
               </div>
               <div id="BirthdaySetting" class="SettingSubTitle">
                  <span class="settingLabel form-label">Birthday:</span>
                  <div id="<?php echo $over13 ? "Above" : "Under"; ?>13Birthday" style="
                     display: inline;
                     ">
                     <select class="accountPageChangeMonitor form-select" data-val="true" data-val-number="The field BirthMonth must be a number." data-val-range="The field BirthMonth must be between 1 and 12." data-val-range-max="12" data-val-range-min="1" data-val-required="The BirthMonth field is required." <?php echo !$over13 ? 'disabled="disabled"' : ""; ?> id="MonthDropDown" name="BirthMonth">
                        <?php
                        foreach(range(1,12) as $month)
							echo '<option '.($birthday[0] == $month ? 'selected="selected" ' : '').'value="'.$month.'">'.gmdate("M", mktime(0, 0, 0, $month, 10)).'</option>';
						?>
                     </select>
                     <select class="accountPageChangeMonitor form-select" data-val="true" data-val-number="The field BirthDay must be a number." data-val-range="The field BirthDay must be between 1 and 31." data-val-range-max="31" data-val-range-min="1" data-val-required="The BirthDay field is required." <?php echo !$over13 ? 'disabled="disabled"' : ""; ?> id="DayDropDown" name="BirthDay">
                        <?php
                        foreach(range(1,31) as $day)
							echo '<option '.($birthday[1] == $day ? 'selected="selected" ' : '').'value="'.$day.'">'.$day.'</option>';
						?>
                     </select>
                     <select class="accountPageChangeMonitor form-select" data-val="true" data-val-number="The field BirthYear must be a number." data-val-required="The BirthYear field is required." <?php echo !$over13 ? 'disabled="disabled"' : ""; ?> id="YearDropDown" name="BirthYear">
                        <?php
                        foreach(range(date("Y"), 1910) as $year)
							echo '<option '.($birthday[2] == $year ? 'selected="selected" ' : '').'value="'.$year.'">'.$year.'</option>';
						?>
                     </select>
                     <input id="BirthMonth" name="BirthMonth" type="hidden" value="<?php echo $birthday[0]; ?>">
                     <input id="BirthDay" name="BirthDay" type="hidden" value="<?php echo $birthday[1]; ?>">
                     <input id="BirthYear" name="BirthYear" type="hidden" value="<?php echo $birthday[2]; ?>">
					 <?php if (!$over13) { ?>
                     <span>
                     <a id="AskParentToVerifyAgeLink" class="btn-control btn-control-small">
                     Ask Parent To Change</a> 
                     </span>
					 <?php } ?>
                  </div>
               </div>
               <div id="GenderSetting" class="SettingSubTitle">
                  <span class="settingLabel form-label">Gender:</span>
                  <div id="GenderControl" style="
                     display: inline;
                     ">
                     <div id="GenderSelectControl" class="accountPageChangeMonitor" style="
                        display: inline;
                        ">
                        <label class="radio-selection">
                        <input <?php if(@$userAuth->getUserInfo("gender") == "Male") { ?>checked="checked"<?php } ?> data-val="true" data-val-required="The Gender field is required." id="Gender_2" name="Gender" type="radio" value="2"><span for="Gender_2">Male</span></label><label class="radio-selection">
                        <input <?php if(@$userAuth->getUserInfo("gender") == "Female") { ?>checked="checked"<?php } ?> id="Gender_3" name="Gender" type="radio" value="3"><span for="Gender_3">Female</span></label>
                        <span class="field-validation-valid" data-valmsg-for="Gender" data-valmsg-replace="true"></span>
                     </div>
                  </div>
               </div>
               <div id="PasswordSetting" class="SettingSubTitle">
                  <span class="settingLabel form-label">Password:</span> <span id="securePassword">*********</span>
                  <a id="changePassLink" class="changePassWord btn-control btn-control-small" href="/Login/ChangePassword.aspx">
                  Change Password</a>
               </div>
               <div id="EmailAddressSetting" class="SettingSubTitle">
                  <span id="emailAddressLabel" class="settingLabel form-label">Email address:</span>
                      <div id="emailBlock" style="
                  float: none!important;
                  display: inline;
                  ">
                          <span id="UserEmail">*******@gmail.com</span>
                              <span id="EmailVerificationStatus" class="verifiedEmail"></span>
							<?php if (!$over13) { ?>
                              <div id="Under13Email">
                                  <div>
                                      To update or add your parent's email address, please have your parent<br>
                                      contact our Customer Service Department at <span class="SL_swap" id="CsEmailLink"><a href="mailto:info@roblox.com">info@roblox.com</a></span>
                                  </div>
                              </div>
							<?php } else { ?>
                              <a id="UpdateEmail" class="btn-control btn-control-small">Change Email</a> 
							<?php } ?>
                                          
                              <div id="NewsletterConfirm">
                                  <input checked="checked" class="accountPageChangeMonitor" data-val="true" data-val-required="The ReceiveNewsletter field is required." id="chkNewsletter" name="ReceiveNewsletter" type="checkbox" value="true"><input name="ReceiveNewsletter" type="hidden" value="false">
                                  <span class="field-validation-valid" data-valmsg-for="ReceiveNewsletter" data-valmsg-replace="true"></span>
                                  <label id="lblNewsletter" class="text" for="chkNewsletter">
                                      I want to receive newsletters and updates from ROBLOX at this email address!</label>
                              </div>
                  
                      </div>
                  
                  </div>
               <div id="PersonalBlurbSetting" class="SettingSubTitle">
                  <span class="settingLabel form-label" style="
                     float: left;
                     ">Personal blurb:</span>
                  <div id="BlurbDesc">
                     <textarea class="roblox-blurb-default-text accountPageChangeMonitor text" cols="20" data-val="true" data-val-length="The field PersonalBlurb must be a string with a maximum length of 1000." data-val-length-max="1000" id="blurbText" name="PersonalBlurb" rows="2" title="Describe yourself here" style="width: 498px;height: 88px;"><?php echo htmlspecialchars($blurb); ?></textarea>
                     <span class="field-validation-valid" data-valmsg-for="PersonalBlurb" data-valmsg-replace="true"></span>            
                     <br>
                     <div id="blurbSubtext" class="footnote">
                        Do not provide any details that can be used to identify you outside ROBLOX. 
                        <span class="footnote"><br>(1000 character limit)</span>
                     </div>
                  </div>
               </div>
               <div id="LanguageTypeSettings" class="SettingSubTitle">
                  <span class="settingLabel form-label">Language:</span>
                  <select class="accountPageChangeMonitor form-select" data-val="true" data-val-number="The field LanguageId must be a number." data-val-required="The LanguageId field is required." id="LanguageList" name="LanguageId">
                     <option selected="selected" value="1">English</option>
                     <option value="3">Deutsch</option>
                  </select>
                  <span class="field-validation-valid" data-valmsg-for="LanguageId" data-valmsg-replace="true"></span>
               </div>
               <div id="CountryTypeSettings" class="SettingSubTitle">
                  <span class="settingLabel form-label">Country:</span>
                  <select class="accountPageChangeMonitor form-select" data-val="true" data-val-number="The field CountryId must be a number." data-val-required="The CountryId field is required." id="CountryList" name="CountryId">
                     <option selected="selected" value="0">None</option>
                     <option value="9">Canada</option>
                     <option value="4">France</option>
                     <option value="2">Germany</option>
                     <option value="7">Ireland</option>
                     <option value="6">Italy</option>
                     <option value="3">Netherlands</option>
                     <option value="8">Portugal</option>
                     <option value="5">Spain</option>
                     <option value="1">United States</option>
                  </select>
                  <span class="field-validation-valid" data-valmsg-for="CountryId" data-valmsg-replace="true"></span>
               </div>
            </div>
            <div id="AddEmailScreenModal" class="PurchaseModal simplemodal-data" data-uid="<?php echo $userAuth->GetUserInfo("id"); ?>" data-userip="<?php echo $_SERVER['REMOTE_ADDR']; ?>">
               <div id="CloseAddEmailScreen" class="simplemodal-close">
                  <a id="closeEmailModal" runat="server" class="ImageButton closeBtnCircle_20h"></a>
               </div>
               <div id="changeEmailTitle" class="titleBar">
                  Change Email Address
               </div>
               <div id="updateEmailBody">
                  <div id="AddEmailDialog">
                     <br>
                     <div id="SubmitEmailButton">
                        <a id="SubmitInfoButton" class="btn-medium btn-neutral btn-disabled-neutral">Update<span class="btn-text">Update</span></a> <a id="CancelInfoButton" class="btn-cancel-m btn-negative btn-medium">Cancel<span class="btn-text">Cancel</span></a>
                     </div>
                  </div>
                  <div id="ConfirmationDialog">
                     <div id="ConfirmationDialogInner">
                        An email has been sent for verification.
                     </div>
                     <a href="#" id="updateEmailOK" class="ImageButton btn_blue_ok_l"></a>
                  </div>
               </div>
            </div>
         </div>
         <div class="tab-content" id="privacy_tab">
            <div id="PrivacySettings" class="settings-section">
               <div id="ChatSetting" class="SettingSubTitle">
                  <span class="form-label priv-label">Who can chat with me:</span>
                  <span class="InlineSuperSafeDiv">
                     <select class="accountPageChangeMonitor form-select" id="ChatOptions" name="ChatVisibilityPrivacy">
                        <option value="All">All Users</option>
                        <option value="TopFriends">Best Friends</option>
                        <option selected="selected" value="Friends">Friends</option>
                        <option value="Noone">No One</option>
                        <option value="Disabled">Off</option>
                     </select>
                     <span class="field-validation-valid" data-valmsg-for="ChatVisibilityPrivacy" data-valmsg-replace="true"></span>        
                  </span>
               </div>
               <div id="PartySetting" class="SettingSubTitle">
                  <span class="form-label priv-label">Who can invite me to parties:</span> 
                  <span class="InlineSuperSafeDiv">
                     <select class="accountPageChangeMonitor form-select" id="PatryList" name="PartyInvitePrivacy">
                        <option value="All">All Users</option>
                        <option value="TopFriends">Best Friends</option>
                        <option selected="selected" value="Friends">Friends</option>
                        <option value="Noone">No One</option>
                        <option value="Disabled">Off</option>
                     </select>
                     <span class="field-validation-valid" data-valmsg-for="PartyInvitePrivacy" data-valmsg-replace="true"></span>        
                  </span>
               </div>
               <div id="PrivateMessageSetting" class="SettingSubTitle">
                  <span class="form-label priv-label">Who can send me private messages:</span>
                  <span class="InlineSuperSafeDiv">
                     <select class="accountPageChangeMonitor form-select" id="MessageList" name="PrivateMessagePrivacy">
                        <option value="All">All Users</option>
                        <option value="TopFriends">Best Friends</option>
                        <option selected="selected" value="Friends">Friends</option>
                        <option value="Noone">No One</option>
                     </select>
                     <span class="field-validation-valid" data-valmsg-for="PrivateMessagePrivacy" data-valmsg-replace="true"></span>        
                  </span>
               </div>
               <div id="FollowSetting" class="SettingSubTitle">
                  <span class="form-label priv-label">Who can follow me:</span>
                  <span class="InlineSuperSafeDiv">
                  <span id="SuperPanel" class="SuperSafePanel" data-js-supersafe-specialstyle="False">
                  <img class="SuperSafePrivacyModeImg" data-js-supersafeprivacymode="" src="https://s3.amazonaws.com/images.roblox.com/1e9979bd2ad8c88ee8d1250900ca6358.png" alt="">
                  </span>
                  </span>
                  <select class="accountPageChangeMonitor form-select" data-js-supersafeprivacymode="" disabled="disabled" id="FollowList" name="FollowMePrivacy">
                     <option selected="selected" value="All">All Users</option>
                     <option value="TopFriends">Best Friends</option>
                     <option value="Friends">Friends</option>
                     <option value="Noone">No One</option>
                  </select>
               </div>
               <div style="clear: both;">
                  <a class="btn-medium btn-neutral updateSettingsBtn btn-update btn-neutral btn-medium" id="UpdateSettingsBtn2">Update</a>
               </div>
            </div>
         </div>
      </div>
	  </form>
      <div id="AccountPageRight">
         <div id="UpgradeAccount" style="margin-left: 10px">
            <h3 style="margin: 10px 0;">
               Upgrade Account
            </h3>
            <div id="buyRobux" class="upgrade-account-button">
               <a href="/upgrades/robux.aspx" class="buyRobux btn-medium btn-primary">Buy Robux
               <span class="btn-text">Buy Robux</span></a>
            </div>
            <div id="JoinBuildersClub" class="upgrade-account-button">
               <a href="/Upgrades/BuildersClubMemberships.aspx" class="buyRobux btn-medium btn-primary">
               Join Builders Club</a>
            </div>
            <div id="AdvertisementRight">
               <div style="margin-top: 10px">
                  <iframe allowtransparency="true" frameborder="0" height="270" scrolling="no" src="/userads/2" width="300" data-js-adtype="iframead"></iframe>
               </div>
            </div>
         </div>
         <div style="clear: both">
         </div>
      </div>
   </div>
   <div class="GenericModal modalPopup unifiedModal smallModal" style="display:none;">
      <div class="Title"></div>
      <div class="GenericModalBody">
         <div>
            <div class="ImageContainer">
               <img class="GenericModalImage" alt="generic image">
            </div>
            <div class="Message"></div>
         </div>
         <div class="clear"></div>
         <div id="GenericModalButtonContainer" class="GenericModalButtonContainer">
            <a class="ImageButton btn-neutral btn-large roblox-ok">OK<span class="btn-text">OK</span></a>
         </div>
      </div>
   </div>
   <style type="text/css">
      #Body  /*Needs to be on the Page to override MasterPage #Body */
      {
      width:970px;
      padding:10px;
      }
   </style>
   <script type="text/javascript">
      $(function () {
          if (typeof Roblox === "undefined") {
              Roblox = {};
          }
          if (typeof Roblox.ChangeUsername === "undefined") {
              Roblox.ChangeUsername = {};
          }
          //<sl:translate>
          Roblox.AccountResources = {
              addParentEmailText: "Add Parent Email",
              missingParentBodyText: "To update or add your parent\'s email address, please have your parent contact our Customer Service Department at info@roblox.com.",
              okText: "OK",
              cancelText: "Cancel",
              facebookConnectText: "Facebook Connect",
              facebookConnectBodyText: "Your Facebook account has been disconnected."
          };
          Roblox.SignupFormValidator.Resources = {
              doesntMatch: "Doesn't match",
              requiredField: "Required field",
              tooLong: "Too long",
              tooShort: "Too short",
              containsInvalidCharacters: "Contains invalid characters",
              needsFourLetters: "Needs 4 letters",
              needsTwoNumbers: "Needs 2 numbers",
              noSpaces: "No spaces allowed",
              weakKey: "Weak key combination.",
              invalidName: "Can't be your character name",
              alreadyTaken: "Already taken",
              cantBeUsed: "Can't be used",
              password: "password"
          };
          Roblox.ChangeUsername.Resources = {
              insufficientFundsTitle: "Insufficient Funds",
              insufficientFundsText: "You need {0} more to change your username.",
              insufficientFundsAcceptText: "Buy Robux",
              insufficientFundsFooter: "or " + "<a href='/My/Money.aspx?tab=TradeCurrency' style='font-weight:bold'>Trade Currency</a>",
              emailVerifiedTitle: "Verified Email Required",
              emailVerifiedMessage: "You must verify your email before you can change your username.",
              verify: "Verify",
              changeUsernameTitle: "Change Username",
              proceedToBuyText: "Buy for R$ 1,000",
              confirmUsernameChangeText: 'Would you like to change your username to {0} for <span class="robux notranslate">1,000</span>?',
              passwordRequiredText: "Please enter your current password.",
              unknownErrorText: "An unknown error occurred.",
              newUsernameFieldLabel: "Desired Username:",
              newUsernameHintText: "3-20 letters & numbers",
              passwordLabel: "Password:",
              warningText: "IMPORTANT: <ul><li>Original account creation date and forum post count will carry over to your new username.</li><li>Previous forum posts will appear under your old username and will NOT carry over to your new username.</li></ul>",
              processingText: "Processing...",
              processIndicatorImageUrl: "https://s3.amazonaws.com/images.roblox.com/ec4e85b0c4396cf753a06fade0a8d8af.gif",
              confirmUsernameChangeFooterText: "Your balance after this transaction will be {0}.",
              confirmUsernameChangeAccept: "Buy Now",
              usernameChangedText: "Congratulations, {0}! Your username has been changed.",
              usernameChangeErrorTitle: "Username Change Error",
              usernameChangeErrorText: "There was an error changing your username: "
          };
      
          Roblox.ChangeUsername.initializeStrings();
          Roblox.ChangeUsername.initializeChangeUsernameButton();
          //</sl:translate>
              if ($("#FacebookDisconnectModal").length > 0) {
          
          Roblox.GenericConfirmation.open({
                  titleText: Roblox.AccountResources.facebookConnectText,
                  bodyContent: Roblox.AccountResources.facebookConnectBodyText,
                  acceptText: Roblox.AccountResources.okText,
                  declineColor: Roblox.GenericConfirmation.none,
                  dismissable: false
              });
      
          }
      });
   </script>
   <div style="clear:both"></div>
</div>
<?php
require_once($_SERVER["STATIC"]."/footer.php");
?>
