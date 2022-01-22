function openVideoPreroll2(n) {
    Roblox.VideoPreRoll.test(n)
}

function flashCheck(n) {
    var i = !1,
        t, r;
    if (window.ActiveXObject) try {
        t = new ActiveXObject("ShockwaveFlash.ShockwaveFlash." + n), i = !0
    } catch (u) {} else navigator.plugins && navigator.mimeTypes.length > 0 && (t = navigator.plugins["Shockwave Flash"], t && (r = navigator.plugins["Shockwave Flash"].description.replace(/.*\s(\d+\.\d+).*/, "$1"), r >= n && (i = !0)));
    return i
}
typeof Roblox == "undefined" && (Roblox = {}), Roblox.VideoPreRoll = {
    newValue: "",
    showVideoPreRoll: !1,
    videoInitialized: !1,
    videoStarted: !1,
    videoCompleted: !1,
    videoSkipped: !1,
    videoCancelled: !1,
    videoErrored: !1,
    videoOptions: {
        key: "integration_test",
        companionId: "videoPrerollCompanionAd"
    },
    myvpaidad: null,
    loadingBarMaxTime: 3e4,
    loadingBarCurrentTime: 0,
    loadingBarIntervalID: 0,
    loadingBarID: "videoPrerollLoadingBar",
    loadingBarInnerID: "videoPrerollLoadingBarCompleted",
    loadingBarPercentageID: "videoPrerollLoadingPercent",
    videoLoadingTimeout: 7e3,
    videoPlayingTimeout: 23e3,
    videoLogNote: "",
    logsEnabled: !1,
    excludedPlaceIds: "",
    specificAdOnPlacePageEnabled: !1,
    specificAdOnPlacePageId: 0,
    specificAdOnPlacePageCategory: "",
    specificAdOnPlacePage2Enabled: !1,
    specificAdOnPlacePage2Id: 0,
    specificAdOnPlacePage2Category: "",
    checkEligibility: function() {
        Roblox.VideoPreRoll.showVideoPreRoll && (flashCheck(8) ? typeof __adaptv__ == "undefined" ? (Roblox.VideoPreRoll.videoLogNote = "NoAdapTv", Roblox.VideoPreRoll.showVideoPreRoll = !1) : Roblox.Client.IsRobloxInstalled() ? Roblox.Client.isIDE() ? (Roblox.VideoPreRoll.videoLogNote = "RobloxStudio", Roblox.VideoPreRoll.showVideoPreRoll = !1) : Roblox.Client.isRobloxBrowser() ? (Roblox.VideoPreRoll.videoLogNote = "RobloxPlayer", Roblox.VideoPreRoll.showVideoPreRoll = !1) : window.chrome && window.location.hash == "#chromeInstall" && (Roblox.VideoPreRoll.showVideoPreRoll = !1) : Roblox.VideoPreRoll.showVideoPreRoll = !1 : (Roblox.VideoPreRoll.videoLogNote = "NoFlash", Roblox.VideoPreRoll.showVideoPreRoll = !1))
    },
    isExcluded: function() {
        var t, n;
        if (Roblox.VideoPreRoll.showVideoPreRoll && Roblox.VideoPreRoll.excludedPlaceIds !== "" && (t = Roblox.VideoPreRoll.excludedPlaceIds.split(","), typeof play_placeId != "undefined"))
            for (n = 0; n < t.length; n++)
                if (play_placeId == t[n]) return Roblox.VideoPreRoll.videoLogNote = "ExcludedPlace", !0;
        return !1
    },
    start: function() {
        var n, r, i, t;
        this.videoInitialized = !0, this.videoStarted = !1, this.videoCancelled = !1, this.videoCompleted = !1, this.videoSkipped = !1, this.loadingBarCurrentTime = 0, this.videoLogNote = "", Roblox.VideoPreRoll.specificAdOnPlacePageEnabled && typeof play_placeId != "undefined" && (n = "," + Roblox.VideoPreRoll.specificAdOnPlacePageCategory, play_placeId == Roblox.VideoPreRoll.specificAdOnPlacePageId && Roblox.VideoPreRoll.videoOptions.categories.indexOf(n) == -1 && (Roblox.VideoPreRoll.videoOptions.categories += n)), Roblox.VideoPreRoll.specificAdOnPlacePage2Enabled && typeof play_placeId != "undefined" && (n = "," + Roblox.VideoPreRoll.specificAdOnPlacePage2Category, play_placeId == Roblox.VideoPreRoll.specificAdOnPlacePage2Id && Roblox.VideoPreRoll.videoOptions.categories.indexOf(n) == -1 && (Roblox.VideoPreRoll.videoOptions.categories += n)), r = __adaptv__, this.myvpaidad = new r.ads.vpaid.VPAIDAd("videoPrerollMainDiv"), i = 1e3, LoadingBar.init(this.loadingBarID, this.loadingBarInnerID, this.loadingBarPercentageID), this.loadingBarIntervalID = setInterval(function() {
            Roblox.VideoPreRoll.loadingBarCurrentTime += i, LoadingBar.update(Roblox.VideoPreRoll.loadingBarID, Roblox.VideoPreRoll.loadingBarCurrentTime / Roblox.VideoPreRoll.loadingBarMaxTime)
        }, i), t = r.ads.vpaid.VPAIDEvent;
        this.myvpaidad.on(t.AdLoaded, function(n) {
            Roblox.VideoPreRoll._onVideoLoaded(n)
        });
        this.myvpaidad.on(t.AdStarted, function(n) {
            Roblox.VideoPreRoll._onVideoStart(n)
        });
        this.myvpaidad.on(t.AdStopped, function(n) {
            Roblox.VideoPreRoll._onVideoComplete(n)
        });
        this.myvpaidad.on(t.AdError, function(n) {
            Roblox.VideoPreRoll._onVideoError(n)
        });
        try {
            this.myvpaidad.initAd(391, 312, this.videoOptions)
        } catch (u) {
            f()
        }
    },
    error: function() {
        clearInterval(loadingBarInterval)
    },
    cancel: function() {
        this.videoCancelled = !0, $.modal.close()
    },
    skip: function() {
        this.videoCompleted = !0, this.videoSkipped = !0, this.showVideoPreRoll = !1
    },
    close: function() {
        MadStatus.running && MadStatus.stop(""), RobloxLaunch.launcher && (RobloxLaunch.launcher._cancelled = !0), clearInterval(this.loadingBarIntervalID), LoadingBar.dispose(this.loadingBarID);
        try {
            this.myvpaidad.stopAd()
        } catch (n) {}
        this.isPlaying() && (this.videoCancelled = !0), $.modal.close(), this.logVideoPreRoll()
    },
    _onVideoError: function f() {
        this.videoCompleted = !0, this.videoErrored = !0
    },
    _onVideoLoaded: function(n) {
        try {
            this.myvpaidad.startAd()
        } catch (t) {
            f(n)
        }
    },
    _onVideoStart: function() {
        this.videoStarted = !0
    },
    _onVideoComplete: function() {
        this.videoStarted && this.videoCancelled == !1 && (this.videoCompleted = !0, this.showVideoPreRoll = !1, this.newValue != "" && $.cookie("RBXVPR", this.newValue, 180))
    },
    logVideoPreRoll: function() {
        if (Roblox.VideoPreRoll.logsEnabled) {
            var n = "";
            if (Roblox.VideoPreRoll.videoCompleted) n = "Complete", Roblox.VideoPreRoll.videoLogNote == "" && (Roblox.VideoPreRoll.videoLogNote = "NoTimeout"), Roblox.VideoPreRoll.logsEnabled = !1;
            else if (Roblox.VideoPreRoll.videoCancelled) n = "Cancelled", Roblox.VideoPreRoll.videoLogNote = RobloxLaunch.state;
            else if (Roblox.VideoPreRoll.videoInitialized == !1 && Roblox.VideoPreRoll.videoLogNote != "") n = "Failed", Roblox.VideoPreRoll.logsEnabled = !1;
            else return;
            GoogleAnalyticsEvents.FireEvent(["PreRoll", n, Roblox.VideoPreRoll.videoLogNote])
        }
    },
    isPlaying: function() {
        return Roblox.VideoPreRoll.videoInitialized ? (Roblox.VideoPreRoll.videoInitialized && !Roblox.VideoPreRoll.videoStarted && Roblox.VideoPreRoll.loadingBarCurrentTime > Roblox.VideoPreRoll.videoLoadingTimeout && (Roblox.VideoPreRoll.videoCompleted = !0, Roblox.VideoPreRoll.videoLogNote = "LoadingTimeout"), Roblox.VideoPreRoll.videoStarted && !Roblox.VideoPreRoll.videoCompleted && Roblox.VideoPreRoll.loadingBarCurrentTime > Roblox.VideoPreRoll.videoPlayingTimeout && (Roblox.VideoPreRoll.videoCompleted = !0, Roblox.VideoPreRoll.videoLogNote = "PlayingTimeout"), !Roblox.VideoPreRoll.videoCompleted) : !1
    },
    correctIEModalPosition: function(n) {
        if (n.container.innerHeight() <= 30) {
            var i = $("#videoPrerollPanel"),
                t = -Math.floor(i.innerHeight() / 2);
            i.css({
                position: "relative",
                top: t + "px"
            }), n.container.find(".VprCloseButton").css({
                top: t - 10 + "px",
                "z-index": "1003"
            })
        }
    },
    test: function() {
        _popupOptions = {
            escClose: !0,
            opacity: 80,
            overlayCss: {
                backgroundColor: "#000"
            },
            onShow: function(n) {
                Roblox.VideoPreRoll.correctIEModalPosition(n), Roblox.VideoPreRoll.start()
            },
            onClose: function() {
                Roblox.VideoPreRoll.close()
            },
            closeHTML: '<a href="#" class="ImageButton closeBtnCircle_35h ABCloseCircle VprCloseButton"></a>'
        }, $("#videoPrerollPanel").modal(_popupOptions), MadStatus.running || (MadStatus.init($("#videoPrerollPanel").find(".MadStatusField"), $("#videoPrerollPanel").find(".MadStatusBackBuffer"), 2e3, 800), MadStatus.start()), $("#videoPrerollPanel").find(".MadStatusStarting").css("display", "none"), $("#videoPrerollPanel").find(".MadStatusSpinner").css("visibility", status === 3 || status === 4 || status === 5 ? "hidden" : "visible")
    }
};
var LoadingBar = {
    bars: [],
    init: function(n, t, i, r) {
        var u = this.get(n);
        u == null && (u = {}), u.barID = n, u.innerBarID = t, u.percentageID = i, typeof r == "undefined" && (u.percentComplete = 0), this.bars.push(u), this.update(n, u.percentComplete)
    },
    get: function(n) {
        for (var t = 0; t < this.bars.length; t++)
            if (this.bars[t].barID == n) return this.bars[t];
        return null
    },
    dispose: function(n) {
        for (var t = 0; t < this.bars.length; t++) this.bars[t].barID == n && this.bars.splice(t, 1)
    },
    update: function(n, t) {
        var i = this.get(n),
            u, r;
        i && (t > 1 && (t = 1), u = $("#" + n).width(), r = Math.round(u * t), $("#" + i.innerBarID).animate({
            width: r
        }, 200, "swing"), i.percentageID && $("#" + i.percentageID).length > 0 && $("#" + i.percentageID).html(Math.round(t * 100) + "%"), i.percentComplete = t)
    }
};