$(function() {
    function t() {
        if ($("#txtStatusMessage").prop("disabled")) return !1;
        var i = $("#HomeContainer").data("update-status-url"),
            r = $("#txtStatusMessage").val(),
            n = $("#sendToFacebook").is(":checked"),
            t = {
                status: r,
                sendToFacebook: n
            };
        $("#shareButton").hide(), $("#loadingImage").show(), $.post(i, t, function(n) {
            n.success ? $("#txtStatusMessage").val(n.message) : $("#txtStatusMessage").val(""), $("#txtStatusMessage").blur(), $("#shareButton").show(), $("#loadingImage").hide()
        })
    }
    var i, r, n;
    Roblox.require("Pagelets.BestFriends", function(n) {
        n.init("#bestFriendsContainer")
    }), $.getJSON("/GetRecentlyVisitedPlaces.ashx", {
        GameType: "All",
        m: "RecentlyVisited",
        p: 0,
        PageSize: 5
    }, function(n) {
        n.Count > 0 ? $(n.Items).each(function(n, t) {
            var i = $("#RecentlyVisitedPlaceTemplate").clone().removeAttr("id").show();
            i.find(".recent-place-thumb").append('<img src="' + t.ThumbnailUrl + '" alt="' + t.Name.escapeHTML() + '" class="recent-place-thumb-img" />'), i.find(".recent-place-name").append('<a href="' + t.NavigateUrl + '">' + fitStringToWidth(t.Name, 200, "recent-place-name") + " </a>"), t.PersonalPlaceOverlay.Url != null && i.find(".recent-place-name").append('<img border="0" alt="Personal Server" src="/images/icons/personal_server.png" class="recent-place-thumb-ps-overlay" />'), i.find(".recent-place-players-online").html(t.Stats.CurrentPlayersCount + " players online"), $("#RecentlyVisitedPlaces").append(i)
        }) : ($("#PlayGames").show(), $("#SeeMore").hide())
    }), i = $("#HomeContainer").data("facebook-share"), $("#btnFacebookShare").click(function() {
        $.post(i, function(n) {
            $("#btnFacebookShare").removeClass(), n.success ? $("#facebookShareResult").addClass("status-confirm") : $("#facebookShareResult").addClass("status-error"), $("#facebookShareResult").text(n.message), $("#facebookShareResult").fadeIn().delay(5e3).fadeOut()
        })
    }), r = "/feedifications/get", $.get(r, function(n) {
        $("#FeedificationsContainer").html(n), $("#FeedificationsContainer .feedification").length == 0 && $("#FeedificationsContainer").removeClass("feed-container")
    }).fail(function() {
        $("#FeedificationsLoadingIndicator").hide(), $("#FeedificationsLoadingError").show()
    }), n = $("#HomeContainer").data("get-feed-url"), $.get(n, function(n) {
        $("#AjaxFeed").html(n)
    }).fail(function() {
        $("#AjaxFeedError").show(), $("#AjaxFeed").hide()
    }), $("span[data-retry-url]").loadRobloxThumbnails(), $("#shareButton").click(function() {
        t()
    }), $("#txtStatusMessage").keypress(function(n) {
        n.which == "13" && t()
    })
});