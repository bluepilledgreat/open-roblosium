var Party = {};
Party.ToggleTab = function(n) {
    n == null ? ($("#partycontainer").toggle(), $("#partyTab").toggleClass("tab_white19h"), $("#partyTab").toggleClass("tab_white19hselected")) : n == !0 ? ($("#partycontainer").show(), $("#partyTab").removeClass("tab_white19h"), $("#partyTab").addClass("tab_white19hselected")) : n == !1 && ($("#partycontainer").hide(), $("#partyTab").addClass("tab_white19h"), $("#partyTab").removeClass("tab_white19hselected"))
}, Party.SetActiveView = function(n) {
    $(".partyWindow").hide(), $("#" + n).show(), Party.ActiveView = n
}, Party.CreateNew = function() {
    Party.ActiveView != "party_my" && (Party.SetActiveView("party_my"), $("#chat_messages").html("")), $.getJSON("/chat/party.ashx", {
        reqtype: "create"
    }, function(n) {
        return n.Error ? !1 : (Party.ProcessPolledData(n), Party.FirstLoad = !0, Party.Refresh(), Party.PollForUpdates(), Party.ToggleTab(!0), !0)
    })
}, Party.DoInvite = function(n) {
    Party.InviteUser(document.getElementById(n).value), document.getElementById(n).value = ""
}, Party.GenerateReportUserURLHTML = function(n) {
    var t = "";
    return t = "(<span style='text-decoration: none; color: Red; cursor: pointer' ", t += " onclick=\"if (confirm('" + Party.Resources.areYouSureReport + n.UserName + "?' ) )", t += " { window.location = '/abusereport/partychat.aspx?PartyGuid=" + Party.ActiveParty.PartyGuid + "&UserID=" + n.UserID + "' ;", t += ' return true; } else { return false; } ">' + Party.Resources.report + "</span>)"
}, Party.GenerateKickUserHTML = function(n) {
    return "<div class='kickuser btn_red21h' id='party_kick_" + n + "' ><a href='#' onclick='Party.RemoveUser(" + n + "); return false;'>" + Party.Resources.kick + "</a></div>"
}, Party.GetMemberListAsHtml = function() {
    for (var r = "", f = $("#partyMemberTemplate").html(), u = Party.AmILeader(), n, i, t = 0; t < Party.ActiveParty.Members.length; t++) n = f.replace(/UID/g, Party.ActiveParty.Members[t].UserID), (Party.ActiveParty.Members[t].IsOnline == !0 || Party.ActiveParty.Members[t].IsOnline == "True") && (n = n.replace("friend_dock_offlinestatus", "friend_dock_onlinestatus")), n = n.replace("[PARTY_MEMBER_THUMBNAIL]", "<img src='" + Party.ActiveParty.Members[t].Thumbnail + "' style='width:24px;height:24px'/>"), n = t == 0 ? n.replace("[PARTY_MEMBER_NAME]", "<strong>" + Party.ActiveParty.Members[t].UserName + "</strong>") : n.replace("[PARTY_MEMBER_NAME]", Party.ActiveParty.Members[t].UserName), n = u && Party.ActiveParty.Members[t].UserID != Party.CurrentUserID ? n.replace("[PARTY_KICK_MEMBER]", Party.GenerateKickUserHTML(Party.ActiveParty.Members[t].UserID)) : n.replace("[PARTY_KICK_MEMBER]", ""), Party.ActiveParty.Members[t].Pending == !1 ? (i = "", Party.ActiveParty.Members[t].UserID != Party.CurrentUserID && (i = Party.GenerateReportUserURLHTML(Party.ActiveParty.Members[t])), n = n.replace("[PARTY_MEMBER_REPORT]", i)) : n = n.replace("[PARTY_MEMBER_REPORT]", "<span style='color: grey'>" + Party.Resources.pending + "</span>"), r += n + "";
    return r
}, Party.ProcessKey = function(n, t) {
    return (t == null && (t = window.event), t.keyCode == 13) ? (Party.DoInvite(n), !1) : !0
}, Party.Refresh = function() {
    var n, i, r, e, u, t, f;
    if (Party.ActiveParty.PartyGuid)
        if (Party.ActiveParty.Members.length > 1) {
            for (n = 0; n < Party.ActiveParty.Members.length; n++)
                if (Party.ActiveParty.Members[n].UserID == Party.CurrentUserID) {
                    if (Party.ActiveParty.Members[n].Pending == !0 && Party.ActiveView != "party_pending") r = Party.GetMemberListAsHtml(), $("#party_invite_list").html(r), Party.SetActiveView("party_pending"), $("#invite_header").html($("#invite_header").html().replace("RobloTim", Party.ActiveParty.CreatorName)), Party.ToggleTab(!0), i = document.title, document.title = Party.Resources.partyInvite, document.getElementById("party_pending_title").className = "title title_flash", setTimeout('document.title = "' + i + "\"; document.getElementById('party_pending_title').className = 'title';", 500), setTimeout('document.title = "' + Party.Resources.partyInvite + "\"; document.getElementById('party_pending_title').className = 'title title_flash';", 1e3), setTimeout('document.title = "' + i + "\"; document.getElementById('party_pending_title').className = 'title';", 1500), setTimeout('document.title = "' + Party.Resources.partyInvite + "\"; document.getElementById('party_pending_title').className = 'title title_flash';", 2e3), setTimeout('document.title = "' + i + "\"; document.getElementById('party_pending_title').className = 'title';", 2500), setTimeout('document.title = "' + Party.Resources.partyInvite + "\"; document.getElementById('party_pending_title').className = 'title title_flash';", 3e3), setTimeout('document.title = "' + i + "\"; document.getElementById('party_pending_title').className = 'title';", 3500);
                    else if (Party.ActiveParty.Members[n].Pending == !1) {
                        if (r = Party.GetMemberListAsHtml(), $("#party_member_list").html(r), Party.ActiveView != "party_my" && (Party.SetActiveView("party_my"), $("#chat_messages").html("")), Party.ActiveParty.Members[n].HasUpdates || Party.FirstLoad == !0) {
                            for (Party.FirstLoad = !1, e = "", u = Party.ActiveParty.Conversation, t = 0; t < u.length; t++) e += "<b><span style='color: #0066CC'>" + u[t].SenderUserName + "</span></b>: " + u[t].Message + "<br /><br />";
                            f = $("#chat_messages"), $(f).html(""), $(f).append(e), typeof ChatBar.PlaySound == "function" && ChatBar.PlaySound("msgrec"), window.setTimeout(function() {
                                $("#chat_messages").prop({
                                    scrollTop: $("#chat_messages").prop("scrollHeight")
                                })
                            }, 300)
                        }
                        Party.CurrentUserID != Party.ActiveParty.CreatorID && $("#party_invite_instructions").hide(), Party.PlayEnabled && Party.CurrentUserID != Party.ActiveParty.CreatorID ? $("#party-auto-follow-setting").show() : $("#party-auto-follow-setting").hide(), Party.PlayEnabled != !0 ? ($("#party_game_thumb").html(""), $("#party_game_name").html(""), $("#party_game_follow_me").hide()) : Party.ActiveParty.PartyGameAsset != null ? (Party.ActiveParty.PartyGameThumbnail == null || Party.ActiveParty.PartyGameThumbnail.IsFinal == !1 ? $("#party_game_thumb").html("<a href='/Item.aspx?id=" + Party.ActiveParty.PartyGameAsset.ID + "'><img src='/images/empty.png' width='75' height='75' alt='" + Party.ActiveParty.PartyGameAsset.Name.escapeHTML() + "' /></a>") : $("#party_game_thumb").html("<a href='/Item.aspx?id=" + Party.ActiveParty.PartyGameAsset.ID + "'><img src='" + Party.ActiveParty.PartyGameThumbnail.Url + "' alt='" + Party.ActiveParty.PartyGameAsset.Name.escapeHTML() + "' /></a>"), $("#party_game_name").html(Party.ActiveParty.PartyGameAsset.Name), $("#party_game_follow_me").show(), Party.ToggleTab(!0), $("#party_game_follow_me").className = Party.ActiveParty.PartyLeaderIsInGame == !1 || Party.ActiveParty.PartyLeaderIsInGame == "False" ? "followme_gray19h" : "followme_green19h") : ($("#party_game_thumb").html(""), $("#party_game_name").html(""), $("#party_game_follow_me").hide())
                    }
                    break
                }
        } else Party.SetActiveView("party_none"), Party.RemoveUser(Party.CurrentUserID);
    else Party.SetActiveView("party_none")
}, Party.PollForUpdates = function() {
    Party.PollThreadAvailable && Party.ActiveParty.PartyGuid && (Party.PollThreadAvailable = !1, $.getJSON("/chat/party.ashx", {
        reqtype: "get"
    }, function(n) {
        Party.ProcessPolledData(n), Party.PollThreadAvailable = !0, Party.Refresh()
    }))
}, Party.SendMessage = function(n) {
    if (n != "") {
        var t = n.escapeHTML();
        $("#chat_messages").append("<b><span style='color: #0066CC'>" + Party.CurrentUserName + "</span></b>: " + t + "<br /><br />"), $("#chat_messages").prop({
            scrollTop: $("#chat_messages").prop("scrollHeight")
        }), $("#comments").val(""), $.ajax({
            url: "/chat/send.ashx?partyGuid=" + Party.ActiveParty.PartyGuid,
            type: "POST",
            data: "message=" + encodeURIComponent(n),
            success: function(n) {
                n.Error != "" && alert(n.Error)
            }
        })
    }
}, Party.RemoveUser = function(n) {
    $("#party_kick_" + n).html("<img src='/images/spinners/waiting.gif' />"), $.getJSON("/chat/party.ashx", {
        reqtype: "removeUser",
        userid: n
    }, function(t) {
        t.Error != "" ? alert(t.Error) : ($("#party_kick_" + n).remove(), $("#party_pendinguserid_" + n).remove(), Party.PollForUpdates())
    })
}, Party.InviteUser = function(n) {
    n = n.replace(/^\s+|\s+$/g, ""), n == null || n == "" ? alert(Party.Resources.inviteInstructions) : Party.ActiveParty == null || typeof Party.ActiveParty.Members == "undefined" ? (Party.SetActiveView("party_loading"), $.getJSON("/chat/party.ashx", {
        reqtype: "createAndInvite",
        userName: n
    }, function(n) {
        if (n.Error) return alert(n.Error), Party.PollForUpdates(), Party.SetActiveView("party_none"), !0;
        Party.ProcessPolledData(n), Party.SetActiveView("party_my"), Party.FirstLoad = !0, Party.Refresh(), Party.PollForUpdates(), Party.ToggleTab(!0)
    })) : (typeof Party.ActiveParty.Error == "undefined" || Party.ActiveParty.Error == "") && (Party.ActiveParty.Members.length >= Party.MaxPartySize ? alert(Party.Resources.partyFull) : $.getJSON("/chat/party.ashx", {
        reqtype: "inviteUser",
        userName: n
    }, function(n) {
        n.Error && alert(n.Error), Party.PollForUpdates()
    }))
}, Party.AcceptInvite = function() {
    $.getJSON("/chat/party.ashx", {
        reqtype: "acceptInvite"
    }, function(n) {
        n.Error && alert(n.Error), Party.FirstLoad = !0, Party.ProcessPolledData(n), Party.Refresh()
    })
}, Party.DeclineInvite = function() {
    Party.SetActiveView("party_none"), $.getJSON("/chat/party.ashx", {
        reqtype: "removeUser",
        userID: Party.CurrentUserID
    }, function(n) {
        Party.ProcessPolledData(n), Party.Refresh()
    })
}, Party.AmILeader = function() {
    return Party.ActiveParty && Party.CurrentUserID == Party.ActiveParty.CreatorID
}, Party.ProcessPolledData = function(n) {
    var i, r, t, u;
    if (n != null) {
        if (Party.ActiveParty = n, Party.ActiveParty.Members)
            for (i = 0; i < Party.ActiveParty.Members.length; i++) Party.ActiveParty.Members[i].UserID == Party.CurrentUserID && (r = Party.ActiveParty.Members[i]);
        Party.AmILeader() || Party.ActiveParty.PartyGuid == null || Party.ActiveParty.PartyGameAsset == null || r == null || r.Pending ? (typeof Party.ActiveParty.Members == "undefined" || Party.ActiveParty.Members.length <= 1) && Party.SetActiveView("party_none") : (t = Party.Cookie.GetObj(), t.AcknowledgedGameGuid && t.AcknowledgedGameGuid == Party.ActiveParty.GameGuid || (u = Party.ActiveParty.PartyGameAsset.Name, (r.AutoFollowPartyLeader || confirm(Party.Resources.joinConfirm1 + u + Party.Resources.joinConfirm2 + "\n\n" + Party.Resources.joinConfirm3)) && Party.JoinGameWithParty(), t.AcknowledgedGameGuid = Party.ActiveParty.GameGuid, Party.Cookie.SetObj(t)))
    }
}, Party.JoinGameWithParty = function() {
    var n = Party.ActiveParty.PartyGameAsset.ID,
        i, t;
    play_placeId = n, i = Party.ActiveParty.PartyGuid, t = Party.ActiveParty.GameGuid, RobloxLaunch._GoogleAnalyticsCallback = function() {
        GoogleAnalyticsEvents.FireEvent("Play", "User"), RobloxEventManager.triggerEvent("rbx_evt_play_user", {
            placeId: n
        })
    }, Roblox.Client.WaitForRoblox(function() {
        RobloxLaunch.RequestPlayWithParty("PlaceLauncherStatusPanel", n, i, t)
    })
}, Party.OnPageLoad = function() {
    $(".closeparty").click(function() {
        Party.ToggleTab(null)
    }), $("#comments").live("keydown", function(n) {
        return n.keyCode == 13 ? (Party.SendMessage($("#comments").val()), !1) : !0
    }), $("#party_my .main").css("max-height", $(window).height() - 150), $(".party_invite_box").css("color", "#888"), $(".party_invite_box").val("Enter username"), $(".party_invite_box").focus(function() {
        $(this).css("color", "#000"), this.value == Party.Resources.enterUserName ? this.value = "" : this.select()
    }), $(".party_invite_box").blur(function() {
        $.trim(this.value) == "" && ($(this).css("color", "#888"), this.value = Party.Resources.enterUserName)
    }), Party.Refresh(), Party.PollIntervalTimer = setInterval(function() {
        Party.PollForUpdates()
    }, 3e3)
};