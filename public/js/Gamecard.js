var Roblox = Roblox || {};
$(function() {
    $("#pin").keydown(function(n) {
        n.which == 13 && (n.preventDefault(), Roblox.GameCard.redeemCode())
    })
}), Roblox.GameCard = new function() {
    function n(n) {
        n.is(":visible") && (n.hide(), n.show())
    }

    function i() {
        $("#busy").css("visibility", "hidden"), $("#errorText").html(Roblox.GameCard.Resources.unexpectedError), $("#error").show()
    }

    function t(t) {
        $("#busy").css("visibility", "hidden"), typeof t.errorMsg != "undefined" && t.errorMsg == "" ? ($("#pin").val(""), $("#balance").html(t.balance), $("#SuccessMessage").html(t.successMsg), $("#SuccessMessageSubText").html(t.successSubText), $("#success").show(), $("#buyStuff").show(), typeof t.bonusMsg != "undefined" && t.bonusMsg != "" ? ($("#Message").html(t.bonusMsg), $("#Message").show()) : $("#Message").hide(), typeof t.callBack != "undefined" && t.callback != "" && eval(t.callback)) : ($("#errorText").html(t.errorMsg), $("#error").show()), $.browser.msie && (n($("#buyStuff")), n($("#MoreInfo")))
    }
    return {
        redeemCode: function() {
            var r, u;
            $("#busy").css("visibility", "visible"), $("#success").hide(), $("#error").hide(), $.browser.msie && (n($("#buyStuff")), n($("#MoreInfo"))), r = $("#pin").val().replace(/\./g, "").replace(/ /g, ""), r.length === 12 ? $.ajax({
                type: "GET",
                url: "/Upgrades/GiftCard.ashx",
                contentType: "application/json; charset=utf-8",
                data: {
                    action: "redeem",
                    code: r
                },
                dataType: "json",
                success: t,
                error: i
            }) : r.length === 10 ? (u = Math.floor(Math.random() * 9001), $.ajax({
                type: "GET",
                url: "/Gamecard/InCommHandler.ashx",
                contentType: "application/json; charset=utf-8",
                data: {
                    pin: r,
                    cachebuster: u
                },
                dataType: "json",
                success: t,
                error: i
            })) : ($("#busy").css("visibility", "hidden"), $("#errorText").html(Roblox.GameCard.Resources.unrecognizedPin), $("#error").show())
        }
    }
};