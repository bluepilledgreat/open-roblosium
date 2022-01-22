/*
 * ROBLOSIUM 2013
 * Deobfuscation by Matt Brown/Nostal-ia#7440. If you get any errors with this file, contact me via Discord.
 */
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
        RequestGame: function(placeId, isPartyLeader, gender, onGameSuccess, onGameError, context) {
            gender = gender !== null && gender !== undefined ? gender : ""
            $.getJSON("/Game/PlaceLauncher.ashx", {
                request: "RequestGame",
                placeId: placeId,
                isPartyLeader: isPartyLeader,
                gender: gender
            }, function(data) {
                data.Error ? onGameError(data.Error, context) : onGameSuccess(data, context)
            })
        },
        RequestPlayWithParty: function(placeId, partyGuid, gameId, onGameSuccess, onGameError, context) {
            $.getJSON("/Game/PlaceLauncher.ashx", {
                request: "RequestPlayWithParty",
                placeId: placeId,
                partyGuid: partyGuid,
                gameId: gameId
            }, function(data) {
                data.Error ? onGameError(data.Error, context) : onGameSuccess(data, context)
            })
        },
        RequestGroupBuildGame: function(placeId, onGameSuccess, onGameError, context) {
            $.getJSON("/Game/PlaceLauncher.ashx", {
                request: "RequestGroupBuildGame",
                placeId: placeId
            }, function(data) {
                data.Error ? onGameError(data.Error, context) : onGameSuccess(data, context)
            })
        },
        RequestFollowUser: function(userId, onGameSuccess, onGameError, context) {
            $.getJSON("/Game/PlaceLauncher.ashx", {
                request: "RequestFollowUser",
                userId: userId
            }, function(data) {
                data.Error ? onGameError(data.Error, context) : onGameSuccess(data, context)
            })
        },
        RequestGameJob: function(placeId, gameId, gameJobId, onGameSuccess, onGameError, context) {
            $.getJSON("/Game/PlaceLauncher.ashx", {
                request: "RequestGameJob",
                placeId: placeId,
                gameId: gameId,
                gameJobId: gameJobId
            }, function(data) {
                data.Error ? onGameError(data.Error, context) : onGameSuccess(data, context)
            })
        },
        CheckGameJobStatus: function(jobId, onGameSuccess, onGameError, context) {
            $.getJSON("/Game/PlaceLauncher.ashx", {
                request: "CheckGameJobStatus",
                jobId: jobId
            }, function(data) {
                data.Error ? onGameError(data.Error, context) : onGameSuccess(data, context)
            })
        }
    };
