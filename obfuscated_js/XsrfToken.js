typeof Roblox == "undefined" && (Roblox = {}), Roblox.XsrfToken = function() {
    function f(n) {
        var u, t;
        if (i.allUrlsEnabled) return !0;
        for (u = n.split("?")[0].toLowerCase(), t = 0; t < r.length; t++)
            if (r[t] === u) return !0;
        return !1
    }

    function e(n) {
        r.push(n.toLowerCase())
    }

    function o(t) {
        n = t
    }

    function u() {
        return n
    }
    var n = "",
        t = /(^|\?|&)token=[^&]*/,
        r = ["/chat/friendhandler.ashx", "/chat/party.ashx", "/chat/send.ashx", "/chat/utility.ashx", "/groups/rolesetupdater.ashx", "groups.aspx/exileuseranddeleteposts", "emailupgrademe.ashx", "/facebook/share-character", "/services/usercheck.asmx/updatepersonalinfo", "/usercheck/updatepersonalinfo", "/thumbs/assetmedia/placemediaitemsorthandler.ashx", "inventoryhandler.ashx", "/trade/tradehandler.ashx", "tradehandler.ashx", "/webhandlers/socialnetworkpusher.ashx", "/api/item.ashx", "/build/set-place-state", "/api/comments.ashx", "/userads/deletead", "/userads/processadpurchase", "/authentication/signoutfromallsessionsandreauthenticate", "/home/updatestatus", "/places/thumbnails/add-video", "/places/thumbnails/add-image", "/places/thumbnails/remove", "/home/updatestatus", "/places/revert", "/places/developerproducts/add", "/places/developerproducts/update", "/places/developerproducts/delete", "/apps/thumbnails/add-image", "/apps/thumbnails/add-video", "/apps/actions/create", "/apps/actions/delete", "/apps/template/create", "/apps/template/delete", "/thumbnail/set-asset-media-sort-order", "/thumbnail/remove-asset-media", "/messages/send"],
        i;
    return $.ajaxPrefilter(function(i) {
        if (i.dataType != "jsonp" && i.dataType != "script" && n != "" && f(i.url)) {
            t.test(i.url) || typeof i.data != "undefined" && t.test(i.data) || (i.url += /\?/.test(i.url) ? "&token=" + encodeURIComponent(n) : "?token=" + encodeURIComponent(n));
            var e = i.error;
            i.error = function(r, u, f) {
                if (r.status == 420) {
                    var o = r.getResponseHeader("Token");
                    if (o == null) {
                        typeof e == "function" && e(r, u, f);
                        throw new Error("Null token returned by Xsrf enabled handler");
                    }
                    t.test(i.url) ? i.url = i.url.replace(t, "$1token=" + encodeURIComponent(o)) : i.data = i.data.replace(t, "$1token=" + encodeURIComponent(o)), $.ajax(i), n = o
                } else typeof e == "function" && e(r, u, f)
            }
        }
    }), i = {
        setToken: o,
        getToken: u,
        allUrlsEnabled: !1,
        addEnabledUrl: e
    }
}();