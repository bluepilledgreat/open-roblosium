typeof Roblox == "undefined" && (Roblox = {}), Roblox.InstallationInstructions = function() {
    function i() {
        var t, i, r;
        n(), t = 0, i = $(".InstallInstructionsImage"), i && typeof $(i).attr("modalwidth") != "undefined" && (t = $(".InstallInstructionsImage").attr("modalwidth")), t > 0 ? (r = ($(window).width() - (t - 10)) / 2, $("#InstallationInstructions").modal({
            escClose: !0,
            opacity: 50,
            minWidth: t,
            maxWidth: t,
            overlayCss: {
                backgroundColor: "#000"
            },
            position: [20, r]
        })) : $("#InstallationInstructions").modal({
            escClose: !0,
            opacity: 50,
            maxWidth: $(window).width() / 2,
            minWidth: $(window).width() / 2,
            overlayCss: {
                backgroundColor: "#000"
            },
            position: [20, "25%"]
        })
    }

    function r() {
        $.modal.close()
    }

    function n() {
        var n = $(".InstallInstructionsImage");
        navigator.userAgent.match(/Mac OS X 10[_|\.]5/) ? n && typeof $(n).attr("oldmacdelaysrc") != "undefined" && $(".InstallInstructionsImage").attr("src", $(".InstallInstructionsImage").attr("oldmacdelaysrc")) : n && typeof $(n).attr("delaysrc") != "undefined" && $(".InstallInstructionsImage").attr("src", $(".InstallInstructionsImage").attr("delaysrc"))
    }
    return {
        show: i,
        hide: r
    }
}();