/*
 * ROBLOSIUM 2013
 * Deobfuscation by Matt Brown/Nostal-ia#7440. If you get any errors with this file, contact me via Discord.
 */
$(function() {
    function updateStatus() {
        if ($("#txtStatusMessage").prop("disabled")) return false;
        var statusUrl = $("#HomeContainer").data("update-status-url"),
            statusText = $("#txtStatusMessage").val(),
            toFacebook = $("#sendToFacebook").is(":checked"),
            postData = {
                status: statusText,
                sendToFacebook: toFacebook
            };
        $("#shareButton").hide(), $("#loadingImage").show(), $.post(statusUrl, postData, function(data) {
            if (data.success) {
                $("#txtStatusMessage").val(data.message)
            } else {
                $("#txtStatusMessage").val("")
            }
            $("#txtStatusMessage").blur()
            $("#shareButton").show()
            $("#loadingImage").hide()
        })
    }
    Roblox.require("Pagelets.BestFriends", function(dep) {
        dep.init("#bestFriendsContainer")
    })
    $.getJSON("/GetRecentlyVisitedPlaces.ashx", {
        GameType: "All",
        m: "RecentlyVisited",
        p: 0,
        PageSize: 5
    }, function(data) {
        if (data.Count > 0) {
            $(data.Items).each(function(index, place) {
                var template = $("#RecentlyVisitedPlaceTemplate").clone().removeAttr("id").show();
                template.find(".recent-place-thumb").append('<img src="' + place.ThumbnailUrl + '" alt="' + place.Name.escapeHTML() + '" class="recent-place-thumb-img" />')
                template.find(".recent-place-name").append('<a href="' + place.NavigateUrl + '">' + fitStringToWidth(place.Name, 200, "recent-place-name") + " </a>")
                if (place.PersonalPlaceOverlay.Url != null)
                    template.find(".recent-place-name").append('<img border="0" alt="Personal Server" src="/images/icons/personal_server.png" class="recent-place-thumb-ps-overlay" />')
                template.find(".recent-place-players-online").html(place.Stats.CurrentPlayersCount + " players online")
                $("#RecentlyVisitedPlaces").append(template)
            })
        } else {
            $("#PlayGames").show()
            $("#SeeMore").hide()
        }
    })
    var facebookShareUrl = $("#HomeContainer").data("facebook-share")
    $("#btnFacebookShare").click(function() {
        $.post(facebookShareUrl, function(data) {
            $("#btnFacebookShare").removeClass()
            if (data.success) {
                $("#facebookShareResult").addClass("status-confirm")
            } else {
                $("#facebookShareResult").addClass("status-error")
            }
            $("#facebookShareResult").text(data.message)
            $("#facebookShareResult").fadeIn().delay(5000).fadeOut()
        })
    })
    var feedificationsUrl = "/feedifications/get"
    $.get(feedificationsUrl, function(data) {
        $("#FeedificationsContainer").html(data)
        if ($("#FeedificationsContainer .feedification").length == 0)
            $("#FeedificationsContainer").removeClass("feed-container")
    }).fail(function() {
        $("#FeedificationsLoadingIndicator").hide()
        $("#FeedificationsLoadingError").show()
    })
    var feedUrl = $("#HomeContainer").data("get-feed-url")
    $.get(feedUrl, function(data) {
        $("#AjaxFeed").html(data)
    }).fail(function() {
        $("#AjaxFeedError").show(), $("#AjaxFeed").hide()
    })
    $("span[data-retry-url]").loadRobloxThumbnails(), $("#shareButton").click(function() {
        updateStatus()
    })
    $("#txtStatusMessage").keypress(function(event) {
        if (event.which == "13")
            updateStatus()
    })
});