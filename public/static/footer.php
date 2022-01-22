<?php
// ROBLOSIUM 2013
require_once($_SERVER["STATIC"]."/settings.php");
require_once($_SERVER["STATIC"]."/authentication.php");
?>
<div id="Footer" class="LanguageRedesign">
    <div class="FooterNav">
        <a href="/info/Privacy.aspx"><b>Privacy Policy</b></a>
        &nbsp;|&nbsp; 
        <a href="http://corp.roblox.com/advertise-on-roblox" class="roblox-interstitial">Advertise with Us</a>
        &nbsp;|&nbsp; 
        <a href="http://corp.roblox.com/roblox-press" class="roblox-interstitial">Press</a>
        &nbsp;|&nbsp; 
        <a href="http://corp.roblox.com/contact-us" class="roblox-interstitial">Contact Us</a>
        &nbsp;|&nbsp;
        <a href="http://corp.roblox.com/" class="roblox-interstitial">About Us</a>
        &nbsp;|&nbsp;
        <a href="http://blog.roblox.com" class="roblox-interstitial">Blog</a>
        &nbsp;|&nbsp;
        <a href="http://corp.roblox.com/jobs" class="roblox-interstitial">Jobs</a>
        &nbsp;|&nbsp;
        <a href="/Parents.aspx">Parents</a>
        &nbsp;|&nbsp;
        <a href="http://shop.roblox.com/" class="roblox-interstitial">Shop</a>
            <span class="LanguageOptionElement">&nbsp;|&nbsp;</span> 
            <span runat="server" NavigateUrl="/Parents.aspx" ref="footer-parents" class="LanguageOptionElement LanguageTrigger"  drop-down-nav-button="LanguageTrigger">English&nbsp;<span class="FooterArrow">▼</span>
                    <div class="dropuplanguagecontainer" style="display:none;" drop-down-nav-container="LanguageTrigger">
                        <div class="dropdownmainnav" style="z-index:1023">
                                <a href="/UserLanguage/LanguageRedirect?languageCode=de&amp;relativePath=%2fgames"class="LanguageOption js-lang" data-js-langcode="de"><span class="notranslate">Deutsch</span>&nbsp;(German) </a>
                            </div>  
                    </div>
            </span> 
    </div>
    <div class="FooterNav">
        <div id="SEOGenreLinks" class="SEOGenreLinks">
                  <a href="/all-games">All Games</a> 
                      <span>|</span>
                  <a href="/building-games">Building</a> 
                      <span>|</span>
                  <a href="/horror-games">Horror</a> 
                      <span>|</span>
                  <a href="/town-and-city-games">Town and City</a> 
                      <span>|</span>
                  <a href="/military-games">Military</a> 
                      <span>|</span>
                  <a href="/comedy-games">Comedy</a> 
                      <span>|</span>
                  <a href="/medieval-games">Medieval</a> 
                      <span>|</span>
                  <a href="/adventure-games">Adventure</a> 
                      <span>|</span>
                  <a href="/sci-fi-games">Sci-Fi</a> 
                      <span>|</span>
                  <a href="/naval-games">Naval</a> 
                      <span>|</span>
                  <a href="/fps-games">FPS</a> 
                      <span>|</span>
                  <a href="/rpg-games">RPG</a> 
                      <span>|</span>
                  <a href="/sports-games">Sports</a> 
                      <span>|</span>
                  <a href="/fighting-games">Fighting</a> 
                      <span>|</span>
                  <a href="/western-games">Western</a> 
        </div>
    </div>
    <div class="legal">
        <div class="left">
            <div id="a15b1695-1a5a-49a9-94f0-9cd25ae6c3b2">
    <a href="//privacy.truste.com/privacy-seal/Roblox-Corporation/validation?rid=2428aa2a-f278-4b6d-9095-98c4a2954215" title="TRUSTe Children privacy certification" target="_blank">
        <img style="border: none" src="/images/kids-seal.png" alt="TRUSTe Children privacy certification"/>
    </a>
