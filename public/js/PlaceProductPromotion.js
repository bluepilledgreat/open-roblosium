var Roblox = Roblox || {};
Roblox.PlaceProductPromotion = function() {
    function o(n) {
        return n.__RequestVerificationToken = $("input[name=__RequestVerificationToken]").val(), n
    }

    function e(n, t) {
        var i = Math.floor(Math.random() * 9001);
        $.ajax({
            type: "GET",
            url: "/PlaceItem/GetPlaceProductPromotions?placeId=" + Roblox.PlaceProductPromotion.PlaceID + "&startIndex=" + n + "&maxRows=" + t + "&cachebuster=" + i,
            contentType: "application/json; charset=utf-8",
            success: function(n) {
                Roblox.PlaceProductPromotionPager.update(n)
            },
            error: function() {
                $("#PromotionsItemContainer").addClass("empty").text(Roblox.Resources.PlaceProductPromotion.anErrorOccurred)
            }
        })
    }

    function f() {
        function t(n) {
            return n.__RequestVerificationToken = $("input[name=__RequestVerificationToken]").val(), n
        }
        var i = $("#PlaceProductPromotionInput").val(),
            n;
        $(".PromoteModalErrorMessage").hide(), n = $("#PlaceProductPromotionSelectionPanel"), $.ajax({
            type: "POST",
            url: "/PlaceItem/AddProductPromotionToPlace?placeId=" + i + "&productId=" + Roblox.PlaceProductPromotionData.ProductID,
            data: t({}),
            dataType: "json",
            success: function(t) {
                if (t.ErrorMsg) n.find(".PromoteModalErrorMessage").text(t.ErrorMsg).show();
                else {
                    var i = $("<div>" + Roblox.Resources.PlaceProductPromotion.youhaveAdded + "<span></span>" + Roblox.Resources.PlaceProductPromotion.toYourGame + "<a></a></div>");
                    i.find("span").html(Roblox.PlaceProductPromotionData.ProductName), i.find("a").attr("href", t.PlaceURL).text(t.PlaceName), n.find(".roblox-item-image").html("").addClass("thumbs-up-green"), n.find(".PurchaseModalMessageText").html(i).addClass("SuccessMsg"), n.find(".PurchaseModalButtonContainer .promoteBtn").hide(), n.find(".titleBar").text(Roblox.Resources.PlaceProductPromotion.success), n.find(".PurchaseModalFooter").text(""), n.find(".PurchaseModalButtonContainer .btn-negative").removeClass("btn-negative").addClass("btn-neutral").html(Roblox.Resources.PlaceProductPromotion.ok + '<span class="btn-text">' + Roblox.Resources.PlaceProductPromotion.ok + "</span>")
                }
            },
            error: function(n) {
                $(".PromoteModalErrorMessage").text(n.ErrorMsg).show()
            }
        })
    }

    function n(n) {
        $.ajax({
            type: "POST",
            url: "/PlaceItem/DeletePlaceProductPromotion?promotionId=" + n,
            data: o({}),
            success: function() {
                var i = $('.DeleteProductPromotion[data-delete-promotion-id="' + n + '"]').parent().find(".NameDiv").html();
                $("#DeleteProductPromotionModal .titleBar").text(Roblox.Resources.PlaceProductPromotion.success), $("#DeleteProductPromotionModal .PurchaseModalMessageText").html(Roblox.Resources.PlaceProductPromotion.youhaveRemoved + "<a>" + i + "</a>" + Roblox.Resources.PlaceProductPromotion.fromYourGame), $("#DeleteProductPromotionModal").modal(Roblox.PlaceProductPromotion.modalProperties), Roblox.PlaceProductPromotionPager.getItemsPaged(1, 3)
            },
            error: function() {
                $("#DeleteProductPromotionModal .titleBar").text(Roblox.Resources.PlaceProductPromotion.error), $("#DeleteProductPromotionModal .PurchaseModalMessageText").text(Roblox.Resources.PlaceProductPromotion.sorryWeCouldnt), $("#DeleteProductPromotionModal").modal(Roblox.PlaceProductPromotion.modalProperties)
            }
        })
    }

    function r(n) {
        if (n.length == 0 && $("#PromotionsItemContainer .PlaceProductPromotionItem").length == 0) {
            $("#PromotionsItemContainer").addClass("empty").html($(".PromotionsItemContainer.empty").html());
            return
        }
        var t = $(".PlaceProductPromotionItem.template").clone().removeClass("template");
        return t.find(".ItemURL").attr("href", n.ItemUrl).html(fitStringToWidthSafe(n.Name, 185)), t.find(".TotalSales").text(n.TotalSales), t.find(".DeleteProductPromotion").attr("data-delete-promotion-id", n.PromotionID), n.PriceInRobux != undefined ? (t.find(".Price").text(n.PriceInRobux), t.find(".PurchaseButton").attr("data-expected-price", n.PriceInRobux).attr("data-promotion-id", n.PromotionID)) : n.PriceInTickets != undefined ? (t.find(".Price").removeClass("robux").addClass("tickets").text(n.PriceInTickets), t.find(".PurchaseButton").attr("data-expected-currency", 2).removeAttr("data-promotion-id").attr("data-expected-price", n.PriceInTickets).removeAttr("data-placeproductpromotion-id")) : t.find(".Price").remove(), n.IsForSale || (t.find(".PurchaseButton").hide(), t.find(".UserOwns").html(Roblox.Resources.PlaceProductPromotion.notForSale).show()), t.find(".PurchaseButton").attr("data-expected-seller-id", n.SellerID).attr("data-seller-name", n.SellerName).attr("data-item-name", n.Name), n.UserOwns === !0 && (t.find(".PurchaseButton").hide(), t.find(".UserOwns").show()), n.IsRentable === !0 && t.find(".PurchaseButton").html(Roblox.Resources.PlaceProductPromotion.rent + "<span class=btn-text>" + Roblox.Resources.PlaceProductPromotion.rent + "</span>"), t.find("[data-bc-requirement]").attr("data-bc-requirement", n.BCRequirement), t.find("[data-item-id]").attr("data-item-id", n.AssetID), t.find("[data-product-id]").attr("data-product-id", n.ProductID), t.find("[data-placeproductpromotion-id]").attr("data-placeproductpromotion-id", n.PromotionID), t
    }

    function i(n) {
        var i = $(".PlaceProductPromotionItem .roblox-item-image[data-item-id=" + n.AssetID + "]").parent(),
            r = i.find(".roblox-item-image"),
            t;
        Roblox.require("Widgets.ItemImage", function(n) {
            n.load(r)
        }), t = i.find(".PurchaseButton"), t.unbind(), t.click(function() {
            return Roblox.PlaceProductPromotionItemPurchase.openPurchaseVerificationView(t[0]), !1
        }), i.find(".DeleteProductPromotion").click(function() {
            var n = $(this).data("delete-promotion-id");
            Roblox.PlaceProductPromotion.DeleteProductPromotion(n)
        })
    }

    function t(n) {
        var t = $("#PlaceProductPromotionInput");
        $.each(n.UserPlaces, function(n, i) {
            t.append($("<option></option>").attr("value", i.value).html(i.label))
        }), $(".promoteBtn").click(function() {
            return Roblox.PlaceProductPromotion.AddPlaceProductPromotion(), !1
        }), $(".PromoteModalBtn").click(function() {
            var n = {
                escClose: !0,
                opacity: 80,
                overlayCss: {
                    backgroundColor: "#000"
                }
            };
            $("#PlaceProductPromotionSelectionPanel").modal(n), Roblox.require("Widgets.ItemImage", function(n) {
                n.populate($("#PlaceProductPromotionSelectionPanel .roblox-item-image"))
            })
        })
    }
    var s, u = {
        escClose: !0,
        opacity: 80,
        overlayCss: {
            backgroundColor: "#000"
        }
    };
    return {
        GetPlacePromotions: e,
        FormatPlacePromotion: r,
        FormatPlacePromotionCallback: i,
        DeleteProductPromotion: n,
        modalProperties: u,
        AddPlaceProductPromotion: f,
        SetUpAddPlaceProductPromotion: t
    }
}();