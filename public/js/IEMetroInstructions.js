(function() {
    function u() {
        return navigator.userAgent.indexOf("MSIE 10.0") != -1
    }

    function r() {
        try {
            return !!new ActiveXObject("htmlfile")
        } catch (n) {
            return !1
        }
    }
    var i = Roblox.Client.WaitForRoblox;
    Roblox.Client.WaitForRoblox = function(n) {
        return u() && !r() ? ($("#IEMetroInstructions").modal({
            overlayClose: !0,
            escClose: !0,
            opacity: 80,
            overlayCss: {
                backgroundColor: "#000"
            }
        }), !1) : i(n)
    }
})(window);