</div>
        </div>
        <div class="right">
            <p class="Legalese">
    ROBLOX, "Online Building Toy", characters, logos, names, and all related indicia are trademarks of <a href="http://corp.roblox.com/" ref="footer-smallabout" class="roblox-interstitial">ROBLOX Corporation</a>, ©2013. Patents pending.
    ROBLOX is not sponsored, authorized or endorsed by any producer of plastic building bricks, including The LEGO Group, MEGA Brands, and K'Nex, and no resemblance to the products of these companies is intended. Use of this site signifies your acceptance of the <a href="/info/terms-of-service" ref="footer-terms">Terms and Conditions</a>.
</p>
        </div>
        <div class="clear"></div>
    </div>
</div>


	</div>
    <div id="ChatContainer" style="position:fixed;bottom:0;right:0;z-index:1000;">
        <?php if ($userAuth !== false && $_PS->ChatEnabled) { ?>
    <!-- Friends dock / chat bar -->
        <div id="friend_dock_chattemplate" style="display: none;">
            <div id="CHATUSERID_friend_dock_chatbox" userid="CHATUSERID" class="friend_dock_chatbox">
                <div class="friend_dock_chatbox_titlebar blinkoffheader" userid="CHATUSERID">
                    <div class="friend_dock_chatbox_username">
                        <a style="color: #fff" class="friend_dock_chatbox_username_display" href="http://<?php echo $_SERVER["HTTP_HOST"]; ?>/user.aspx?id=CHATUSERID">CHATUSERNAME</a>
                        <a class="friend_dock_chatbox_username_abuse" style="color: #fff; font-size: 9px; line-height: 14px; cursor: pointer" alt="Report Abuse" href="http://<?php echo $_SERVER["HTTP_HOST"].$_SERVER["REQUEST_URI"]; ?>#" onclick=" ReportAbuse(CHATUSERID); return false; ">(Report)</a>
                    </div>
                    <div class="friend_dock_chatbox_closebutton">
                        <a href="http://<?php echo $_SERVER["HTTP_HOST"].$_SERVER["REQUEST_URI"]; ?>#" style="color: #fff" onclick=" ChatBar.CloseChat($(this).parents(&#39;.friend_dock_chatbox&#39;).filter(&#39;:first&#39;));return false; ">-</a>
                    </div>
                </div>
                <div class="friend_dock_chatbox_currentlocation" style="margin: 10px; font-size: 12px; height: 18px">
                </div>
                <div id="CHATUSERID_friend_dock_chatbox_chat" class="friend_dock_chatbox_chat">
                </div>
                <textarea class="friend_dock_chatbox_entry" maxlength="255" style=""></textarea>
            </div>
        </div>
    <div id="friend_dock_friendtemplate" style="display: none;">
        <div id="UID_CURRTAB_friend" userid="UID" username="USERNAME" class="friend_dock_friend">
            <div id="UID_CURRTAB_onlinestatus" class="friend_dock_onlinestatus"></div>
            <div id="UID_CURRTAB_offlinestatus" class="friend_dock_offlinestatus"></div>
            <div id="UID_CURRTAB_dropdown" class="friendBarDropDown" userid="UID" username="USERNAME" style="display: none">
                <div id="UID_CURRTAB_dropdownbutton" class="friend_dropdownbutton20"></div>
                <div id="UID_CURRTAB_dropdownlist" class="friendBarDropDownList">
                    <ul>
                            <li onclick=" Party.InviteUser(&#39;USERNAME&#39;); " startpartydisplay=""><div>Invite To Party</div></li>
                            <li class="StartChat" onclick=" ChatBar.ToggleChat(&#39;UID&#39;, &#39;USERNAME&#39;); " startchattingdisplay="" userid="UID"><div>Start Chatting</div></li>
                        <li onclick=" window.location.href = &#39;/user.aspx?id=UID&#39;; "><div>View Profile</div></li>
                            <li class="EndChat" style="display: none" onclick=" ChatBar.RemoveActiveChat(this); " userid="UID"><div>End Chat</div></li>
                    </ul>
                </div>    
            </div>
            <img thumbnail_holder="" alt="" onclick=" ChatBar.ToggleChat(&#39;UID&#39;, &#39;USERNAME&#39;); return false; " width="48" height="48" class="ActiveChatThumb">
            <div class="friend_dock_username"><span class="friend_dock_username_href">USERNAMETRUNCATED</span></div>
        </div>
    </div>
    <div style="position:relative">
            <div id="friend_dock_chatholder">
            </div>
            <div id="partycontainer" style="display:none;margin-left:10px;float:right;">
                
    <div id="partyMemberTemplate" style="display:none;height:32px">
	    <div id="party_pendinguserid_UID">
	        <dt style="position:relative">
                <span id="UID_status" class="friend_dock_offlinestatus"></span>
                [PARTY_MEMBER_THUMBNAIL]
            </dt> 
	        <dd> 
		        <span>[PARTY_MEMBER_NAME]</span>&nbsp;&nbsp;&nbsp;[PARTY_MEMBER_REPORT][PARTY_KICK_MEMBER]
		        <br> 
		        <span class="grey9">&nbsp;</span> 
	        </dd> 
	    </div>
    </div>
    <script type="text/javascript" language="javascript">
        Party.CurrentUserID = 2104706;
        Party.CurrentUserName = "fatboy122";
        Party.ActiveView = "";
        Party.PollThreadAvailable = true;
        Party.FirstLoad = true;
        Party.PollIntervalTimer = null;
        Party.Cookie = new RobloxJSONCookie("PartyCookie"); 
        Party.MaxPartySize = 6;
        Party.PlayEnabled = true;
        
        Party.Resources = {
	        areYouSureReport: 'Are you sure you would like to report '
	        , report: "Report"
	        , kick: "Kick"
	        , pending: "Pending..."
	        , partyInvite: "Party Invite!"
	        , partyGameBlurb: "When the party leader joins a game, the rest of the party will be invited to follow"
	        , inviteInstructions: "Please type the name of the user you wish to invite"
	        , partyFull: "Your party is already full!"
	        , joinConfirm1: "The party leader has joined "
	        , joinConfirm2: ".  Would you like to join?"
	        , joinConfirm3: "You will be removed from any game you might be playing."
	        , enterUserName: 'Enter username'
        };
    </script>
    <script type="text/javascript" language="javascript">
        try
        {
            $(function()
            {
                Party.ProcessPolledData(eval(({"Error" : "User not found in party"})));
                Party.OnPageLoad();
            });
        }
        catch (ex)
        {

        }
    </script>
    <div class="partyWindow" id="party_none" style="display: block;"> 
	    <div id="party_none_title" class="title" onclick="Party.ToggleTab(false)">
            <span>Party</span> 
		    <div class="closeparty">-</div>
	    </div> 
	    <div class="main"> 
		    <div id="new_party"> 
			    <p>You are not in a party.  To create a party, just invite someone:</p>
			    <p><input type="text" id="new_party_invite_name" class="party_invite_box" onkeydown="return Party.ProcessKey(&#39;new_party_invite_name&#39;,event)" style="color: rgb(136, 136, 136);"><input type="button" class="translate" onclick="Party.DoInvite(&#39;new_party_invite_name&#39;)" value="Invite"></p>
		    </div> 
		    <div class="clear" id="new_party_clear"> 
		    </div> 
	    </div> 
    </div>
    <div class="partyWindow" id="party_loading" style="display: none;"> 
	    <div id="party_loading_title" class="title" onclick="Party.ToggleTab(false)">
		    <span>Party</span>  
		    <div class="closeparty">-</div> 
	    </div> 
	    <div class="main"> 
		    <div> 
			    <p>Invitation sent.</p>
			    <p>Creating party...</p>
		    </div> 
	    </div> 
    </div>
    <div class="partyWindow" id="party_pending" style="display: none;">
		    <div id="party_pending_title" class="title" onclick="Party.ToggleTab(false)"> 
			    <span>Party</span>
                <div class="closeparty">-</div> 
		    </div>
		    <div class="main"> 
			    <div id="invite_header" style="font-weight: bold; padding: 10px; color:Green;">RobloTim wants to party with you!</div> 
			    <div class="members"> 
				    <dl id="party_invite_list"> 
				    </dl> 
			    </div>
			
			    <div id="invite_status"> 
				    <p><span class="grey9">Invitations by Leader only</span></p> 
				    <p><span class="grey9">Waiting for Leader to play a game</span></p> 
			    </div> 
			
			    <div class="btn_green21h"> 
				    <a href="http://<?php echo $_SERVER["HTTP_HOST"].$_SERVER["REQUEST_URI"]; ?>#" onclick="Party.AcceptInvite();return false;">Join Party</a> 
			    </div> 
			
			    <div class="btn_red21h"> 
				    <a href="http://<?php echo $_SERVER["HTTP_HOST"].$_SERVER["REQUEST_URI"]; ?>#" onclick="Party.DeclineInvite();return false;">Ignore</a> 
			    </div> 
			
			    <div class="clear" id="invite_clear"> 
			    </div> 
		    </div>
    </div> 
    <div class="partyWindow" id="party_my" style="display: none;"> 
	    <div id="party_my_title" class="title" onclick="Party.ToggleTab(false)"> 
            <span>Party</span> 
		    <div class="closeparty">-</div> 
	    </div> 
	    <div class="main" style="max-height: 588px;"> 
		    <div class="members"> 
			    <dl id="party_member_list"> 
				
			    </dl> 
		    </div>
		
		    <p id="party_invite_instructions"><span class="grey9"><input type="text" id="party_my_invite_name" class="party_invite_box" onkeydown="return Party.ProcessKey(&#39;party_my_invite_name&#39;,event)" style="color: rgb(136, 136, 136);"><input type="button" class="translate" onclick="Party.DoInvite(&#39;party_my_invite_name&#39;)" value="Invite"></span></p> 
		
		    <div id="chat_messages"> 

		    </div> 
		
		    <div id="chat_input">
			    <textarea name="comments" rows="2" cols="27" id="comments" tabindex="4" title="comments" style=""></textarea>
		    </div> 
		
                <div id="party-auto-follow-setting" style="padding: 5px; text-align: center">
	                <input id="auto-follow-party-leader" type="checkbox">
	                <label for="auto-follow-party-leader">Automatically follow party leader</label>
	                <script type="text/javascript">
	                    $("#auto-follow-party-leader").prop('checked', $.cookie('AutoFollowPartyLeader') == 'true');
	                    $("#auto-follow-party-leader").on("click", function () {
	                        // every time I join a party in the future, this cookie will determine whether or not I automatically follow the party leader
	                        $.cookie('AutoFollowPartyLeader', this.checked, { path: '/', expires: 365 });
	                        $.get("/chat/party.ashx", { reqtype: "autoFollowPartyLeader" });
	                    });
            	    </script>
	            </div>

		        <div id="party_current_game">
                    <table border="0" style="padding: 0px; margin: 0px; border: 0px;">
                        <tbody><tr style="padding: 0px; margin: 0px; border: 0px;">
                            <td style="padding: 0px; margin: 0px; border: 0px;">
		                        <div id="party_game_thumb">
		                        </div>
                            </td>
                            <td style="padding: 0px; margin: 0px; border: 0px;">
		                        <div id="party_game_name" style="float: right;">
		                        </div>
		                        <span id="party_game_follow_me" class="followme_green19h" onclick="Party.JoinGameWithParty(); return false;"></span>
		                        <span class="btn_red21h">
			                        <a href="http://<?php echo $_SERVER["HTTP_HOST"].$_SERVER["REQUEST_URI"]; ?>#" onclick="Party.DeclineInvite();return false;">Leave Party</a>
		                        </span>
                            </td>
                        </tr>
                    </tbody></table>
		        </div>
		
		    <div class="clear" id="leader_clear"> 
		    </div> 
		
	    </div>
    </div>

            </div>
            <div class="clear"></div>
        </div>
    <div id="friend_dock_minimized_container" style="">
            <div style="float:right">
                <a id="minChatsTab" href="http://<?php echo $_SERVER["HTTP_HOST"].$_SERVER["REQUEST_URI"]; ?>#" class="tab_white19h">
                    <span onclick="ChatBar.ShowFriends();return false;">
                        <img src="http://images.rbxcdn.com/164e80229d83c8b6e55b1eb671887e54.png" style="border: none">
                        Online
                    </span>
                </a>
            </div>
        </div>
        <div id="friend_dock_container" style="                                                  display: none
">
           <div id="friend_dock_titlebar">
               <div style="float:left;">
                   
                        <a id="bestFriendsTab" style="text-decoration: none" class="tab_white19h" href="http://<?php echo $_SERVER["HTTP_HOST"].$_SERVER["REQUEST_URI"]; ?>#" onclick="ChatBar.TogglePanel(&#39;bestFriendsTab_dock_thumbnails&#39;);return false;"><span>Best Friends</span></a>
                        <a id="friendsTab" style="text-decoration: none" class="tab_white19hselected" href="http://<?php echo $_SERVER["HTTP_HOST"].$_SERVER["REQUEST_URI"]; ?>#" onclick="ChatBar.TogglePanel(&#39;friendsTab_dock_thumbnails&#39;);return false;"><span>Online Friends</span></a>
                    <a id="recentsTab" style="text-decoration: none" class="tab_white19h" href="http://<?php echo $_SERVER["HTTP_HOST"].$_SERVER["REQUEST_URI"]; ?>#" onclick="ChatBar.TogglePanel(&#39;recentsTab_dock_thumbnails&#39;);return false;"><span>Recent</span></a>
                        <a id="chatsTab" style="text-decoration: none" class="tab_white19h" href="http://<?php echo $_SERVER["HTTP_HOST"].$_SERVER["REQUEST_URI"]; ?>#" onclick="ChatBar.TogglePanel(&#39;chatsTab_dock_thumbnails_chat&#39;);return false;"><span>Chats</span></a>
                </div>
                <div style="float:right;">
                        <div class="tab_white19h" id="partyTab" onclick=" Party.ToggleTab(null); return false; ">
                            <span>
                                <b><a href="http://<?php echo $_SERVER["HTTP_HOST"].$_SERVER["REQUEST_URI"]; ?>#">Party</a></b>&nbsp;&nbsp;&nbsp;&nbsp;
                            </span>
                        </div>
                    <div class="friend_dock_chatsettings" style="display:none">
                        <div style="padding:10px 10px 10px 10px">
                            <div class="chat_settings_group_header">Who can chat with me:</div>
                            <input type="radio" id="chat_settings_all" name="rdoOnline"> <b>All Users</b><br>
                            <input type="radio" id="chat_settings_friends" name="rdoOnline" checked="checked"> <b>Friends</b><br>
                            <input type="radio" id="chat_settings_bestfriends" name="rdoOnline"> <b>Best Friends</b><br>
                            <input type="radio" id="chat_settings_noone" name="rdoOnline"> <b>No One</b><br>
                                    <hr>
                                <div class="chat_settings_group_header">Who can party with me:</div>
                                <input type="radio" id="party_settings_all" name="rdoOnline2"> <b>All Users</b><br>
                                <input type="radio" id="party_settings_friends" name="rdoOnline2" checked="checked"> <b>Friends</b><br>
                                <input type="radio" id="party_settings_bestfriends" name="rdoOnline2"> <b>Best Friends</b><br>
                                <input type="radio" id="party_settings_noone" name="rdoOnline2"> <b>No One</b><br>
                                <hr>
                                <div class="chat_settings_group_header">Chat Notifications:</div>
                                <input type="radio" id="chat_settings_soundon" name="rdoNotifications"> <b>All</b><br>
                                <input type="radio" id="chat_settings_soundoff" name="rdoNotifications"> <b>None</b><br>
                            <div style="text-align:center; margin-top: 5px;">
                                <input type="button" onclick="ChatBar.ApplySettings();$(&#39;.friend_dock_chatsettings&#39;).hide();" value="Save">
                            </div>
                        </div>
                    </div>
                    <div class="tab_white19h">
                        <span>
                            <b><a onclick="$(&#39;.friend_dock_chatsettings&#39;).toggle(); return false" href="http://<?php echo $_SERVER["HTTP_HOST"].$_SERVER["REQUEST_URI"]; ?>#">Settings</a></b>&nbsp;&nbsp;&nbsp;
                            <img src="http://images.rbxcdn.com/8a762994af1e122de8ac427005ac3d9b.png" onclick="ChatBar.HideFriends();return false;" style="border: none; cursor: pointer" alt="Close chat">
                        </span>
                    </div>
               </div>
           </div>
           <div id="friend_dock_thumb_container">
                <!-- Container for the dynamically generated thumbs for friends -->
                <div id="friendsTab_dock_thumbnails" style="">
                    <div id="friendsTab_dock_thumbnails_empty" style="display:none; font-size:12px; margin-top:40px;">No results found.  Find some friends <a href="http://<?php echo $_SERVER["HTTP_HOST"]; ?>/Browse.aspx">here</a>.</div>
                </div>
                
                <!-- Container for the dynamically generated thumbs for best friends -->
                <div id="bestFriendsTab_dock_thumbnails" style="float:left; display: none">
                    <div id="bestFriendsTab_dock_thumbnails_empty" style="display:none; font-size:12px; margin-top:40px;">No results? Start off by <a href="http://<?php echo $_SERVER["HTTP_HOST"]; ?>/my/editfriends.aspx">adding some Best Friends.</a></div>
                </div>
                
                <!-- Container for the dynamically generated thumbs for recents -->
                <div id="recentsTab_dock_thumbnails" style="float:left; display: none">
                    <div id="recentsTab_dock_thumbnails_empty" style="display:none; font-size:12px; margin-top:40px;">You have not had any recent interactions.</div>
                </div>
                
                <!-- Container for the dynamically generated thumbs for chats -->
                <div id="chatsTab_dock_thumbnails_chat" style="float:left; display: none">
                    <div id="chatsTab_dock_thumbnails_chat_empty" style="display:none; font-size:12px; margin-top:40px;">You are not currently chatting with anyone.</div>
                </div>
           </div>
        </div>
        <div id="jPlayerDiv" style="position: absolute; top: 0px; left: -9999px;"><audio id="jqjp_audio_0" preload="none"></audio><div id="jqjp_force_0" style="text-indent: -9999px;">0.7583572196308523</div></div>
    <script type="text/javascript" language="javascript">
            if (typeof Roblox === "undefined") {
        Roblox = {};
        }
        if (typeof Roblox.Chat_v1 === "undefined") {
            Roblox.Chat_v1 = {};
        }
        Roblox.Chat_v1.Resources = {
            //<sl:translate>
            reportConfirm: 'Are you sure you would like to report this user?'
            , sendPersonalMessage1: 'This user cannot receive chat messages.  Send them a '
            , sendPersonalMessage2: 'Personal Message'
            , loadingChat: 'Loading Chat'
            , offline: 'Offline'
            , online: 'Online'
            , newMessage: 'New Message!'
            , newMessages: 'New Messages!'
            //</sl:translate>
        };
            
        ChatBar.FriendsEnabled = 'True';
        ChatBar.BestFriendsEnabled = 'True';
        ChatBar.PartyEnabled = 'True';
        ChatBar.MyUserName = "<?php echo $userAuth->GetUserInfo("username"); ?>";
        ChatBar.MaxChatWindows = 4;
        ChatBar.ChatPollInterval = 4000;
        ChatBar.IdleChatPollInterval = ChatBar.ChatPollInterval * ChatBar.PollIntervalFactorForIdle;
        ChatBar.FriendsPollInterval = 40000;
        ChatBar.BestFriendsPollInterval = 30000;
        ChatBar.RecentsPollInterval = 32000;
        ChatBar.ChatReceivedSoundFile = "/chat/sound/chatsound.mp3";
        ChatBar.ChatNotificationsSetting = 'All';
        ChatBar.DiagnosticsEnabled = false;

        $(function()
        {
            try
            {
                ChatBar.OnPageLoad();
            }
            catch (x) { }
        });
    </script>
        <?php } ?>
    </div>

    
        
        <script src="http://www.google-analytics.com/urchin.js" type="text/javascript"></script>
        <script type="text/javascript">
            _uacct = "UA-486632-1";
            _udn = "roblox.com";
            _uccn = "rbx_campaign";
            _ucmd = "rbx_medium";
            _ucsr = "rbx_source";
            urchinTracker();
            __utmSetVar('Visitor/Spider');
        </script>
    

    