RobloxLaunch.RequestPlayWithParty = function(behaviorID, placeId, partyGuid, gameId) {
    EventTracker.start("Launch")
	RobloxPlaceLauncherService.LogJoinClick()
	RobloxLaunch.state = RobloxLaunchStates.None
	if (checkRobloxInstall()) {
		if (RobloxLaunch.launcher === null) {
			RobloxLaunch.launcher = new RBX.PlaceLauncher(behaviorID)
		}
		RobloxLaunch.launcher.RequestPlayWithParty(placeId, partyGuid, gameId)
	}
}
RobloxLaunch.RequestGame = function(behaviorID, placeId, gender) {
    EventTracker.start("Launch");
	RobloxPlaceLauncherService.LogJoinClick();
	RobloxLaunch.state = RobloxLaunchStates.None;
	if (checkRobloxInstall()) {
		if (RobloxLaunch.launcher === null) {
			RobloxLaunch.launcher = new RBX.PlaceLauncher(behaviorID)
		}
		RobloxLaunch.launcher.RequestGame(placeId, gender)
	}
}, RobloxLaunch.RequestGroupBuildGame = function(behaviorID, placeId) {
    EventTracker.start("Launch")
    RobloxPlaceLauncherService.LogJoinClick()
    RobloxLaunch.state = RobloxLaunchStates.None
    if (checkRobloxInstall()) {
        if (RobloxLaunch.launcher === null) {
            RobloxLaunch.launcher = new RBX.PlaceLauncher(behaviorID)
        }
        RobloxLaunch.launcher.RequestGroupBuildGame(placeId)
    }
}, RobloxLaunch.RequestGameJob = function(behaviorID, placeId, gameId, gameJobId) {
    EventTracker.start("Launch")
    RobloxPlaceLauncherService.LogJoinClick()
    RobloxLaunch.state = RobloxLaunchStates.None
    if (checkRobloxInstall()) {
        if (RobloxLaunch.launcher === null) {
            RobloxLaunch.launcher = new RBX.PlaceLauncher(behaviorID)
        }
        RobloxLaunch.launcher.RequestGameJob(placeId, gameId, gameJobId)
    }
}, RobloxLaunch.RequestFollowUser = function(behaviorID, userId) {
    EventTracker.start("Launch")
    RobloxPlaceLauncherService.LogJoinClick()
    RobloxLaunch.state = RobloxLaunchStates.None
    if (checkRobloxInstall()) {
        if (RobloxLaunch.launcher === null) {
            RobloxLaunch.launcher = new RBX.PlaceLauncher(behaviorID)
        }
        RobloxLaunch.launcher.RequestFollowUser(userId)
    }
}, RobloxLaunch.StartGame = function(visitUrl, type, authenticationUrl, authenticationTicket, isEdit) {
    var handler = function(newTicket) {
        RobloxLaunch.StartGameWork(visitUrl, type, authenticationUrl, newTicket, isEdit)
    };
    if (authenticationTicket == "FETCH") {
        $.get("/Game/GetAuthTicket", handler)
    } else {
        handler(authenticationTicket)
    }
}
RobloxLaunch.StartGameWork = function(visitUrl, type, authenticationUrl, authenticationTicket, isEdit) {
    var launcher;
    authenticationUrl = authenticationUrl.replace("http://", "https://")
    if(visitUrl.indexOf("http") >= 0) {
        if (typeof RobloxLaunch.SeleniumTestMode == "undefined") {
            visitUrl + "&testmode=false"
        } else {
            visitUrl + "&testmode=true"
        }
    }
    if (typeof urchinTracker != "undefined") {
        urchinTracker("Visit/Try/" + type)
    }
    RobloxLaunch.state = RobloxLaunchStates.StartingClient
    if (RobloxLaunch.googleAnalyticsCallback !== null) {
        RobloxLaunch.googleAnalyticsCallback()
    }
    var prefix = null
    try {
        if (typeof window.external != "undefined" && window.external.IsRoblox2App && (visitUrl.indexOf("visit") != -1 || isEdit)) {
            window.external.StartGame(authenticationTicket, authenticationUrl, visitUrl)
        } else if (launcher = Roblox.Client.CreateLauncher(true), launcher) {
            prefix = "RobloxProxy/StartGame/"
            try {
                try {
                    if(window.ActiveXObject) {
                        launcher.AuthenticationTicket = authenticationTicket
                    } else {
                        launcher.Put_AuthenticationTicket(authenticationTicket)
                    }
                    if (isEdit) {
                        launcher.SetEditMode()
                    }
                } catch (err) {}
                try {
                    if (Roblox.Client._silentModeEnabled) {
                        launcher.SetSilentModeEnabled(true)
                        if (Roblox.VideoPreRoll.videoInitialized && Roblox.VideoPreRoll.isPlaying()) {
                            Roblox.Client.SetStartInHiddenMode(true)
                        }
                        launcher.StartGame(authenticationUrl, visitUrl)
                        RobloxLaunch.CheckGameStarted(launcher)
                    }
                    else {
                        throw "silent mode is disabled, fall back"
                    }
                } catch (err) {
                    if (launcher.StartGame(authenticationUrl, visitUrl), Roblox.Client._bringAppToFrontEnabled) {
                        try {
                            launcher.BringAppToFront()
                        } catch (e) {} 
                    }
                    Roblox.Client.ReleaseLauncher(launcher, true, false)
                    $.modal.close()
                }
            } catch (err) {
                Roblox.Client.ReleaseLauncher(launcher, true, false);
                throw err;
            }
        } else {
            prefix = "RobloxProxy/"
            try {
                parent.playFromUrl(visitUrl);
                return
            } catch (ex) {}
            if (Roblox.Client.isRobloxBrowser()) {
                try {
                    window.external.StartGame(authenticationTicket, authenticationUrl, visitUrl)
                } catch (ex) {
                    throw "window.external fallback failed, Roblox must not be installed or IE cannot access ActiveX";
                } 
            } else {
                throw "launcher is null or undefined and external is missing"
            }
            RobloxLaunch.state = RobloxLaunchStates.None
            $.modal.close()
        }
    } catch (err) {
        var message = err.message
        if (message === "User cancelled") {
            if (typeof urchinTracker != "undefined") {
                urchinTracker("Visit/UserCancelled/" + type)
            }
            return false
        }
        try {
            var y = new ActiveXObject("Microsoft.XMLHTTP")
        } catch (c) {
            message = "FailedXMLHTTP/" + message
        }
        if (Roblox.Client.isRobloxBrowser()) {
            if (typeof urchinTracker != "undefined") {
                urchinTracker("Visit/Fail/" + prefix + encodeURIComponent(message))
            }
        } else {
            if (typeof urchinTracker != "undefined") {
                urchinTracker("Visit/Redirect/" + prefix + encodeURIComponent(message))
            }
        }
        window.location = RobloxLaunch.launchGamePage
        return false
    }
    if (typeof urchinTracker != "undefined") {
        urchinTracker("Visit/Success/" + type)
    }
    return true
}
RobloxLaunch.StartApp = function(startScriptUrl, authenticationUrl) {
    var handler = function(newTicket) {
        RobloxLaunch.StartAppWork(startScriptUrl, authenticationUrl, newTicket)
    };
    $.get("/Game/GetAuthTicket", handler)
}
RobloxLaunch.StartAppWork = function(startScriptUrl, authenticationUrl, authenticationTicket) {
    RobloxLaunch.state = RobloxLaunchStates.StartingClient
    var launcher;
    var prefix = null;
    try {
        if (typeof window.external != "undefined" && window.external.IsRoblox2App)
            window.external.StartGame(authenticationTicket, authenticationUrl, startScriptUrl)
        else if (launcher = Roblox.Client.CreateLauncher(true), launcher) {
            prefix = "RobloxProxy/StartGame/";
            try {
                try {
                    launcher.SetAppMode()
                } catch (err) {}
                try {
                    if (window.ActiveXObject) {
                        launcher.AuthenticationTicket = authenticationTicket
                    } else {
                        launcher.Put_AuthenticationTicket(authenticationTicket)
                    }
                } catch (err) {}
                try {
                    if (Roblox.Client._silentModeEnabled) { 
                        launcher.SetSilentModeEnabled(true)
                        if (Roblox.VideoPreRoll.videoInitialized && Roblox.VideoPreRoll.isPlaying()) {
                            Roblox.Client.SetStartInHiddenMode(true)
                        }
                        launcher.StartGame(authenticationUrl, startScriptUrl)
                        RobloxLaunch.CheckGameStarted(launcher);
                    } else {
                        throw "silent mode is disabled, fall back";
                    }
                } catch (err) {
                    launcher.StartGame(authenticationUrl, startScriptUrl)
                    if (Roblox.Client._bringAppToFrontEnabled) {
                        try {
                            launcher.BringAppToFront()
                        } catch (e) {}
                    }
                    Roblox.Client.ReleaseLauncher(launcher, true, false)
                    $.modal.close()
                }
            } catch (err) {
                Roblox.Client.ReleaseLauncher(launcher, true, false);
                throw err;
            }
        } else {
            prefix = "RobloxProxy/"
            try {
                parent.playFromUrl(startScriptUrl);
                return
            } catch (ex) {}
            if (Roblox.Client.isRobloxBrowser()) {
                try {
                    window.external.StartGame(authenticationTicket, authenticationUrl, startScriptUrl)
                } catch (ex) {
                    throw "window.external fallback failed, Roblox must not be installed or IE cannot access ActiveX";
                }
            } else {
                throw "launcher is null or undefined and external is missing"
            }
            RobloxLaunch.state = RobloxLaunchStates.None
            $.modal.close()
        }
    } catch (err) {
        var message = err.message
        if (message === "User cancelled") {
            return false;
        }
        try {
            new ActiveXObject("Microsoft.XMLHTTP")
        } catch (err3) {
            message = "FailedXMLHTTP/" + message
        }
        if (Roblox.Client.isRobloxBrowser()) {
            window.location = RobloxLaunch.launchGamePage
        }
        return false
    }
    return true
}
RobloxLaunch.CheckGameStarted = function(launcher) {
    var started = false
    var finalEventsSent = false
    var rbxLauncher = RobloxLaunch.launcher
    if (rbxLauncher === null) {
        rbxLauncher = new RBX.PlaceLauncher("PlaceLauncherStatusPanel")
        rbxLauncher._showDialog()
        rbxLauncher._updateStatus(0)
    }
    function doCheck() {
        try {
            if (!started) {
                if (window.ActiveXObject) {
                    started = launcher.IsGameStarted
                } else {
                    started = launcher.Get_GameStarted()
                }
            }
            if (started && !finalEventsSent) {
                EventTracker.endSuccess("StartClient")
                EventTracker.endSuccess("Launch")
                finalEventsSent = true
            }
            if (started && !Roblox.VideoPreRoll.isPlaying()) {
                MadStatus.stop("Connecting to Players...")
                RobloxLaunch.state = RobloxLaunchStates.None
                $.modal.close()
                rbxLauncher._cancelled = true
                if (Roblox.Client._hiddenModeEnabled) {
                    Roblox.Client.UnhideApp()
                }
                if (Roblox.Client._bringAppToFrontEnabled) {
                    try {
                      launcher.BringAppToFront()
                    } catch (e) {}
                }
                Roblox.Client.ReleaseLauncher(launcher, true, false)
            } else if (rbxLauncher._cancelled) {
                setTimeout(doCheck, 1000)
            }
        } catch (ex) {
            if (rbxLauncher._cancelled) {
                setTimeout(doCheck, 1000)
            }
        }
    }
    doCheck()
}
RobloxLaunch.CheckRobloxInstall = function(installPath) {
    if (Roblox.Client.IsRobloxInstalled()) {
        Roblox.Client.Update()
        return true
    }
    window.location = installPath
}
RBX.PlaceLauncher = function(modalDialogueID) {
    this._cancelled = false
    this._popupID = modalDialogueID
    this._popup = $("#" + modalDialogueID)
}
RBX.PlaceLauncher.prototype = {
    _showDialog: function() {
        this._cancelled = false
        _popupOptions = {
            escClose: true,
            opacity: 80,
            overlayCss: {
                backgroundColor: "#000"
            }
        }
        
        if (this._popupID == "PlaceLauncherStatusPanel") {
            if (Roblox.VideoPreRoll && Roblox.VideoPreRoll.showVideoPreRoll && !Roblox.VideoPreRoll.isExcluded()) {
                this._popup = $("#videoPrerollPanel")
                _popupOptions.onShow = function(dialog) {
                    Roblox.VideoPreRoll.correctIEModalPosition(dialog)
                    Roblox.VideoPreRoll.start()
                }
                _popupOptions.onClose = function() {
                    Roblox.VideoPreRoll.close()
                }
                _popupOptions.closeHTML = '<a href="#" class="ImageButton closeBtnCircle_35h ABCloseCircle VprCloseButton"></a>'
            } else {
                this._popup = $("#" + this._popupID)
                _popupOptions.onClose = function() {
                    Roblox.VideoPreRoll.logVideoPreRoll()
                    $.modal.close()
                }
            }
        }
        var self = this
        setTimeout(function() {
            self._popup.modal(_popupOptions)
        }, 0)
        var RBXPlaceLauncher = this;
        $(".CancelPlaceLauncherButton").click(function() {
            RBXPlaceLauncher.CancelLaunch()
        })
        $(".CancelPlaceLauncherButton").show()
    },
    _onGameStatus: function(result) {
        if (this._cancelled) {
            EventTracker.endCancel("GetConnection"), EventTracker.endCancel("Launch");
            return
        }
        this._updateStatus(result.status)
        if (result.status === 2) {
            EventTracker.endSuccess("GetConnection")
            EventTracker.start("StartClient")
            RobloxLaunch.StartGame(result.joinScriptUrl, "Join", result.authenticationUrl, result.authenticationTicket)
        } else if (result.status < 2 || result.status === 6) {
            var onSuccess = function(result, context) {
                    context._onGameStatus(result)
                },
                onError = function(result, context) {
                    context._onGameError(result)
                },
                self = this,
                call = function() {
                    RobloxPlaceLauncherService.CheckGameJobStatus(result.jobId, onSuccess, onError, self)
                };
            window.setTimeout(call, 2000)
        } else if (result.status === 4) { 
            EventTracker.endFailure("GetConnection")
            EventTracker.endFailure("Launch")
        }
    },
    _updateStatus: function(status) {
        if (!MadStatus.running) {
            MadStatus.init($(this._popup).find(".MadStatusField"), $(this._popup).find(".MadStatusBackBuffer"), 2000, 800);
            MadStatus.start();
        }
        switch (status) {
            case 0:
                break;
            case 1:
                MadStatus.manualUpdate("A server is loading the game...", true);
                break;
            case 2:
                MadStatus.manualUpdate("The server is ready. Joining the game...", true);
                break;
            case 3:
                MadStatus.manualUpdate("Joining games is temporarily disabled while we upgrade. Please try again soon.", false);
                break;
            case 4:
                MadStatus.manualUpdate("An error occurred. Please try again later.", false);
                break;
            case 5:
                MadStatus.manualUpdate("The game you requested has ended.", false);
                break;
            case 6:
                MadStatus.manualUpdate("The game you requested is currently full. Waiting for an opening...", true, false);
                break;
            case 7:
                MadStatus.manualUpdate("Roblox is updating. Please wait...", true);
                break;
            case 8:
                MadStatus.manualUpdate("Requesting a server", true);
                break;
            default:
                MadStatus.stop("Connecting to Players...")
        }
        $(this._popup).find(".MadStatusStarting").css("display", "none")
        $(this._popup).find(".MadStatusSpinner").css("visibility", status === 3 || status === 4 || status === 5 ? "hidden" : "visible")
    },
    _onGameError: function() {
        this._updateStatus(4)
    },
    _startUpdatePolling: function(joinGameDelegate) {
        try {
            RobloxLaunch.state = RobloxLaunchStates.Upgrading
            var launcher = Roblox.Client.CreateLauncher(true)
            var result;
            if (window.ActiveXObject) {
                result = launcher.IsUpToDate
            } else {
                result = launcher.Get_IsUpToDate()
            }
            if (result || result === undefined) {
                try {
                    launcher.PreStartGame()
                } catch (e) {}
                Roblox.Client.ReleaseLauncher(launcher, true, false)
                RobloxLaunch.state = RobloxLaunchStates.StartingServer
                EventTracker.endSuccess("UpdateClient")
                joinGameDelegate();
                return
            }
            var onSuccess = function(result, launcher, context) {
                    context._onUpdateStatus(result, launcher, joinGameDelegate)
                },
                onError = function(result, context) {
                    context._onUpdateError(result)
                },
                self = this;
            this.CheckUpdateStatus(onSuccess, onError, launcher, joinGameDelegate, self)
        } catch (e) {
            Roblox.Client.ReleaseLauncher(launcher, true, false)
            EventTracker.endSuccess("UpdateClient")
            joinGameDelegate()
        }
    },
    _onUpdateStatus: function(result, launcher, joinGameDelegate) {
        if (!this._cancelled)
            return
        if (result === 8) {
            Roblox.Client.ReleaseLauncher(launcher, true, true)
            Roblox.Client.Refresh()
            RobloxLaunch.state = RobloxLaunchStates.StartingServer
            EventTracker.endSuccess("UpdateClient")
            joinGameDelegate()
        }
        else if (result === 7) {
            var onSuccess = function(result, launcher, context) {
                context._onUpdateStatus(result, launcher, joinGameDelegate)
                },
                onError = function(result, context) {
                    context._onUpdateError(result)
                },
                self = this,
                call = function() {
                    r.CheckUpdateStatus(onSuccess, onError, launcher, joinGameDelegate, self)
                };
            window.setTimeout(call, 2000)
        } else {
            alert("Unknown status from CheckUpdateStatus")
        }
    },
    _onUpdateError: function() {
        this._updateStatus(2)
    },
    CheckUpdateStatus: function(onSuccess, onError, launcher, joinGameDelegate, self) {
        try {
            launcher.PreStartGame()
            if (window.ActiveXObject) {
                var result = launcher.IsUpToDate
            } else {
                result = launcher.Get_IsUpToDate()
            }
            if (result || result === undefined) {
                onSuccess(8, launcher, self)
                onSuccess(7, launcher, self)
            }
        } catch (e) {
            onSuccess(8, launcher, self)
        }
    },
    RequestGame: function(placeId, gender) {
        this._showDialog();
        var onGameSuccess = function(result, context) {
                context._onGameStatus(result)
            },
            onGameError = function(result, context) {
                context._onGameError(result)
            },
            self = this,
            isPartyLeader = false;
        if(typeof Party != "undefined" && typeof Party.AmILeader == "function") {
            isPartyLeader = Party.AmILeader()
        }
        var gameDelegate = function() {
            EventTracker.start("GetConnection"), RobloxPlaceLauncherService.RequestGame(placeId, isPartyLeader, gender, onGameSuccess, onGameError, self)
        }
        this._startUpdatePolling(gameDelegate)
        return false
    },
    RequestPlayWithParty: function(placeId, partyGuid, gameId) {
        this._showDialog();
        var onGameSuccess = function(result, context) {
                context._onGameStatus(result)
            },
            onGameError = function(result, context) {
                context._onGameError(result)
            },
            self = this,
            gameDelegate = function() {
                EventTracker.start("GetConnection"), RobloxPlaceLauncherService.RequestPlayWithParty(placeId, partyGuid, gameId, onGameSuccess, onGameError, self)
            };
        this._startUpdatePolling(gameDelegate)
        return false
    },
    RequestGroupBuildGame: function(placeId) {
        this._showDialog();
        var onGameSuccess = function(result, context) {
                context._onGameStatus(result, true)
            },
            onGameError = function(result, context) {
                context._onGameError(result)
            },
            self = this,
            gameDelegate = function() {
                EventTracker.start("GetConnection"), RobloxPlaceLauncherService.RequestGroupBuildGame(placeId, onGameSuccess, onGameError, self)
            };
        this._startUpdatePolling(gameDelegate)
        return false
    },
    RequestFollowUser: function(userId) {
        this._showDialog();
        var onGameSuccess = function(n, t) {
                t._onGameStatus(n)
            },
            onGameError = function(n, t) {
                t._onError(n)
            },
            self = this,
            gameDelegate = function() {
                EventTracker.start("GetConnection"), RobloxPlaceLauncherService.RequestFollowUser(userId, onGameSuccess, onGameError, self)
            };
        this._startUpdatePolling(gameDelegate)
        return false
    },
    RequestGameJob: function(placeId, gameId, gameJobId) {
        this._showDialog()
        var onGameSuccess = function(result, context) {
                context._onGameStatus(result)
            },
            onGameError = function(result, context) {
                context._onGameError(result)
            },
            self = this,
            gameDelegate = function() {
                EventTracker.start("GetConnection"), RobloxPlaceLauncherService.RequestGameJob(placeId, gameId, gameJobId, onGameSuccess, onGameError, self)
            };
        this._startUpdatePolling(gameDelegate)
        return false
    },
    CancelLaunch: function() {
        this._cancelled = true
        $.modal.close()
        return false
    },
    dispose: function() {
        RBX.PlaceLauncher.callBaseMethod(this, "dispose")
    }
};