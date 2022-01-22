var RBX = {},
    RobloxLaunchStates = {
        StartingServer: "StartingServer",
        StartingClient: "StartingClient",
        Upgrading: "Upgrading",
        None: "None"
    },
    RobloxLaunch = {
        launchGamePage: "/install/download.aspx",
        launcher: null,
        googleAnalyticsCallback: function() {
            RobloxLaunch._GoogleAnalyticsCallback && RobloxLaunch._GoogleAnalyticsCallback()
        },
        state: RobloxLaunchStates.None
    },
    RobloxPlaceLauncherService = {
        LogJoinClick: function() {
            $.get("/Game/Placelauncher.ashx", {
                request: "LogJoinClick"
            })
        },
        RequestGame: function(n, t, i, r, u, f) {
            i = i !== null && i !== undefined ? i : "", $.getJSON("/Game/PlaceLauncher.ashx", {
                request: "RequestGame",
                placeId: n,
                isPartyLeader: t,
                gender: i
            }, function(n) {
                n.Error ? u(n.Error, f) : r(n, f)
            })
        },
        RequestPlayWithParty: function(n, t, i, r, u, f) {
            $.getJSON("/Game/PlaceLauncher.ashx", {
                request: "RequestPlayWithParty",
                placeId: n,
                partyGuid: t,
                gameId: i
            }, function(n) {
                n.Error ? u(n.Error, f) : r(n, f)
            })
        },
        RequestGroupBuildGame: function(n, t, i, r) {
            $.getJSON("/Game/PlaceLauncher.ashx", {
                request: "RequestGroupBuildGame",
                placeId: n
            }, function(n) {
                n.Error ? i(n.Error, r) : t(n, r)
            })
        },
        RequestFollowUser: function(n, t, i, r) {
            $.getJSON("/Game/PlaceLauncher.ashx", {
                request: "RequestFollowUser",
                userId: n
            }, function(n) {
                n.Error ? i(n.Error, r) : t(n, r)
            })
        },
        RequestGameJob: function(n, t, i, r, u, f) {
            $.getJSON("/Game/PlaceLauncher.ashx", {
                request: "RequestGameJob",
                placeId: n,
                gameId: t,
                gameJobId: i
            }, function(n) {
                n.Error ? u(n.Error, f) : r(n, f)
            })
        },
        CheckGameJobStatus: function(n, t, i, r) {
            $.getJSON("/Game/PlaceLauncher.ashx", {
                request: "CheckGameJobStatus",
                jobId: n
            }, function(n) {
                n.Error ? i(n.Error, r) : t(n, r)
            })
        }
    };
