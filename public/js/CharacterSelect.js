typeof Roblox == "undefined" && (Roblox = {}), Roblox.CharacterSelect = function() {
    function o() {
        return n.genderID = t.male, i(1, "Male", t.male), !1
    }

    function e() {
        return n.genderID = t.female, i(0, "Female", t.female), !1
    }

    function i(t, i, r) {
        $.modal.close(".GuestModePromptModal"), n.robloxLaunchFunction(r)
    }

    function f(n) {
        for (var i = $(n), t = 0; t < i.length; t++) i[t] != undefined && (i[t].getAttribute("src") == undefined || i[t].getAttribute("src") == "") && i[t].setAttribute("src", i[t].getAttribute("delaysrc"))
    }

    function s() {
        f(".GuestPlayAvatarImage, .ABGuestPlayAvatarImage"), $("#GuestModePrompt_BoyGirl").modal({
            overlayClose: !0,
            escClose: !0,
            opacity: 80,
            overlayCss: {
                backgroundColor: "#000"
            },
            onShow: r
        })
    }

    function r(n) {
        if (n.container.innerHeight() == 15) {
            var t = -Math.floor($("#GuestModePrompt_BoyGirl").innerHeight() / 2);
            $("#GuestModePrompt_BoyGirl").css({
                position: "relative",
                top: t + "px"
            })
        }
    }

    function u() {
        $.modal.close(".GuestModePromptModal")
    }
    var t = {
            male: 2,
            female: 3
        },
        n;
    return $(function() {
        $(".VisitButtonGirlGuest").click(e), $(".VisitButtonBoyGuest").click(o)
    }), n = {
        robloxLaunchFunction: function() {},
        genderID: null,
        show: s,
        hide: u,
        placeid: undefined
    }
}();