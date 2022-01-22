typeof Roblox == "undefined" && (Roblox = {}), Roblox.JSErrorTracker = {
    showAlert: !1,
    defaultPixel: "GA",
    internalEventListenerPixelEnabled: !1,
    javascriptStackTraceEnabled: !1,
    data: {
        category: "JavascriptExceptions"
    },
    initialize: function(n) {
        typeof n != "undefined" && (typeof n.showAlert != "undefined" && (this.showAlert = n.showAlert), typeof n.internalEventListenerPixelEnabled != "undefined" && (this.internalEventListenerPixelEnabled = n.internalEventListenerPixelEnabled)), this.addOnErrorEventHandler(this.errorHandler)
    },
    errorHandler: function(n, t, i) {
        try {
            Roblox.JSErrorTracker.data.msg = n, Roblox.JSErrorTracker.data.url = t, Roblox.JSErrorTracker.data.line = i, Roblox.JSErrorTracker.data.ua = window.navigator.userAgent, Roblox.JSErrorTracker.logException(Roblox.JSErrorTracker.data)
        } catch (r) {}
        return !0
    },
    addOnErrorEventHandler: function(n) {
        var t = window.onerror;
        window.onerror = typeof window.onerror == "function" ? function(i, r, u) {
            t(i, r, u), n(i, r, u)
        } : n
    },
    processException: function(n, t) {
        if (typeof n != "undefined") {
            typeof n.category == "undefined" && (n.category = Roblox.JSErrorTracker.data.category);
            switch (t) {
                case "GA":
                    var i = {
                        category: "category",
                        url: "action",
                        msg: "opt_label",
                        line: "opt_value"
                    };
                    Roblox.JSErrorTracker.fireGAPixel(Roblox.JSErrorTracker.distillGAData(n, i));
                    break;
                case "Diag":
                    Roblox.JSErrorTracker.internalEventListenerPixelEnabled && (n.category = "JavascriptExceptions", n.shard = "WebMetrics", n.eventName = "JavascriptExceptionLoggingEvent", RobloxEventManager.triggerEvent("JavascriptExceptionLoggingEvent", n));
                    break;
                default:
                    console.log("Roblox JSErrorTracker received an unknown pixel to fire")
            }
            return !0
        }
    },
    logException: function(n) {
        Roblox.JSErrorTracker.processException(n, Roblox.JSErrorTracker.defaultPixel), Roblox.JSErrorTracker.internalEventListenerPixelEnabled && Roblox.JSErrorTracker.processException(n, "Diag"), Roblox.JSErrorTracker.showErrorMessage(n.msg)
    },
    distillData: function(n, t) {
        var r = {},
            i;
        for (i in t) typeof n[i] != "undefined" && (r[t[i]] = encodeURIComponent(n[i]));
        return r
    },
    distillGAData: function(n, t) {
        var r = Roblox.JSErrorTracker.distillData(n, t),
            i = [decodeURIComponent([r.category])];
        return typeof r.action != typeof undefined ? (i = i.concat(decodeURIComponent(r.action)), typeof r.opt_label != typeof undefined && (i = i.concat(decodeURIComponent(r.opt_label)), typeof r.opt_value != typeof undefined && (i = i.concat(parseInt(decodeURIComponent(r.opt_value)))))) : Roblox.JSErrorTracker.showAlert && alert("Missing a required parameter for GA"), i
    },
    createURL: function(n, t, i) {
        var r = n,
            f = Roblox.JSErrorTracker.distillData(t, i),
            u;
        if (r += "?", f != null)
            for (u in f) typeof u != typeof undefined && t.hasOwnProperty(u) && (r += u + "=" + f[u] + "&");
        return r = r.slice(0, r.length - 1)
    },
    fireGAPixel: function(n) {
        typeof _gaq != "undefined" && _gaq.push(["c._trackEvent"].concat(n))
    },
    showErrorMessage: function(n) {
        Roblox.JSErrorTracker.showAlert && (n !== null ? alert(n) : alert("An error occured"))
    }
};