RobloxLaunch.RequestPlayWithParty = function(n, t, i, r) {
    EventTracker.start("Launch"), RobloxPlaceLauncherService.LogJoinClick(), RobloxLaunch.state = RobloxLaunchStates.None, checkRobloxInstall() && (RobloxLaunch.launcher === null && (RobloxLaunch.launcher = new RBX.PlaceLauncher(n)), RobloxLaunch.launcher.RequestPlayWithParty(t, i, r))
}, RobloxLaunch.RequestGame = function(n, t, i) {
    EventTracker.start("Launch"), RobloxPlaceLauncherService.LogJoinClick(), RobloxLaunch.state = RobloxLaunchStates.None, checkRobloxInstall() && (RobloxLaunch.launcher === null && (RobloxLaunch.launcher = new RBX.PlaceLauncher(n)), RobloxLaunch.launcher.RequestGame(t, i))
}, RobloxLaunch.RequestGroupBuildGame = function(n, t) {
    EventTracker.start("Launch"), RobloxPlaceLauncherService.LogJoinClick(), RobloxLaunch.state = RobloxLaunchStates.None, checkRobloxInstall() && (RobloxLaunch.launcher === null && (RobloxLaunch.launcher = new RBX.PlaceLauncher(n)), RobloxLaunch.launcher.RequestGroupBuildGame(t))
}, RobloxLaunch.RequestGameJob = function(n, t, i, r) {
    EventTracker.start("Launch"), RobloxPlaceLauncherService.LogJoinClick(), RobloxLaunch.state = RobloxLaunchStates.None, checkRobloxInstall() && (RobloxLaunch.launcher === null && (RobloxLaunch.launcher = new RBX.PlaceLauncher(n)), RobloxLaunch.launcher.RequestGameJob(t, i, r))
}, RobloxLaunch.RequestFollowUser = function(n, t) {
    EventTracker.start("Launch"), RobloxPlaceLauncherService.LogJoinClick(), RobloxLaunch.state = RobloxLaunchStates.None, checkRobloxInstall() && (RobloxLaunch.launcher === null && (RobloxLaunch.launcher = new RBX.PlaceLauncher(n)), RobloxLaunch.launcher.RequestFollowUser(t))
}, RobloxLaunch.StartGame = function(n, t, i, r, u) {
    var f = function(r) {
        RobloxLaunch.StartGameWork(n, t, i, r, u)
    };
    r == "FETCH" ? $.get("/Game/GetAuthTicket", f) : f(r)
}, RobloxLaunch.StartGameWork = function(n, t, i, r, u) {
    var o, f, e, s;
    i = i.replace("http://", "https://"), n.indexOf("http") >= 0 && (n = typeof RobloxLaunch.SeleniumTestMode == "undefined" ? n + "&testmode=false" : n + "&testmode=true"), typeof urchinTracker != "undefined" && urchinTracker("Visit/Try/" + t), RobloxLaunch.state = RobloxLaunchStates.StartingClient, RobloxLaunch.googleAnalyticsCallback !== null && RobloxLaunch.googleAnalyticsCallback(), o = null;
    try {
        if (typeof window.external != "undefined" && window.external.IsRoblox2App && (n.indexOf("visit") != -1 || u)) window.external.StartGame(r, i, n);
        else if (o = "RobloxProxy/", f = Roblox.Client.CreateLauncher(!0), f) {
            o = "RobloxProxy/StartGame/";
            try {
                try {
                    window.ActiveXObject ? f.AuthenticationTicket = r : f.Put_AuthenticationTicket(r), u && f.SetEditMode()
                } catch (a) {}
                try {
                    if (Roblox.Client._silentModeEnabled) f.SetSilentModeEnabled(!0), Roblox.VideoPreRoll.videoInitialized && Roblox.VideoPreRoll.isPlaying() && Roblox.Client.SetStartInHiddenMode(!0), f.StartGame(i, n), RobloxLaunch.CheckGameStarted(f);
                    else throw "silent mode is disabled, fall back";
                } catch (a) {
                    if (f.StartGame(i, n), Roblox.Client._bringAppToFrontEnabled) try {
                        f.BringAppToFront()
                    } catch (h) {}
                    Roblox.Client.ReleaseLauncher(f, !0, !1), $.modal.close()
                }
            } catch (a) {
                Roblox.Client.ReleaseLauncher(f, !0, !1);
                throw a;
            }
        } else {
            try {
                parent.playFromUrl(n);
                return
            } catch (l) {}
            if (Roblox.Client.isRobloxBrowser()) try {
                window.external.StartGame(r, i, n)
            } catch (l) {
                throw "window.external fallback failed, Roblox must not be installed or IE cannot access ActiveX";
            } else throw "launcher is null or undefined and external is missing";
            RobloxLaunch.state = RobloxLaunchStates.None, $.modal.close()
        }
    } catch (a) {
        if (e = a.message, e === "User cancelled" && typeof urchinTracker != "undefined") return urchinTracker("Visit/UserCancelled/" + t), !1;
        try {
            s = new ActiveXObject("Microsoft.XMLHTTP")
        } catch (c) {
            e = "FailedXMLHTTP/" + e
        }
        return Roblox.Client.isRobloxBrowser() ? typeof urchinTracker != "undefined" && urchinTracker("Visit/Fail/" + o + encodeURIComponent(e)) : (typeof urchinTracker != "undefined" && urchinTracker("Visit/Redirect/" + o + encodeURIComponent(e)), window.location = RobloxLaunch.launchGamePage), !1
    }
    return typeof urchinTracker != "undefined" && urchinTracker("Visit/Success/" + t), !0
}, RobloxLaunch.StartApp = function(n, t) {
    var i = function(i) {
        RobloxLaunch.StartAppWork(n, t, i)
    };
    $.get("/Game/GetAuthTicket", i)
}, RobloxLaunch.StartAppWork = function(n, t, i) {
    var f, r, u;
    RobloxLaunch.state = RobloxLaunchStates.StartingClient, f = null;
    try {
        if (typeof window.external != "undefined" && window.external.IsRoblox2App) window.external.StartGame(i, t, n);
        else if (f = "RobloxProxy/", r = Roblox.Client.CreateLauncher(!0), r) {
            f = "RobloxProxy/StartGame/";
            try {
                try {
                    r.SetAppMode()
                } catch (h) {}
                try {
                    window.ActiveXObject ? r.AuthenticationTicket = i : r.Put_AuthenticationTicket(i)
                } catch (h) {}
                try {
                    if (Roblox.Client._silentModeEnabled) r.SetSilentModeEnabled(!0), Roblox.VideoPreRoll.videoInitialized && Roblox.VideoPreRoll.isPlaying() && Roblox.Client.SetStartInHiddenMode(!0), r.StartGame(t, n), RobloxLaunch.CheckGameStarted(r);
                    else throw "silent mode is disabled, fall back";
                } catch (h) {
                    if (r.StartGame(t, n), Roblox.Client._bringAppToFrontEnabled) try {
                        r.BringAppToFront()
                    } catch (e) {}
                    Roblox.Client.ReleaseLauncher(r, !0, !1), $.modal.close()
                }
            } catch (h) {
                Roblox.Client.ReleaseLauncher(r, !0, !1);
                throw h;
            }
        } else {
            try {
                parent.playFromUrl(n);
                return
            } catch (s) {}
            if (Roblox.Client.isRobloxBrowser()) try {
                window.external.StartGame(i, t, n)
            } catch (s) {
                throw "window.external fallback failed, Roblox must not be installed or IE cannot access ActiveX";
            } else throw "launcher is null or undefined and external is missing";
            RobloxLaunch.state = RobloxLaunchStates.None, $.modal.close()
        }
    } catch (h) {
        if (u = h.message, u === "User cancelled") return !1;
        try {
            new ActiveXObject("Microsoft.XMLHTTP")
        } catch (o) {
            u = "FailedXMLHTTP/" + u
        }
        return Roblox.Client.isRobloxBrowser() || (window.location = RobloxLaunch.launchGamePage), !1
    }
    return !0
}, RobloxLaunch.CheckGameStarted = function(n) {
    function r() {
        try {
            if (i || (i = window.ActiveXObject ? n.IsGameStarted : n.Get_GameStarted()), i && !u && (EventTracker.endSuccess("StartClient"), EventTracker.endSuccess("Launch"), u = !0), i && !Roblox.VideoPreRoll.isPlaying()) {
                if (MadStatus.stop("Connecting to Players..."), RobloxLaunch.state = RobloxLaunchStates.None, $.modal.close(), t._cancelled = !0, Roblox.Client._hiddenModeEnabled && Roblox.Client.UnhideApp(), Roblox.Client._bringAppToFrontEnabled) try {
                    n.BringAppToFront()
                } catch (e) {}
                Roblox.Client.ReleaseLauncher(n, !0, !1)
            } else t._cancelled || setTimeout(r, 1e3)
        } catch (f) {
            t._cancelled || setTimeout(r, 1e3)
        }
    }
    var u = !1,
        t = RobloxLaunch.launcher,
        i;
    t === null && (t = new RBX.PlaceLauncher("PlaceLauncherStatusPanel"), t._showDialog(), t._updateStatus(0)), i = !1, r()
}, RobloxLaunch.CheckRobloxInstall = function(n) {
    if (Roblox.Client.IsRobloxInstalled()) return Roblox.Client.Update(), !0;
    window.location = n
}, RBX.PlaceLauncher = function(n) {
    this._cancelled = !1, this._popupID = n, this._popup = $("#" + n)
}, RBX.PlaceLauncher.prototype = {
    _showDialog: function() {
        var t, n;
        this._cancelled = !1, _popupOptions = {
            escClose: !0,
            opacity: 80,
            overlayCss: {
                backgroundColor: "#000"
            }
        }, this._popupID == "PlaceLauncherStatusPanel" && (Roblox.VideoPreRoll && Roblox.VideoPreRoll.showVideoPreRoll && !Roblox.VideoPreRoll.isExcluded() ? (this._popup = $("#videoPrerollPanel"), _popupOptions.onShow = function(n) {
            Roblox.VideoPreRoll.correctIEModalPosition(n), Roblox.VideoPreRoll.start()
        }, _popupOptions.onClose = function() {
            Roblox.VideoPreRoll.close()
        }, _popupOptions.closeHTML = '<a href="#" class="ImageButton closeBtnCircle_35h ABCloseCircle VprCloseButton"></a>') : (this._popup = $("#" + this._popupID), _popupOptions.onClose = function() {
            Roblox.VideoPreRoll.logVideoPreRoll(), $.modal.close()
        })), t = this, setTimeout(function() {
            t._popup.modal(_popupOptions)
        }, 0), n = this, $(".CancelPlaceLauncherButton").click(function() {
            n.CancelLaunch()
        }), $(".CancelPlaceLauncherButton").show()
    },
    _onGameStatus: function(n) {
        if (this._cancelled) {
            EventTracker.endCancel("GetConnection"), EventTracker.endCancel("Launch");
            return
        }
        if (this._updateStatus(n.status), n.status === 2) EventTracker.endSuccess("GetConnection"), EventTracker.start("StartClient"), RobloxLaunch.StartGame(n.joinScriptUrl, "Join", n.authenticationUrl, n.authenticationTicket);
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
        } else n.status === 4 && (EventTracker.endFailure("GetConnection"), EventTracker.endFailure("Launch"))
    },
    _updateStatus: function(n) {
        MadStatus.running || (MadStatus.init($(this._popup).find(".MadStatusField"), $(this._popup).find(".MadStatusBackBuffer"), 2e3, 800), MadStatus.start());
        switch (n) {
            case 0:
                break;
            case 1:
                MadStatus.manualUpdate("A server is loading the game...", !0);
                break;
            case 2:
                MadStatus.manualUpdate("The server is ready. Joining the game...", !0);
                break;
            case 3:
                MadStatus.manualUpdate("Joining games is temporarily disabled while we upgrade. Please try again soon.", !1);
                break;
            case 4:
                MadStatus.manualUpdate("An error occurred. Please try again later.", !1);
                break;
            case 5:
                MadStatus.manualUpdate("The game you requested has ended.", !1);
                break;
            case 6:
                MadStatus.manualUpdate("The game you requested is currently full. Waiting for an opening...", !0, !1);
                break;
            case 7:
                MadStatus.manualUpdate("Roblox is updating. Please wait...", !0);
                break;
            case 8:
                MadStatus.manualUpdate("Requesting a server", !0);
                break;
            default:
                MadStatus.stop("Connecting to Players...")
        }
        $(this._popup).find(".MadStatusStarting").css("display", "none"), $(this._popup).find(".MadStatusSpinner").css("visibility", n === 3 || n === 4 || n === 5 ? "hidden" : "visible")
    },
    _onGameError: function() {
        this._updateStatus(4)
    },
    _startUpdatePolling: function(n) {
        var t, i;
        try {
            if (RobloxLaunch.state = RobloxLaunchStates.Upgrading, t = Roblox.Client.CreateLauncher(!0), i = window.ActiveXObject ? t.IsUpToDate : t.Get_IsUpToDate(), i || i === undefined) {
                try {
                    t.PreStartGame()
                } catch (e) {}
                Roblox.Client.ReleaseLauncher(t, !0, !1), RobloxLaunch.state = RobloxLaunchStates.StartingServer, EventTracker.endSuccess("UpdateClient"), n();
                return
            }
            var f = function(t, i, r) {
                    r._onUpdateStatus(t, i, n)
                },
                u = function(n, t) {
                    t._onUpdateError(n)
                },
                r = this;
            this.CheckUpdateStatus(f, u, t, n, r)
        } catch (e) {
            Roblox.Client.ReleaseLauncher(t, !0, !1), EventTracker.endSuccess("UpdateClient"), n()
        }
    },
    _onUpdateStatus: function(n, t, i) {
        if (!this._cancelled)
            if (this._updateStatus(n), n === 8) Roblox.Client.ReleaseLauncher(t, !0, !0), Roblox.Client.Refresh(), RobloxLaunch.state = RobloxLaunchStates.StartingServer, EventTracker.endSuccess("UpdateClient"), i();
            else if (n === 7) {
            var f = function(n, t, r) {
                    r._onUpdateStatus(n, t, i)
                },
                e = function(n, t) {
                    t._onUpdateError(n)
                },
                r = this,
                u = function() {
                    r.CheckUpdateStatus(f, e, t, i, r)
                };
            window.setTimeout(u, 2e3)
        } else alert("Unknown status from CheckUpdateStatus")
    },
    _onUpdateError: function() {
        this._updateStatus(2)
    },
    CheckUpdateStatus: function(n, t, i, r, u) {
        try {
            if (i.PreStartGame(), window.ActiveXObject) var f = i.IsUpToDate;
            else f = i.Get_IsUpToDate();
            f || f === undefined ? n(8, i, u) : n(7, i, u)
        } catch (e) {
            n(8, i, u)
        }
    },
    RequestGame: function(n, t) {
        var r;
        this._showDialog();
        var f = function(n, t) {
                t._onGameStatus(n)
            },
            u = function(n, t) {
                t._onGameError(n)
            },
            e = this,
            i = !1;
        return typeof Party != "undefined" && typeof Party.AmILeader == "function" && (i = Party.AmILeader()), r = function() {
            EventTracker.start("GetConnection"), RobloxPlaceLauncherService.RequestGame(n, i, t, f, u, e)
        }, this._startUpdatePolling(r), !1
    },
    RequestPlayWithParty: function(n, t, i) {
        this._showDialog();
        var f = function(n, t) {
                t._onGameStatus(n)
            },
            e = function(n, t) {
                t._onGameError(n)
            },
            r = this,
            u = function() {
                EventTracker.start("GetConnection"), RobloxPlaceLauncherService.RequestPlayWithParty(n, t, i, f, e, r)
            };
        return this._startUpdatePolling(u), !1
    },
    RequestGroupBuildGame: function(n) {
        this._showDialog();
        var r = function(n, t) {
                t._onGameStatus(n, !0)
            },
            u = function(n, t) {
                t._onGameError(n)
            },
            t = this,
            i = function() {
                EventTracker.start("GetConnection"), RobloxPlaceLauncherService.RequestGroupBuildGame(n, r, u, t)
            };
        return this._startUpdatePolling(i), !1
    },
    RequestFollowUser: function(n) {
        this._showDialog();
        var r = function(n, t) {
                t._onGameStatus(n)
            },
            u = function(n, t) {
                t._onError(n)
            },
            t = this,
            i = function() {
                EventTracker.start("GetConnection"), RobloxPlaceLauncherService.RequestFollowUser(n, r, u, t)
            };
        return this._startUpdatePolling(i), !1
    },
    RequestGameJob: function(n, t, i) {
        this._showDialog();
        var f = function(n, t) {
                t._onGameStatus(n)
            },
            e = function(n, t) {
                t._onGameError(n)
            },
            r = this,
            u = function() {
                EventTracker.start("GetConnection"), RobloxPlaceLauncherService.RequestGameJob(n, t, i, f, e, r)
            };
        return this._startUpdatePolling(u), !1
    },
    CancelLaunch: function() {
        return this._cancelled = !0, $.modal.close(), !1
    },
    dispose: function() {
        RBX.PlaceLauncher.callBaseMethod(this, "dispose")
    }
};