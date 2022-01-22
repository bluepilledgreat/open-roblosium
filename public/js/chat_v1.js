function BindDropDown(n, t) {
    ChatBar.SetPartyInviteStatus(t.ID, t.ShowInviteLink == "true"), $(".friend_dock_chatbox[userid=" + t.ID + "]").is(":visible") && ($(".StartChat[userid=" + t.ID + "]").hide(), $(".EndChat[userid=" + t.ID + "]").show()), $(n).children(".friend_dropdownbutton20").click(function() {
        $(this).siblings(".friendBarDropDownList").show()
    }), $(n).hover(function() {}, function() {
        $(this).find(".friendBarDropDownList").hide()
    }), $(n).find("li").click(function() {
        $(this).parent().parent().hide()
    });
    var i = $(n).parent();
    $(i).hover(function() {
        $(this).children(".friendBarDropDown").show()
    }, function() {
        $(this).children(".friendBarDropDown").hide()
    })
}

function ReportAbuse(n) {
    confirm(Roblox.Chat_v1.Resources.reportConfirm) && (window.location.href = "/abusereport/chat.aspx?ID=" + n + "&RedirectUrl=" + escape(window.location))
}
var Party, ChatBar = {};
ChatBar.CurrentTabID = null, ChatBar.FriendsEnabled = !1, ChatBar.BestFriendsEnabled = !1, ChatBar.PartyEnabled = !1, ChatBar.ChatPollIntervalTimer = null, ChatBar.ChatPollInterval = 1500, ChatBar.IdleChatPollInterval = 5e3, ChatBar.PollingStatus = "normal", ChatBar.PollIntervalFactorForIdle = 6, ChatBar.BestFriendsPollIntervalTimer = null, ChatBar.BestFriendsPollInterval = 3e4, ChatBar.BestFriendsLastPoll = null, ChatBar.FriendsPollIntervalTimer = null, ChatBar.FriendsPollInterval = 4e4, ChatBar.FriendsLastPoll = null, ChatBar.RecentsPollIntervalTimer = null, ChatBar.RecentsPollInterval = 32e3, ChatBar.RecentsLastPoll = null, ChatBar.MaxChatWindows = 4, ChatBar.NumChatWindows = 0, ChatBar.ActiveChats = null, ChatBar.Recents = [], ChatBar.BestFriends = [], ChatBar.Friends = [], ChatBar.ActiveChatsOnlineStatus = [], ChatBar.MyUserName = "", ChatBar.IsFirstLoad = !0, ChatBar.PollCount = 0, ChatBar.LastPollTime = 0, ChatBar.LastActivityTimeInTicks = +new Date, ChatBar.WindowIsInFocus = !0, ChatBar.RawData = {}, ChatBar.SoundPlayerIsReady = !1, ChatBar.AlreadyReceivedMessages = [], ChatBar.PageTitle = document.title, ChatBar.PageTitleIndicatorIntervalTimer = null, ChatBar.ActiveBlinkers = [], ChatBar.ChatTabBlinker = null, ChatBar.ChatThreadAvailable = !0, ChatBar.FriendsThreadAvailable = !0, ChatBar.DiagnosticsEnabled = !1, ChatBar.CurrentChatPollInterval = null, ChatBar.Log = function(n) {
    if (ChatBar.DiagnosticsEnabled && window.console) {
        var t = new Date,
            i = "CHATLOG " + t.toLocaleTimeString() + ":" + t.getMilliseconds() + " | ";
        console.log(i + n)
    }
}, ChatBar.OnPageLoad = function() {
    var t, n;
    $(".friend_dock_chatbox_entry").live("keyup", function(n) {
        if (n.keyCode == 13) {
            if ($.trim(this.value) == "") {
                this.value = "";
                return
            }
            return ChatBar.SendMessage($(this)), !1
        }
        return !0
    }), ChatBar.Log("ChatBar.OnPageLoad"), ChatBar.LoadStateFromClient(), t = $("#friend_dock_minimized_container:visible"), t.length > 0 ? (ChatBar.CurrentChatPollInterval = ChatBar.IdleChatPollInterval, ChatBar.Log("onpageload Detected chat minimized, ChatBar.ChatPollIntervalTimer to " + ChatBar.CurrentChatPollInterval), ChatBar.PollingStatus = "idle", ChatBar.ChatPollIntervalTimer = setInterval(function() {
        ChatBar.PollForChats()
    }, ChatBar.CurrentChatPollInterval)) : (ChatBar.CurrentChatPollInterval = ChatBar.ChatPollInterval, ChatBar.Log("onpageload Detected chat maximized, ChatBar.ChatPollIntervalTimer to " + ChatBar.CurrentChatPollInterval), ChatBar.PollingStatus = "normal", ChatBar.ChatPollIntervalTimer = setInterval(function() {
        ChatBar.PollForChats()
    }, ChatBar.CurrentChatPollInterval)), ChatBar.ChatThreadAvailable == !0 ? ChatBar.PollForChats() : setTimeout(function() {
        ChatBar.PollForChats()
    }, 500), n = navigator.appName == "Microsoft Internet Explorer", n ? (document.onfocusout = function() {
        ChatBar.OnFocusOut()
    }, document.onfocusin = function() {
        ChatBar.OnFocusIn()
    }) : (window.onblur = function() {
        ChatBar.OnFocusOut()
    }, window.onfocus = function() {
        ChatBar.OnFocusIn()
    }), window.onbeforeunload = function() {
        ChatBar.SaveStateToClient()
    }, $("#jPlayerDiv").jPlayer({
        swfPath: "/js/jPlayer/2.4.0/Jplayer.swf",
        solution: "flash, html",
        supplied: "mp3, wav",
        wmode: "transparent",
        errorAlerts: !1,
        warningAlerts: !1,
        ready: function() {
            $("#jPlayerDiv").jPlayer("setMedia", {
                mp3: ChatBar.ChatReceivedSoundFile
            }), ChatBar.SoundPlayerIsReady = !0
        }
    })
}, ChatBar.PlaySound = function(n) {
    ChatBar.SoundPlayerIsReady && !ChatBar.WindowIsInFocus && ChatBar.ChatNotificationsSetting != "None" && n === "msgrec" && $("#jPlayerDiv").jPlayer("play")
}, ChatBar.GetOpenChats = function() {
    var t = 0,
        n = "";
    return $(".friend_dock_chatbox:visible").each(function() {
        n += $(this).attr("userid") + ",", t++
    }), n
}, ChatBar.GetAllChats = function() {
    var t = "",
        n;
    if (ChatBar.ActiveChats == null) return "";
    for (n = 0; n < ChatBar.ActiveChats.length; n++) t += ChatBar.ActiveChats[n].SenderID + ",";
    return t
}, ChatBar.ApplySettings = function() {
    var i = "",
        n, t;
    $("#chat_settings_all").attr("checked") ? i = "All" : $("#chat_settings_friends").attr("checked") ? i = "Friends" : $("#chat_settings_bestfriends").attr("checked") ? i = "TopFriends" : $("#chat_settings_noone").attr("checked") && (i = "Noone"), n = "", ChatBar.PartyEnabled && ($("#party_settings_all").attr("checked") ? n = "All" : $("#party_settings_friends").attr("checked") ? n = "Friends" : $("#party_settings_bestfriends").attr("checked") ? n = "TopFriends" : $("#party_settings_noone").attr("checked") && (n = "Noone")), t = "", $("#chat_settings_soundon").attr("checked") ? t = "All" : $("#chat_settings_soundoff").attr("checked") && (t = "None"), ChatBar.ChatNotificationsSetting = t, $.getJSON("/chat/utility.ashx", {
        reqtype: "setproperties",
        visibility: i,
        partyVisibility: n,
        notificationSetting: t
    }, function() {
        return
    })
}, ChatBar.GenerateUserOfflineSendPMMessage = function(n) {
    return Roblox.Chat_v1.Resources.sendPersonalMessage1 + "<a href='/My/NewMessage.aspx?RecipientID=" + n + "'>" + Roblox.Chat_v1.Resources.sendPersonalMessage2 + "</a>."
}, ChatBar.DisableTextEntry = function(n) {
    var t = "#" + n + "_friend_dock_chatbox_chat",
        i;
    $(t) && ($(t).children(".friend_dock_chatbox_entry").attr("disabled", "disabled"), $(t).children(".chaterror").size() == 0 && (i = ChatBar.GenerateUserOfflineSendPMMessage(n), $(t).append("<i class='chaterror'>" + i + "<br /><br /></i>"), $(t).prop({
        scrollTop: $(t).prop("scrollHeight")
    })))
}, ChatBar.EnableTextEntry = function(n) {
    var t = "#" + n + "_friend_dock_chatbox_chat";
    $(t) && ($(t).children(".friend_dock_chatbox_entry").removeAttr("disabled"), $(t).children(".chaterror").size() > 0 && $(t).children(".chaterror").remove())
}, ChatBar.BlockWindow = function(n) {
    $(".friend_dock_chatbox[userid=" + n + "]").block({
        message: "<b>" + Roblox.Chat_v1.Resources.loadingChat + "</b>",
        css: {
            border: "3px solid #a00"
        }
    })
}, ChatBar.UnblockAllWindows = function() {
    $(".friend_dock_chatbox:visible").each(function() {
        $(this).unblock()
    })
}, ChatBar.ResetPageTitle = function() {
    clearInterval(ChatBar.PageTitleIndicatorIntervalTimer), ChatBar.PageTitleIndicatorIntervalTimer = null, document.title = ChatBar.PageTitle
}, ChatBar.TogglePageTitleIndicator = function(n) {
    var t = n;
    clearInterval(ChatBar.PageTitleIndicatorIntervalTimer), ChatBar.PageTitleIndicatorIntervalTimer = setInterval(function() {
        document.title = document.title == ChatBar.PageTitle ? t : ChatBar.PageTitle
    }, 2e3)
}, ChatBar.OnFocusOut = function() {
    ChatBar.Log("ChatBar.OnFocusOut detected"), ChatBar.WindowIsInFocus = !1, clearInterval(ChatBar.ChatPollIntervalTimer), ChatBar.CurrentChatPollInterval = ChatBar.IdleChatPollInterval * 2, ChatBar.Log("onfocusout Set chatpollintervalttimer to " + ChatBar.CurrentChatPollInterval), ChatBar.ChatPollIntervalTimer = setInterval(function() {
        ChatBar.PollForChats()
    }, ChatBar.CurrentChatPollInterval), ChatBar.PollingStatus = "idle", clearInterval(ChatBar.FriendsPollIntervalTimer), clearInterval(ChatBar.BestFriendsPollIntervalTimer), clearInterval(ChatBar.RecentsPollIntervalTimer)
}, ChatBar.OnFocusIn = function() {
    ChatBar.Log("ChatBar.OnFocusIn detected"), ChatBar.WindowIsInFocus = !0, clearInterval(ChatBar.ChatPollIntervalTimer), ChatBar.CurrentChatPollInterval = ChatBar.ChatPollInterval, ChatBar.Log("onfocusin Set chatpollintervalttimer to " + ChatBar.CurrentChatPollInterval), ChatBar.ChatPollIntervalTimer = setInterval(function() {
        ChatBar.PollForChats()
    }, ChatBar.CurrentChatPollInterval), ChatBar.PollingStatus = "normal", ChatBar.LastActivityTimeInTicks = +new Date, ChatBar.ResetPageTitle(), ChatBar.PollIfNecessary(ChatBar.CurrentTabID)
}, ChatBar.HideFriends = function() {
    $("#ChatContainer").css("width", ""), $("#friend_dock_chatholder").hide(), $("#friend_dock_container").hide(), $("#friend_dock_minimized_container").show(), ChatBar.OnFocusOut(), $.cookies.set("IsMinimized", "true")
}, ChatBar.ShowFriends = function() {
    $("#ChatContainer").width("100%"), $("#friend_dock_container").show(), $("#friend_dock_minimized_container").hide(), $("#friend_dock_chatholder").show();
    var n = $("#friend_dock_container").html();
    n = n.replace(/min_src/g, "src"), $("#friend_dock_container").html(n), ChatBar.OnFocusIn(), $.cookies.set("IsMinimized", "false")
}, ChatBar.SetPartyInviteStatus = function(n, t) {
    t ? $(".friend_dock_friend[userid=" + n + "]").find(".partyInvite").show() : $(".friend_dock_friend[userid=" + n + "]").find(".partyInvite").hide()
}, ChatBar.UpdateChatZone = function(n) {
    try {
        if (!$("#chatsTab_dock_thumbnails_chat").find(".friend_dock_friend[userid=" + n.SenderID + "]").length) {
            var i = ChatBar.GenerateThumbFromTemplate(n),
                t = $("#chatsTab_dock_thumbnails_chat").append(i);
            BindDropDown($(t).find(".friendBarDropDown"), n), $("#chatsTab_dock_thumbnails_chat").children(".friend_dock_friend").size() > 20 && $("#chatsTab_dock_thumbnails_chat").children(".friend_dock_friend:last").remove()
        }
    } catch (r) {}
}, ChatBar.LoadUserLocationIntoWindow = function(n) {
    var i, r, u, t, f;
    n != null && (i = n.Location, i !== undefined && i != null) && (r = null, r = n.SenderID !== undefined ? n.SenderID : n.ID, u = null, u = n.SenderUserName !== undefined ? n.SenderUserName : n.Name, $(".friend_dock_chatbox[userid=" + r + "]").children(".friend_dock_chatbox_currentlocation").html(""), $(".friend_dock_chatbox[userid=" + r + "]").children(".friend_dock_chatbox_currentlocation").css("height", ""), t = "", f = $(".friend_dock_friend[userid=" + r + "] img").attr("src"), t += "<img style='margin-right:5px;margin-top:-5px;width:30px;height:30px;float:left' src='" + f + "' />", i == "website" ? t += "<p><span style='color: green'>" + Roblox.Chat_v1.Resources.online + "</span>: Website</p>" : i == "offline" ? t += "<p><span style='color: grey'>" + Roblox.Chat_v1.Resources.offline + "</span></p>" : (i.GameThumbnailURL && (t += "<div style='width: 62px; float: left; margin-right: 10px; margin-bottom: 10px; cursor: pointer'><a href='" + i.GameAssetURL + "' style='text-decoration: none'><img src='" + i.GameThumbnailURL + "'/></a></div>"), t += "<div>", t += "<a href='#' style='text-decoration: none; color: black' onclick=\"", t += "RobloxLaunch._GoogleAnalyticsCallback = function() { GoogleAnalyticsEvents.FireEvent(['Play', 'User']); RobloxEventManager.triggerEvent('rbx_evt_play_user'); }; Roblox.Client.WaitForRoblox(function() { RobloxLaunch.RequestFollowUser('PlaceLauncherStatusPanel', '" + r + "');}); return false;\">", t += "Join " + u + " in<br/><span style='font-weight: bold'><i>" + unescape(i.GameAssetName) + "</i></span>", t += "</a></div>"), $(".friend_dock_chatbox[userid=" + r + "]").children(".friend_dock_chatbox_currentlocation").html(t))
}, ChatBar.LoadChatIntoWindow = function(n) {
    var f, t, r, i, u, e;
    if (n != null && n.Conversation !== undefined && n.Conversation != null) {
        for (f = n.Conversation, t = n.SenderID, $("#" + t + "_friend_dock_chatbox_chat").html(""), r = 0; r < f.length; r++) i = f[r], u = "#0066CC", ChatBar.MyUserName != i.SenderUserName && (u = "#007B00"), e = i.TimeSent.substring(1), $("#" + t + "_friend_dock_chatbox_chat").append("<b><span style='color: " + u + "'>" + i.SenderUserName + "</span></b>: " + i.Message + " <span style='color: gray; font-size: 8px; font-style: italic'>(" + e + ")</span><br /><br />");
        $("#" + t + "_friend_dock_chatbox_chat").prop({
            scrollTop: $("#" + t + "_friend_dock_chatbox_chat").prop("scrollHeight")
        })
    }
}, ChatBar.FindUserData = function(n) {
    var t;
    if (ChatBar.ActiveChats != null)
        for (t = 0; t < ChatBar.ActiveChats.length; t++)
            if (ChatBar.ActiveChats[t].SenderID == n) return ChatBar.ActiveChats[t];
    if (ChatBar.Friends != null)
        for (t = 0; t < ChatBar.Friends.length; t++)
            if (ChatBar.Friends[t].ID == n) return ChatBar.Friends[t];
    if (ChatBar.BestFriends != null)
        for (t = 0; t < ChatBar.BestFriends.length; t++)
            if (ChatBar.BestFriends[t].ID == n) return ChatBar.BestFriends[t];
    if (ChatBar.Recents != null)
        for (t = 0; t < ChatBar.Recents.length; t++)
            if (ChatBar.Recents[t].ID == n) return ChatBar.Recents[t];
    return null
}, ChatBar.ToggleChat = function(n, t) {
    var i = ".friend_dock_chatbox[userid=" + n + "]";
    $(i).is(":visible") ? ChatBar.CloseChat($(i)) : ChatBar.OpenChat(n, t), ChatBar.LastActivityTimeInTicks = +new Date, ChatBar.PollingStatus == "idle" && (ChatBar.PollingStatus = "normal", clearInterval(ChatBar.ChatPollIntervalTimer), ChatBar.CurrentChatPollInterval = ChatBar.ChatPollInterval, ChatBar.Log("toggle chat - status is idle, setting interval to normal, ChatBar.ChatPollInterval = " + ChatBar.CurrentChatPollInterval), ChatBar.ChatPollIntervalTimer = setInterval(function() {
        ChatBar.PollForChats()
    }, ChatBar.CurrentChatPollInterval)), ChatBar.IsFirstLoad = !0, ChatBar.PollForChats()
}, ChatBar.CreateChatWindow = function(n, t) {
    var r = ".friend_dock_chatbox[userid=" + n + "]",
        i;
    return $(r).length ? $(r).is(":visible") || ($(r).fadeIn(350), ChatBar.NumChatWindows++) : (i = $("#friend_dock_chattemplate").html(), i = i.replace(/CHATUSERID/g, n), i = i.replace(/CHATUSERNAME/g, t), $("#friend_dock_chatholder").append(i), ChatBar.NumChatWindows++), $("#" + r).click(function() {
        ChatBar.GiveElementFocus($(this).find(".friend_dock_chatbox_entry"))
    }), r
}, ChatBar.GiveElementFocus = function(n) {
    $(n).focus(), $(n).siblings(".blinkonheader").removeClass("blinkonheader").addClass("blinkoffheader")
}, ChatBar.OnMessageReceived = function(n) {
    var i, t, e, u, r, o, f;
    if (ChatBar.PlaySound("msgrec"), i = $(".blinkoffheader[userId=" + n + "]"), !i || ChatBar.WindowIsInFocus && $(i).siblings("textarea").is(":focus") || $(i).removeClass("blinkoffheader").addClass("blinkonheader"), ChatBar.IsMinimized()) {
        t = $("#minChatsTab"), e = setInterval(function() {
            t.toggleClass("tab_white19h_flash")
        }, 500);
        t.one("click", function() {
            clearInterval(e), t.removeClass("tab_white19h_flash"), $(".friend_dock_chatbox[userid=" + n + "]").is(":visible") || (ChatBar.ToggleChat(n, ChatBar.FindUserData(n).SenderUserName), ChatBar.OnMessageReceived(n), ChatBar.TogglePanel("chatsTab_dock_thumbnails_chat"))
        })
    }
    if ($(".friend_dock_chatbox[userid=" + n + "]").length) {
        if (u = ChatBar.ActiveBlinkers.indexOf(n), u == -1) {
            ChatBar.ActiveBlinkers.push(n), r = $(".friend_dock_friend[userid=" + n + "] .friend_dock_username"), o = setInterval(function() {
                r.toggle()
            }, 500);
            $(".friend_dock_chatbox[userid=" + n + "]").one("click", function() {
                clearInterval(o), r.show(), ChatBar.ActiveBlinkers.splice(u, 1)
            })
        }
        ChatBar.ChatTabBlinker == null && (f = $("#chatsTab"), ChatBar.ChatTabBlinker = setInterval(function() {
            ChatBar.ActiveBlinkers.length > 0 ? f.toggleClass("tab_white19h_flash") : (clearInterval(ChatBar.ChatTabBlinker), ChatBar.ChatTabBlinker = null, f.removeClass("tab_white19h_flash"))
        }, 500))
    }
}, ChatBar.OpenChat = function(n, t) {
    var r, i;
    $(".friend_dock_chatbox[userid=" + n + "]").is(":visible") || ($(".StartChat[userid=" + n + "]").hide(), $(".EndChat[userid=" + n + "]").show(), ChatBar.NumChatWindows >= ChatBar.MaxChatWindows && ChatBar.CloseChat($(".friend_dock_chatbox:visible:first")), r = ChatBar.CreateChatWindow(n, t), ChatBar.BlockWindow(n), i = ChatBar.FindUserData(n), ChatBar.LoadChatIntoWindow(i), ChatBar.LoadUserLocationIntoWindow(i), i == null && (ChatBar.ActiveChatsOnlineStatus != null && ChatBar.ActiveChatsOnlineStatus[n] !== undefined && ChatBar.ActiveChatsOnlineStatus[n] === !1 ? ChatBar.DisableTextEntry(n) : ChatBar.EnableTextEntry(n)))
}, ChatBar.CloseChat = function(n) {
    if (n) {
        var t = $(n).attr("userid");
        $(n).fadeOut(350), $(".StartChat[userid=" + t + "]").show(), $(".EndChat[userid=" + t + "]").hide(), ChatBar.NumChatWindows--
    }
}, ChatBar.ProcessPolledChatData = function(n) {
    var r = 0,
        u, t, i, s, e, h, f, o;
    for (ChatBar.ActiveChats = n, ChatBar.ActiveChats.length == 0 ? $("#chatsTab_dock_thumbnails_chat").html($("#chatsTab_dock_thumbnails_chat_empty").attr("outerHTML")) : $("#chatsTab_dock_thumbnails_chat_empty").hide(), u = 0; u < ChatBar.ActiveChats.length; u++) t = ChatBar.ActiveChats[u], i = t.SenderID, t.CachedOnClient == "false" && (ChatBar.UpdateChatZone(t), s = t.Online == "true", ChatBar.SetOnline(i, s)), ChatBar.SetPartyInviteStatus(i, t.ShowInviteLink == "true"), e = t.HasNewMessages == "true", h = ChatBar.IsFirstLoad, (e || h) && (f = $(".friend_dock_chatbox[userid=" + i + "]:visible").length, o = $.cookie("ChatWindowOpened" + i), e && (f ? r++ : ChatBar.IsMinimized() || o != null || (setTimeout(function() {
        ChatBar.ToggleChat(i, t.SenderUserName), ChatBar.OnMessageReceived(i)
    }, 0), $.cookie("ChatWindowOpened" + i, !0)), ChatBar.OnMessageReceived(i)), f && (ChatBar.LoadUserLocationIntoWindow(t), ChatBar.LoadChatIntoWindow(t))), r > 0 && ChatBar.WindowIsInFocus == !0 && (ChatBar.LastActivityTimeInTicks = +new Date, ChatBar.PollingStatus == "idle" && (ChatBar.PollingStatus = "normal", clearInterval(ChatBar.ChatPollIntervalTimer), ChatBar.CurrentChatPollInterval = ChatBar.ChatPollInterval, ChatBar.Log("got a message while idle, speeding up polling to" + ChatBar.CurrentChatPollInterval), ChatBar.ChatPollIntervalTimer = setInterval(function() {
        ChatBar.PollForChats()
    }, ChatBar.CurrentChatPollInterval)));
    ChatBar.ChatThreadAvailable = !0, ChatBar.WindowIsInFocus || (r == 1 ? ChatBar.TogglePageTitleIndicator(Roblox.Chat_v1.Resources.newMessage) : r > 1 && ChatBar.TogglePageTitleIndicator(Roblox.Chat_v1.Resources.newMessages))
}, ChatBar.StopChatPolling = function() {
    clearInterval(ChatBar.ChatPollIntervalTimer), ChatBar.Log("Stopeed polling")
}, ChatBar.PollForChats = function() {
    var i, r, n, t;
    ChatBar.ChatThreadAvailable != !1 && (ChatBar.ChatThreadAvailable = !1, i = ChatBar.PollCount % 10 == 0 ? "true" : "false", r = typeof Party != "undefined" && Party.ActiveParty && !Party.ActiveParty.PartyGuid ? "true" : "false", ChatBar.Log("Polling for Chat...   ChatBar.CurrentChatPollInterval = " + ChatBar.CurrentChatPollInterval), n = {
        openChatTabs: ChatBar.GetOpenChats(),
        fullget: ChatBar.IsFirstLoad,
        activechatids: ChatBar.GetAllChats(),
        getstatusinfo: i,
        getpartystatus: r,
        timeZoneOffset: (new Date).getTimezoneOffset()
    }, ChatBar.DiagnosticsEnabled && (n.diag_poll_count = ChatBar.PollCount, n.diag_page = window.location.pathname + window.location.search, n.diag_state = ChatBar.IsMinimized() ? "minimized" : "maximized", n.diag_interval = ChatBar.CurrentChatPollInterval, t = +new Date, n.diag_since_last = ChatBar.LastPollTime == 0 ? "first_time" : t - ChatBar.LastPollTime, ChatBar.LastPollTime = t), $.getJSON("/chat/get.ashx?reqType=getallchatswithdata", n, function(n) {
        var i, r, t;
        try {
            if (n.Error === "") {
                ChatBar.RawData = n, i = +new Date;
                try {
                    n.PartyStatus != null && Party != null && Party.ActiveParty != null && (ChatBar.Log("party detected, data.PartyStatus = " + n.PartyStatus + ", data.PartyStatus.Error = " + n.PartyStatus.Error), n.PartyStatus.Error != null ? ChatBar.Log("There was an error in party status.  Will not reset the interval") : (Party.ActiveParty = n.PartyStatus, ChatBar.LastActivityTimeInTicks = i, ChatBar.PollingStatus == "idle" && (ChatBar.PollingStatus = "normal", clearInterval(ChatBar.ChatPollIntervalTimer), ChatBar.CurrentChatPollInterval = ChatBar.ChatPollInterval, ChatBar.Log("Status was idle, set to normal, detected a party. set ChatBar.ChatPollInterval = " + ChatBar.CurrentChatPollInterval), ChatBar.ChatPollIntervalTimer = setInterval(function() {
                        ChatBar.PollForChats()
                    }, ChatBar.CurrentChatPollInterval))))
                } catch (f) {}
                ChatBar.ProcessPolledChatData(n.Chats), ChatBar.IsFirstLoad = !1, ChatBar.UnblockAllWindows(), ChatBar.PollCount++, r = 3e4, t = i - ChatBar.LastActivityTimeInTicks, ChatBar.Log("Last activity time: " + ChatBar.LastActivityTimeInTicks + " time since last activity = " + t + " ChatBar.PollingStatus = " + ChatBar.PollingStatus), t > r && ChatBar.PollingStatus == "normal" && ChatBar.WindowIsInFocus == !0 && (ChatBar.PollingStatus = "idle", clearInterval(ChatBar.ChatPollIntervalTimer), ChatBar.CurrentChatPollInterval = ChatBar.IdleChatPollInterval, ChatBar.Log("Detected idle and was normal and window was in focus, set status to idle, interval = " + ChatBar.CurrentChatPollInterval), ChatBar.ChatPollIntervalTimer = setInterval(function() {
                    ChatBar.PollForChats()
                }, ChatBar.CurrentChatPollInterval))
            }
        } catch (u) {}
    }))
}, ChatBar.SetOnline = function(n, t) {
    if (t) ChatBar.ActiveChatsOnlineStatus[n] = !0, $(".friend_dock_friend[userid=" + n + "]").children(".friend_dock_onlinestatus").show(), $(".friend_dock_friend[userid=" + n + "]").children(".friend_dock_offlinestatus").hide(), ChatBar.EnableTextEntry(n);
    else {
        var i = "#" + n + "_friend_dock_chatbox";
        $(i) && $(i).children(".friend_dock_chatbox_currentlocation").html("<p><span style='color: grey'>Offline</span></p>"), ChatBar.ActiveChatsOnlineStatus[n] = !1, $(".friend_dock_friend[userid=" + n + "]").children(".friend_dock_onlinestatus").hide(), $(".friend_dock_friend[userid=" + n + "]").children(".friend_dock_offlinestatus").show(), ChatBar.DisableTextEntry(n)
    }
}, ChatBar.RefreshFriends = function(n) {
    ChatBar.ChatThreadAvailable = !1, $.getJSON("/chat/friendhandler.ashx?cmd=" + n, function(t) {
        var r, i, e, f, u;
        try {
            if (ChatBar.ChatThreadAvailable = !0, t.Error === "") {
                if (r = "#friendsTab_dock_thumbnails", n == "bestfriends" ? r = "#bestFriendsTab_dock_thumbnails" : n == "recents" && (r = "#recentsTab_dock_thumbnails"), t.Count == 0) {
                    $(r).html($(r + "_empty").show());
                    return
                }
                for (n == "bestfriends" ? (ChatBar.BestFriends = t.Users, ChatBar.BestFriendsLastPoll = new Date) : n == "recents" ? (ChatBar.RecentsLastPoll = new Date, ChatBar.Recents = t.Users) : n == "friends" && (ChatBar.Friends = t.Users, ChatBar.FriendsLastPoll = new Date), $(r + "_empty").hide(), i = 0; i < t.Users.length; i++) $(r).children(".friend_dock_friend[userid=" + t.Users[i].ID + "]").length ? (t.Users[i].Online == "true" ? ChatBar.SetOnline(t.Users[i].ID, !0) : ChatBar.SetOnline(t.Users[i].ID, !1), ChatBar.SetPartyInviteStatus(t.Users[i].ID, t.Users[i].ShowInviteLink == "true")) : (e = ChatBar.GenerateThumbFromTemplate(t.Users[i]), f = $(r).append(e), BindDropDown($(f).find(".friendBarDropDown"), t.Users[i]), u = t.Users[i].Online == "true", ChatBar.SetOnline(t.Users[i].ID, u));
                $(".friendBarDropDown").hover(function() {
                    $(this).find("ul").show()
                }, function() {
                    $(this).find("ul").fadeOut("fast")
                }), $(".friendBarDropDown > li").click(function() {
                    $(this).parent().fadeOut("fast")
                })
            } else $("#friend_dock_container").hide()
        } catch (o) {}
    })
}, ChatBar.GenerateThumbFromTemplate = function(n) {
    var t = $("#friend_dock_friendtemplate").html(),
        r = null,
        i;
    return r = n.SenderID !== undefined ? n.SenderID : n.ID, i = null, i = n.SenderUserName !== undefined ? n.SenderUserName : n.Name, t = t.replace(/UID/g, r), t = t.replace(/USERNAMETRUNCATED/g, fitStringToWidth(i, 55, "friend_dock_username_href")), t = t.replace(/USERNAME/g, i), t = ChatBar.IsMinimized() ? t.replace(/thumbnail_holder/g, " min_src='" + n.Thumbnail + "' ") : t.replace(/thumbnail_holder/g, " src='" + n.Thumbnail + "' "), t = n.Online == "true" && n.CanAcceptChats == "true" ? t.replace("startchattingdisplay", "style='display:block;'") : t.replace("startchattingdisplay", "style='display:none;'"), t = n.Online == "true" ? t.replace("startpartydisplay", "style='display:block;'") : t.replace("startpartydisplay", "style='display:none;'")
}, ChatBar.RemoveActiveChat = function(n) {
    if (n) {
        var t = $(n).attr("userid");
        $.getJSON("/chat/utility.ashx?reqtype=removechat&targetuserid=" + t, function(n) {
            n.Result == "true" && ($("#chatsTab_dock_thumbnails_chat .friend_dock_friend[userid=" + t + "]").remove(), ChatBar.CloseChat($(".friend_dock_chatbox[userid=" + t + "]")))
        })
    }
}, ChatBar.DisplayLocalMessageInWindow = function(n, t) {
    $("#" + n + "_friend_dock_chatbox_chat").append("<b><span style='color: #0066CC'>" + ChatBar.MyUserName + "</span></b>: " + t + "<br /><br />"), $("#" + n + "_friend_dock_chatbox_chat").prop({
        scrollTop: $("#" + n + "_friend_dock_chatbox_chat").prop("scrollHeight")
    })
}, ChatBar.SendMessage = function(n) {
    var i = n.parents(".friend_dock_chatbox").attr("userid"),
        t = $.trim(n.val()),
        r;
    t != "" && (ChatBar.LastActivityTimeInTicks = +new Date, ChatBar.PollingStatus == "idle" && (ChatBar.PollingStatus = "normal", clearInterval(ChatBar.ChatPollIntervalTimer), ChatBar.CurrentChatPollInterval = ChatBar.ChatPollInterval, ChatBar.Log("Sent message, was idle, set mode to normal and interval = " + ChatBar.CurrentChatPollInterval), ChatBar.ChatPollIntervalTimer = setInterval(function() {
        ChatBar.PollForChats()
    }, ChatBar.CurrentChatPollInterval)), r = t.escapeHTML(), ChatBar.DisplayLocalMessageInWindow(i, r), n.val(""), $.ajax({
        url: "/chat/send.ashx?recipientUserId=" + i,
        type: "POST",
        data: "message=" + encodeURIComponent(t),
        success: function(n) {
            n.Error != "" && n.Error != "ModeratedMessage" && ChatBar.DisableTextEntry(i)
        }
    }))
}, ChatBar.TogglePanel = function(n) {
    var i, t;
    n != ChatBar.CurrentTabID && (i = n.substr(0, n.indexOf("_")), $("#" + i).removeClass("tab_white19h"), $("#" + i).addClass("tab_white19hselected"), ChatBar.CurrentTabID != null && (t = ChatBar.CurrentTabID.substr(0, ChatBar.CurrentTabID.indexOf("_")), $("#" + t).removeClass("tab_white19hselected"), $("#" + t).addClass("tab_white19h")), ChatBar.CurrentTabID != null && $("#" + ChatBar.CurrentTabID).hide(), ChatBar.CurrentTabID == "friendsTab_dock_thumbnails" ? clearInterval(ChatBar.FriendsPollIntervalTimer) : ChatBar.CurrentTabID == "bestFriendsTab_dock_thumbnails" ? clearInterval(ChatBar.BestFriendsPollIntervalTimer) : ChatBar.CurrentTabID == "recentsTab_dock_thumbnails" && clearInterval(ChatBar.RecentsPollIntervalTimer), ChatBar.PollIfNecessary(n), $("#" + n).show(), ChatBar.CurrentTabID = n)
}, ChatBar.PollIfNecessary = function(n) {
    ChatBar.IsMinimized() || (n == "friendsTab_dock_thumbnails" ? (ChatBar.FriendsPollIntervalTimer = setInterval(function() {
        ChatBar.RefreshFriends("friends")
    }, ChatBar.FriendsPollInterval), (ChatBar.FriendsLastPoll == null || +new Date - ChatBar.FriendsLastPoll.getTime() > ChatBar.FriendsPollInterval) && ChatBar.RefreshFriends("friends")) : n == "bestFriendsTab_dock_thumbnails" ? (ChatBar.BestFriendsPollIntervalTimer = setInterval(function() {
        ChatBar.RefreshFriends("bestfriends")
    }, ChatBar.BestFriendsPollInterval), (ChatBar.BestFriendsLastPoll == null || +new Date - ChatBar.BestFriendsLastPoll.getTime() > ChatBar.BestFriendsPollInterval) && ChatBar.RefreshFriends("bestfriends")) : n == "recentsTab_dock_thumbnails" && (ChatBar.RecentsPollIntervalTimer = setInterval(function() {
        ChatBar.RefreshFriends("recents")
    }, ChatBar.RecentsPollInterval), (ChatBar.RecentsLastPoll == null || +new Date - ChatBar.RecentsLastPoll.getTime() > ChatBar.RecentsPollInterval) && ChatBar.RefreshFriends("recents")))
}, ChatBar.SaveStateToClient = function() {
    var h = [],
        n = 0,
        o, s, f, i, r, u, t, e;
    $(".friend_dock_chatbox:visible").each(function() {
        var t = {};
        t.userid = $(this).attr("userid"), t.username = $(this).children(".friend_dock_chatbox_titlebar").children(".friend_dock_chatbox_username").children(".friend_dock_chatbox_username_display").html(), h[n] = t, n++
    }), o = $.toJSON(h), s = "friends", $("#friend_dock_chatzone:visible").length && (s = "chat"), f = "true", $("#friend_dock_container:visible").length && (f = "false"), i = "false", $("#partycontainer").is(":visible") && (i = "true"), $.cookies.set("ChatWindows", o), $.cookies.set("CurrentTabID", ChatBar.CurrentTabID), $.cookies.set("IsMinimized", f), $.cookies.set("PartyWindowVisible", i), ChatBar.AlreadyReceivedMessages.length && $.cookies.set("RecMsgs", ChatBar.AlreadyReceivedMessages), r = [], u = 0;
    for (n in ChatBar.ActiveChatsOnlineStatus) t = {}, t.userid = n, t.online = ChatBar.ActiveChatsOnlineStatus[n], r[u] = t, u++;
    e = $.toJSON(r), $.cookies.set("OnlineStatuses", e)
}, ChatBar.LoadStateFromClient = function() {
    var i = null,
        r = null,
        u = null,
        f = null,
        t, e, n;
    if (/MSIE (\d+\.\d+);/.test(navigator.userAgent) && RegExp.$1 < 8) {
        try {
            i = eval("(" + $.cookies.get("ChatWindows") + ")")
        } catch (s) {}
        try {
            r = eval("(" + $.cookies.get("OnlineStatuses") + ")")
        } catch (s) {}
        try {
            u = eval("(" + $.cookies.get("PartyWindowVisible") + ")")
        } catch (s) {}
        try {
            f = $.cookies.get("IsMinimized"), f || $("#ChatContainer").width("100%")
        } catch (s) {}
        t = $.cookies.get("RecMsgs"), t != null && t.length && (ChatBar.AlreadyReceivedMessages = eval("(" + t + ")"))
    } else i = $.cookies.get("ChatWindows"), r = $.cookies.get("OnlineStatuses"), u = $.cookies.get("PartyWindowVisible"), f = $.cookies.get("IsMinimized"), f || $("#ChatContainer").width("100%"), t = $.cookies.get("RecMsgs"), t != null && t.length && (ChatBar.AlreadyReceivedMessages = t);
    if (e = $.cookies.get("CurrentTabID"), r != null)
        for (n = 0; n < r.length; n++) ChatBar.ActiveChatsOnlineStatus[r[n].userid] = r[n].online;
    u != null && (u == !0 || u == "true") && Party.ToggleTab(!0);
    try {
        if (i != null)
            for (n = 0; n < i.length; n++) ChatBar.OpenChat(i[n].userid, i[n].username);
        e != null ? ChatBar.TogglePanel(e) : ChatBar.TogglePanel("friendsTab_dock_thumbnails")
    } catch (o) {}
}, ChatBar.IsMinimized = function() {
    return $("#friend_dock_minimized_container").is(":visible")
};