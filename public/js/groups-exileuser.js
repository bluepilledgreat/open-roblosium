typeof Roblox == "undefined" && (Roblox = {}), Roblox.ExileModal = function() {
    function t() {
        $.modal.close("#ExileModal")
    }

    function o(t) {
        var i = {
            overlayClose: !0,
            escClose: !0,
            opacity: 80,
            overlayCss: {
                backgroundColor: "#000"
            }
        };
        r = t, n = !1, $("#ExileModal").modal(i)
    }

    function s(n, t) {
        i = n, u = t
    }

    function f() {
        n = !n
    }

    function e() {
        var f = {
            userId: r,
            deleteAllPostsOption: n,
            rolesetId: i,
            selectedGroupId: u
        };
        $.ajax({
            type: "POST",
            url: "Groups.aspx/ExileUserAndDeletePosts",
            data: JSON.stringify(f),
            contentType: "application/json; charset=utf-8",
            success: function() {
                $(".RefreshUpdatePanel").click(), t()
            }
        })
    }
    var r, u, i, n = !1;
    return {
        Exile: e,
        Close: t,
        Show: o,
        InitializeGlobalVars: s,
        SetDeletePostsBool: f
    }
}();