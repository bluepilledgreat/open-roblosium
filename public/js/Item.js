var Roblox = Roblox || {};
$(document).ready(function() {
    function t(n) {
        var i = $(n + " .SetListDropDownList"),
            r = $(n + " .SetListDropDownList .menu"),
            t = $(n + " .btn-dropdown," + n + " .btn-dropdown-active");
        i.toggleClass("invisible"), r.toggleClass("invisible"), t.toggleClass("btn-dropdown"), t.toggleClass("btn-dropdown-active")
    }

    function i() {
        var t = $(".ItemOptions").data("isdropdownhidden") == "True",
            i = $(".ItemOptions").data("isitemlimited") == "True",
            n = $(".ItemOptions").data("isitemresellable") == "True";
        t && (!i || n) && $(".ItemOptions, .ItemOptions .menu .invisible").removeClass("invisible"), n || $(".ItemOptions .delete-item-btn").removeClass("invisible")
    }
    var n = $(".DescriptionPanel .Description.Full").text();
    n.length > 150 && (n = n.substring(0, 147) + "... <a onclick=\"Roblox.Item.toggleDesc('more');\">More</a>"), $(".DescriptionPanel .Description.body").html(n), $(".PutItemUpForSaleBtn").click(function(n) {
        n.preventDefault();
        var t = {
            escClose: !0,
            opacity: 80,
            overlayCss: {
                backgroundColor: "#000"
            },
            appendTo: "form"
        };
        $("#SellItemModalContainer").modal(t)
    }), $("#SellItemModalContainer input").keyup(function() {
        Roblox.Item.validateResellInput()
    }), $("#TakeOffSale").click(function(n) {
        n.preventDefault();
        var t = {
            escClose: !0,
            opacity: 80,
            overlayCss: {
                backgroundColor: "#000"
            },
            appendTo: "form"
        };
        $("#TakeOffSaleModalContainer").modal(t)
    }), $(".SetAddButton").click(function(n) {
        n.preventDefault();
        var t = $(this),
            u = t.attr("assetid"),
            r = t.attr("setid"),
            i = "waiting" + r + "_" + u;
        t.append("<img src='/images/spinners/spinner16x16.gif' id='" + i + "'"), $.ajax({
            type: "POST",
            async: !0,
            cache: !1,
            timeout: 5e4,
            url: "/Sets/SetHandler.ashx?rqtype=addtoset&assetId=" + u + "&setId=" + r,
            success: function(n) {
                n !== null && (t.removeClass("SetAddButton"), t.addClass("SetAddButtonAlreadyContainsItem"), t.unbind("click"), $("#" + i).remove())
            },
            failure: function(n) {
                n !== null
            }
        })
    }), $("#MasterContainer").click(function() {
        var i = $(".SetListDropDownList,.SetListDropDownList .menu"),
            t = $(".btn-dropdown,.btn-dropdown-active");
        i.each(function(n, t) {
            $(t).hasClass("invisible") || $(t).toggleClass("invisible")
        }), t.each(function(n, t) {
            $(t).hasClass("btn-dropdown-active") && ($(t).toggleClass("btn-dropdown-active"), $(t).toggleClass("btn-dropdown"))
        })
    });
    $(document).on("click", function() {
        $(".SetListDropDownList").addClass("invisible"), $(".SetListDropDownList .menu").addClass("invisible"), $(".btn-dropdown-active").attr("class", "btn-dropdown")
    });
    $(".SetOptions .btn-dropdown").click(function() {
        return t(".SetOptions"), !1
    }), $(".ItemOptions .btn-dropdown").click(function() {
        return t(".ItemOptions"), !1
    }), $(".SetListDropDownList .UpdateSet").click(function(n) {
        Roblox.Item.UpdateSets(Roblox.AddToSets.setItemId, !1, n)
    }), $(".SetListDropDownList .UpdateAllSets").click(function(n) {
        Roblox.Item.UpdateSets(Roblox.AddToSets.setItemId, !0, n)
    }), $(".CreateSetButton").click(function() {
        $("#CreateSetPopupContainerDiv").modal({
            appendTo: "form",
            escClose: !0,
            opacity: 80,
            overlayCss: {
                backgroundColor: "#000"
            },
            position: [120, 0]
        })
    }), $(".PurchaseButton").each(function(n, t) {
        $(t).unbind().click(function() {
            return Roblox.CatalogItemPurchase.openPurchaseVerificationView(t), !1
        })
    }), $(".fadeInAndOut").fadeIn(1e3, "swing", function() {
        $(this).delay(6e3).fadeOut(3e3)
    }), Roblox.CatalogItemPurchase = new Roblox.ItemPurchase(function(n) {
        if (n.IsMultiPrivateSale) $(".ConfirmationModal").on("remove", function() {
            window.location.reload()
        });
        else {
            var t = "You already own this item.";
            $(".PurchaseButton").addClass("btn-disabled-primary").attr("original-title", t).tipsy()
        }
        i()
    })
}), Roblox.Item = function() {
    function u(t) {
        n = t
    }

    function f() {
        var t = $("#SellItemModalContainer input").val(),
            u;
        if (isNaN(parseInt(t)) || t != parseInt(t) + "" || t <= 0) {
            u = "Price must be a positive integer.", $("#SellItemModalContainer .error-message").text(u).show();
            return
        }
        $("#SellItemModalContainer .error-message").hide();
        var f = Math.round(t * n),
            i = f > 1 ? f : 1,
            r = t - i;
        $("#SellItemModalContainer .lblCommision").text(i > 0 ? i : ""), $("#SellItemModalContainer .lblLeftover").text(r >= 0 ? r : "")
    }

    function r(n) {
        var r = $(".DescriptionPanel .Description.body"),
            u = $(".DescriptionPanel .Description.Full"),
            t, i;
        n == "more" ? (t = "Less", r.html(u.text() + "   <a onclick=\"Roblox.Item.toggleDesc('less');\">" + t + "</a>")) : n == "less" && (i = "More", r.html(u.text().substring(0, 147) + "... <a onclick=\"Roblox.Item.toggleDesc('more');\">" + i + "</a>"))
    }

    function t(n) {
        var t = {
            overlayClose: !0,
            opacity: 80,
            overlayCss: {
                backgroundColor: "#000"
            }
        };
        typeof n != "undefined" && n !== "" && $.modal.close("." + n), $("#ProcessingView").modal(t)
    }

    function i(n, t, i) {
        var r = $(i.target).attr("setid");
        $.post("/Sets/SetHandler.ashx?rqtype=getnewestversion&assetSetItemId=" + n + (t ? "&allsets=true" : ""), function() {
            $(".UpdateInSetsContainerDiv").remove(), $("a[setid=" + r + "]").removeClass("SetAddButton").addClass("SetAddButtonAlreadyContainsItem")
        })
    }
    var n = .3;
    return {
        showProcessingModal: t,
        updateSets: i,
        toggleDesc: r,
        validateResellInput: f,
        setMarketPlaceFee: u
    }
}();