<?php if (!empty($_PS->FooterJS)) { ?>
<script type="text/javascript">
//<![CDATA[
<?php echo $_PS->FooterJS; ?>//]]>
</script>
<?php } ?>
</form>
    
    
    
<div id="InstallationInstructions"  class="modalPopup blueAndWhite" style="display:none;overflow:hidden" >
    <a id="CancelButton2" onclick="return Roblox.Client._onCancel();" class="ImageButton closeBtnCircle_35h ABCloseCircle"></a>
    <div style="padding-bottom:10px;text-align:center">
        <br /><br />
    </div>
</div>


<div id="pluginObjDiv" style="height:1px;width:1px;visibility:hidden;position: absolute;top: 0;"></div>
<iframe id="downloadInstallerIFrame" style="visibility:hidden;height:0;width:1px;position:absolute"></iframe>


<script type='text/javascript' src='/js/EventTracker.js'></script>
<script type='text/javascript' src='/js/ClientInstaller.js'></script>
<script type='text/javascript' src='/js/InstallationInstructions.js'></script>
<script type='text/javascript' src='/js/IEMetroInstructions.js'></script>

<script type="text/javascript">
    Roblox.Client._skip = null;
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
            <img src="http://images.rbxcdn.com/e998fb4c03e8c2e30792f2f3436e9416.gif" alt="Progress" />
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


