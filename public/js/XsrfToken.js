/*
 * ROBLOSIUM 2013
 * Deobfuscation by Matt Brown/Nostal-ia#7440. If you get any errors with this file, contact me via Discord.
 */
if (typeof Roblox == "undefined") {
    Roblox = {}
}
Roblox.XsrfToken = function() {
    function isUrlEnabled(n) {
        if (my.allUrlsEnabled) return true;
        var trimmedUrl = url.split("?")[0].toLowerCase()
        for (var i = 0; i < enabledUrls.length; i++)
            if (enabledUrls[i] === trimmedUrl) return true;
        return false
    }

    function addEnabledUrl(n) {
        enabledUrls.push(n.toLowerCase())
    }

    function setToken(t) {
        currentToken = t
    }

    function getToken() {
        return currentToken
    }
    var currentToken = "",
        tokenRegex = /(^|\?|&)token=[^&]*/,
        enabledUrls = ["/chat/friendhandler.ashx", "/chat/party.ashx", "/chat/send.ashx", "/chat/utility.ashx", "/groups/rolesetupdater.ashx", "groups.aspx/exileuseranddeleteposts", "emailupgrademe.ashx", "/facebook/share-character", "/services/usercheck.asmx/updatepersonalinfo", "/usercheck/updatepersonalinfo", "/thumbs/assetmedia/placemediaitemsorthandler.ashx", "inventoryhandler.ashx", "/trade/tradehandler.ashx", "tradehandler.ashx", "/webhandlers/socialnetworkpusher.ashx", "/api/item.ashx", "/build/set-place-state", "/api/comments.ashx", "/userads/deletead", "/userads/processadpurchase", "/authentication/signoutfromallsessionsandreauthenticate", "/home/updatestatus", "/places/thumbnails/add-video", "/places/thumbnails/add-image", "/places/thumbnails/remove", "/home/updatestatus", "/places/revert", "/places/developerproducts/add", "/places/developerproducts/update", "/places/developerproducts/delete", "/apps/thumbnails/add-image", "/apps/thumbnails/add-video", "/apps/actions/create", "/apps/actions/delete", "/apps/template/create", "/apps/template/delete", "/thumbnail/set-asset-media-sort-order", "/thumbnail/remove-asset-media", "/messages/send"]
    $.ajaxPrefilter(function(options) {
        if (options.dataType != "jsonp" && options.dataType != "script" && currentToken != "" && isUrlEnabled(options.url)) {
            if (!tokenRegex.test(options.url) && (typeof options.data == "undefined" || !tokenRegex.test(options.data))) {
                if (/\?/.test(options.url)) {
                    options.url += "&token=" + encodeURIComponent(currentToken)
                } else {
                    options.url += "?token=" + encodeURIComponent(currentToken)
                }
            }
            var oldErrorHandler = options.error;
            options.error = function(jqXHR, textStatus, errorThrown) {
                if (jqXHR.status == 420) {
                    var newToken = jqXHR.getResponseHeader("Token");
                    if (newToken == null) {
                        if (typeof oldErrorHandler == "function") {
                            oldErrorHandler(jqXHR, textStatus, errorThrown);
                        }
                        throw new Error("Null token returned by Xsrf enabled handler");
                    }
                    if (tokenRegex.test(options.url)) {
                        options.url = options.url.replace(tokenRegex, "$1token=" + encodeURIComponent(newToken))
                    } else {
                        options.data = options.data.replace(tokenRegex, "$1token=" + encodeURIComponent(newToken))
                    }
                    $.ajax(options)
                    currentToken = newToken
                } else {
                    if (typeof oldErrorHandler == "function") {
                        oldErrorHandler(jqXHR, textStatus, errorThrown)
                    }
                }
            }
        }
    })
    var my = {
        setToken: setToken,
        getToken: getToken,
        allUrlsEnabled: false,
        addEnabledUrl: addEnabledUrl
    }
    return my
}();