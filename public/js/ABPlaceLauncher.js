typeof Roblox == "undefined" && (Roblox = {});
var RobloxABLaunch = {
    launchGamePage: null,
    launcher: null
};
RobloxABLaunch.RequestGame = function(n, t, i) {
    RobloxPlaceLauncherService.LogJoinClick(), RobloxABLaunch.launcher === null && (RobloxABLaunch.launcher = new Roblox.ABPlaceLauncher), RobloxABLaunch.launcher.RequestGame(t, i)
}, RobloxABLaunch.RequestGroupBuildGame = function(n, t) {
    RobloxPlaceLauncherService.LogJoinClick(), RobloxABLaunch.launcher === null && (RobloxABLaunch.launcher = new Roblox.ABPlaceLauncher), RobloxABLaunch.launcher.RequestGroupBuildGame(t)
}, RobloxABLaunch.RequestGameJob = function(n, t, i, r) {
    RobloxPlaceLauncherService.LogJoinClick(), RobloxABLaunch.launcher === null && (RobloxABLaunch.launcher = new Roblox.ABPlaceLauncher), RobloxABLaunch.launcher.RequestGameJob(t, i, r)
}, RobloxABLaunch.StartGame = function(n, t, i, r) {
    i = i.replace("http://", "https://");
    try {
        typeof window.external != "undefined" && window.external.IsRobloxABApp ? window.external.StartGame(r, i, n) : RobloxABLaunch.LogException("RobloxABLaunch used by non AB client.", "RobloxABLaunch.StartGame from non AB", "49", window.navigator.userAgent, "JavascriptExceptions")
    } catch (f) {
        return RobloxABLaunch.LogException(f.message, "RobloxABLaunch.StartGame Error", f.name, window.navigator.userAgent, "JavascriptExceptions"), !1
    }
    return !0
}, RobloxABLaunch.LogException = function(n, t, i, r, u) {
    var f = {};
    f.msg = n, f.url = t, f.line = i, f.ua = r, f.category = u, f.shard = "WebMetrics", f.eventName = "JavascriptExceptionLoggingEvent", RobloxEventManager.triggerEvent("JavascriptExceptionLoggingEvent", f)
}, Roblox.ABPlaceLauncher = function() {}, Roblox.ABPlaceLauncher.prototype = {
    _onGameStatus: function(n) {
        if (n.status === 2) RobloxABLaunch.StartGame(n.joinScriptUrl, "Join", n.authenticationUrl, n.authenticationTicket);
        else if (n.status < 2 || n.status === 6) {
            var r = function(n, t) {
                    t._onGameStatus(n)
                },
                u = function(n, t) {
                    t._onGameError(n)
                },
                t = this,
                i = function() {
                    RobloxPlaceLauncherService.CheckGameJobStatus(n.jobId, r, u, t)
                };
            window.setTimeout(i, 2e3)
        }
    },
    _onGameError: function(n) {
        console.log("An error occurred. Please try again later -" + n)
    },
    _startUpdatePolling: function(n) {
        try {
            n()
        } catch (t) {
            n()
        }
    },
    RequestGame: function(n, t) {
        var f = function(n, t) {
                t._onGameStatus(n)
            },
            u = function(n, t) {
                t._onGameError(n)
            },
            e = this,
            i = !1,
            r;
        return typeof Party != "undefined" && typeof Party.AmILeader == "function" && (i = Party.AmILeader()), r = function() {
            RobloxPlaceLauncherService.RequestGame(n, i, t, f, u, e)
        }, this._startUpdatePolling(r), !1
    },
    RequestGroupBuildGame: function(n) {
        var r = function(n, t) {
                t._onGameStatus(n, !0)
            },
            u = function(n, t) {
                t._onGameError(n)
            },
            t = this,
            i = function() {
                RobloxPlaceLauncherService.RequestGroupBuildGame(n, r, u, t)
            };
        return this._startUpdatePolling(i), !1
    },
    RequestGameJob: function(n, t, i) {
        var f = function(n, t) {
                t._onGameStatus(n)
            },
            e = function(n, t) {
                t._onGameError(n)
            },
            r = this,
            u = function() {
                RobloxPlaceLauncherService.RequestGameJob(n, t, i, f, e, r)
            };
        return this._startUpdatePolling(u), !1
    },
    dispose: function() {
        Roblox.ABPlaceLauncher.callBaseMethod(this, "dispose")
    }
};