<script type='text/javascript' src='/js/VideoPreRoll.js'></script>

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
        Roblox.VideoPreRoll.videoOptions.categories = "NonBC,IsLoggedIn,AgeUnknown,GenderUnknown,Sports,";
             Roblox.VideoPreRoll.videoOptions.id = "games";
        Roblox.VideoPreRoll.videoLoadingTimeout = 11000;
        Roblox.VideoPreRoll.videoPlayingTimeout = 23000;
        Roblox.VideoPreRoll.videoLogNote = "NotWindows";
        Roblox.VideoPreRoll.logsEnabled = true;
        Roblox.VideoPreRoll.excludedPlaceIds = "32373412";
            
                Roblox.VideoPreRoll.specificAdOnPlacePageEnabled = true;
                Roblox.VideoPreRoll.specificAdOnPlacePageId = 157382;
                Roblox.VideoPreRoll.specificAdOnPlacePageCategory = "stooges";
            
            
                Roblox.VideoPreRoll.specificAdOnPlacePage2Enabled = true;
                Roblox.VideoPreRoll.specificAdOnPlacePage2Id = 88419564;
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
                 <?php echo (str_contains($_SERVER['HTTP_USER_AGENT'], "Windows") ? "return RobloxLaunch.CheckRobloxInstall('/install/download.aspx');" : "window.location= '/install/unsupported.aspx'; return false;"); ?>
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

<script type='text/javascript' src='/js/CharacterSelect.js'></script>
<script type='text/javascript' src='/js/MadStatus.js'></script>
<script type='text/javascript' src='/js/PlaceLauncher.js'></script>
<script type='text/javascript' src='/js/ABPlaceLauncher.js'></script>
  

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