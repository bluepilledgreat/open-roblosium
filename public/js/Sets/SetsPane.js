typeof Roblox == "undefined" && (Roblox = {}), Roblox.SetsPane = function(n, t) {
    function i(t) {
        var r = $("#SetsPaneItemTemplate").clone().removeAttr("id").addClass("TiledSets").show(),
            i;
        for (i in t) typeof t[i] == "string" && (t[i] = t[i].escapeHTML()), r.html(r.html().replace("$" + i, t[i]));
        return r.html(r.html().replace("$BaseUrl", n)), r
    }
    return this.isVisible = function(n) {
        return n.attr("style").toLowerCase().indexOf("display:none") > -1 || n.attr("style").toLowerCase().indexOf("display: none") > -1 ? !1 : !0
    }, this.addEllipses = function(n) {
        var i = !(n === null || n === undefined),
            r = $(".TiledSets .AssetName a" + (i ? ":contains('" + n.Name + "')" : "")),
            t;
        r != null && r.each(function() {
            $(this).html(fitStringToWidthSafe($(this).html(), 90))
        }), t = $(".TiledSets .AssetCreator .Detail a" + (i ? ":contains('" + n.CreatorName + "')" : "")), t != null && t.each(function() {
            $(this).html(fitStringToWidthSafe($(this).html(), 55))
        })
    }, this.getSetsPaged = function(n, i) {
        $.getJSON("/Sets/SetHandler.ashx?rqtype=getsets&maxsets=10&UserID=" + t, function(t) {
            Roblox.OwnedSetsJSDataPager.update({
                data: t.slice(n - 1, n - 1 + i),
                totalItems: t.length
            })
        })
    }, this.getSubscribedSetsPaged = function(n, i) {
        $.getJSON("/Sets/SetHandler.ashx?rqtype=getsubscribedsets&maxsets=10&UserID=" + t, function(t) {
            Roblox.SubscribedSetsJSDataPager.update({
                data: t.slice(n - 1, n - 1 + i),
                totalItems: t.length
            })
        })
    }, this.ownedItemFormatter = function(n) {
        return typeof n === undefined || n === null || n.length === 0 ? '<div class="NoSets">This user has no sets.</div>' : i(n)
    }, this.subscribedItemFormatter = function(n) {
        return typeof n === undefined || n === null || n.length === 0 ? '<div class="NoSets">This user is not subscribed to any sets.</div>' : i(n)
    }, this.getSetAssetImageThumbnail = function(n) {
        $.get("/Thumbs/RawAsset.ashx?AssetID=" + n.ImageAssetID + "&Width=75&Height=75&ImageFormat=png", function(t) {
            if (t !== null) {
                if (t == "PENDING") {
                    $(".AssetThumbnail ." + n.ImageAssetID).attr("src", "/images/spinners/spinner16x16.gif"), window.setTimeout(function() {
                        Roblox.SetsPaneObject.getSetAssetImageThumbnail(n)
                    }, 2e3);
                    return
                }
                $(".AssetThumbnail ." + n.ImageAssetID).attr("src", t)
            }
        }), Roblox.SetsPaneObject.addEllipses()
    }, this.toggleBetweenSetsOwnedSubscribed = function() {
        var t = $("#OwnedSetsContainerDiv"),
            n = $("#SubscribedSetsContainerDiv");
        Roblox.SetsPaneObject.isVisible(n) ? (n.css("display", "none"), t.css("display", "block"), $("#ToggleBetweenOwnedSubscribedSets").text("View Subscribed"), $("#ToggleBetweenOwnedSubscribedSets").append('<span class="btn-text" id="SetsToggleSpan">View Subscribed</span>')) : (t.css("display", "none"), n.css("display", "block"), $("#ToggleBetweenOwnedSubscribedSets").text("View Owned"), $("#ToggleBetweenOwnedSubscribedSets").append('<span class="btn-text" id="SetsToggleSpan">View Owned</span>')), Roblox.SetsPaneObject.addEllipses()
    }, this
};