$(function() {
    try {
        $(".tooltip").tipsy(), $(".tooltip-top").tipsy({
            gravity: "s"
        }), $(".tooltip-right").tipsy({
            gravity: "w"
        }), $(".tooltip-left").tipsy({
            gravity: "e"
        }), $(".tooltip-bottom").tipsy({
            gravity: "n"
        })
    } catch (n) {}
}), typeof Roblox == "undefined" && (Roblox = {}), Roblox.FixedUI = function() {
    function u(n) {
        for (var i = [".forceSpace", "#Container", ".mySubmenuFixed", ".BannerRedesign", ".site-header", "#MasterContainer", "body", "#Footer", ".forceSpaceUnderSubmenu"], t = 0; t < i.length; t++) n ? $(i[t]).removeClass("unfixed") : $(i[t]).addClass("unfixed")
    }

    function f() {
        var n = 1024;
        return document.body && document.body.offsetWidth && (n = document.body.offsetWidth), window.innerWidth && window.innerHeight && (n = window.innerWidth), n
    }

    function t() {
        u(f() >= 978)
    }
    var n = navigator.userAgent.toLowerCase(),
        r = /mobile/i.test(n) || /ipad/i.test(n) || /iphone/i.test(n) || /android/i.test(n) || /playbook/i.test(n) || /blackberry/i.test(n),
        i;
    return $(function() {
        r ? u(!1) : $(window).load(t).resize(t)
    }), i = {
        isMobile: r,
        gutterAdsEnabled: !1
    }
}();