var Roblox = Roblox || {};
Roblox.ItemPurchase = function(n) {
    function r(n) {
        n += "", x = n.split("."), x1 = x[0], x2 = x.length > 1 ? "." + x[1] : "";
        for (var t = /(\d+)(\d{3})/; t.test(x1);) x1 = x1.replace(t, "$1,$2");
        return x1 + x2
    }

    function y(n) {
        return n < 1 ? n + "" : n < 1e4 ? r(n) : n >= 1e6 ? Math.floor(n / 1e6) + "M+" : Math.floor(n / 1e3) + "K+"
    }

    function e() {
        window.location.href = "/login/Default.aspx?ReturnUrl=" + encodeURIComponent(location.pathname + location.search)
    }

    function f(n) {
        var t = {
            overlayClose: !0,
            opacity: 80,
            overlayCss: {
                backgroundColor: "#000"
            }
        };
        typeof n != "undefined" && n !== "" && $.modal.close("." + n), $("#ProcessingView").modal(t)
    }

    function u(n, t) {
        var r;
        if (f(t), r = $(n), !r.hasClass("btn-disabled-primary")) {
            var l = r.attr("data-product-id"),
                h = parseInt(r.attr("data-expected-price")),
                c = r.attr("data-expected-currency"),
                u = r.attr("data-placeproductpromotion-id"),
                s = r.attr("data-expected-seller-id"),
                e = r.attr("data-userasset-id");
            $.ajax({
                type: "POST",
                url: "/API/Item.ashx?rqtype=purchase&productID=" + l + "&expectedCurrency=" + c + "&expectedPrice=" + h + (u === undefined ? "" : "&expectedPromoID=" + u) + "&expectedSellerID=" + s + (e === undefined ? "" : "&userAssetID=" + e),
                contentType: "application/json; charset=utf-8",
                success: function(n) {
                    n.statusCode == 500 ? ($.modal.close(".ProcessingView"), i(n)) : ($.modal.close(".ProcessingView"), o(n))
                },
                error: function(n) {
                    $.modal.close(".ProcessingView");
                    var t = $.parseJSON(n.responseText);
                    i(t)
                }
            })
        }
    }

    function i(n) {
        var t, r;
        if (n.showDivID === "TransactionFailureView") Roblox.GenericConfirmation.open({
            titleText: n.title,
            bodyContent: n.errorMsg,
            imageUrl: s,
            acceptText: Roblox.ItemPurchase.strings.okText,
            declineColor: Roblox.GenericConfirmation.none,
            dismissable: !0
        });
        else if (n.showDivID === "InsufficientFundsView") {
            var i = "",
                f = "",
                e = !1;
            i = n.currentCurrency == 1 ? Roblox.ItemPurchase.strings.buyText + " Robux" : Roblox.ItemPurchase.strings.tradeCurrencyText, n.currentCurrency == 1 && (e = !0, f = Roblox.ItemPurchase.strings.orText + " <a href='/My/Money.aspx?tab=TradeCurrency' style='font-weight:bold'>" + Roblox.ItemPurchase.strings.tradeCurrencyText + "</a>"), Roblox.GenericConfirmation.open({
                titleText: Roblox.ItemPurchase.strings.insufficientFundsTitle,
                bodyContent: String.format(Roblox.ItemPurchase.strings.insufficientFundsText, "<span class='currency-color CurrencyColor" + n.currentCurrency + "'>" + n.shortfallPrice + "</span>"),
                acceptText: i,
                acceptColor: Roblox.GenericConfirmation.green,
                onAccept: function() {
                    window.location = "/Upgrades/Robux.aspx"
                },
                declineText: Roblox.ItemPurchase.strings.cancelText,
                imageUrl: s,
                footerText: f,
                allowHtmlContentInBody: !0,
                allowHtmlContentInFooter: e,
                dismissable: !0
            })
        } else n.showDivID === "PriceChangedView" && (t = $(".PurchaseButton[data-item-id=" + n.AssetID + "][data-expected-currency=" + n.expectedCurrency + "][data-expected-price=" + n.expectedPrice + "]"), r = function() {
            t.attr("data-expected-price", n.currentPrice), t.attr("data-expected-currency", n.currentCurrency), u(t, "PurchaseVerificationView")
        }, Roblox.GenericConfirmation.open({
            titleText: Roblox.ItemPurchase.strings.priceChangeTitle,
            bodyContent: String.format(Roblox.ItemPurchase.strings.priceChangeText, "<span class='currency-color CurrencyColor" + n.expectedCurrency + "'>" + n.expectedPrice + "</span>", "<span class='currency-color CurrencyColor" + n.currentCurrency + "'>" + n.currentPrice + "</span>"),
            acceptText: Roblox.ItemPurchase.strings.buyNowText,
            acceptColor: Roblox.GenericConfirmation.green,
            onAccept: r,
            declineText: Roblox.ItemPurchase.strings.cancelText,
            footerText: String.format(Roblox.ItemPurchase.strings.balanceText, (n.currentCurrency == 1 ? "R$" : "Tx") + n.balanceAfterSale),
            allowHtmlContentInBody: !0,
            dismissable: !0
        }))
    }

    function c(n) {
        var f = $(n),
            nt, w, b, c, s, g, d, p, o, it;
        if (!f.hasClass("btn-disabled-primary")) {
            if (nt = f.attr("data-bc-requirement"), nt > a) {
                showBCOnlyModal("BCOnlyModal");
                return
            }
            var ft = f.attr("data-item-name"),
                k = parseInt(f.attr("data-expected-price")),
                y = f.attr("data-expected-currency"),
                ut = f.attr("data-seller-name"),
                tt = f.attr("data-asset-type"),
                rt = f.attr("data-item-id");
            if (t = tt == "Place", h === "True") {
                e();
                return
            }
            if (w = !1, f.hasClass("rentable") && (w = !0), b = y == "1" ? parseInt(v) : parseInt(l), c = b - k, s = "", s = w ? Roblox.ItemPurchase.strings.rentText : Roblox.ItemPurchase.strings.buyTextLower, c < 0) {
                g = {
                    shortfallPrice: 0 - c,
                    currentCurrency: y,
                    showDivID: "InsufficientFundsView"
                }, i(g);
                return
            }
            d = $("#ItemPurchaseAjaxData").attr("data-imageurl"), p = "", p = k == 0 ? "<span class='currency CurrencyColorFree'>" + Roblox.ItemPurchase.strings.freeText + "</span>" : "<span class='currency CurrencyColor" + y + "'>" + k + "</span>", o = "", o = y == "1" ? "R$" : "Tx", o += r(c), it = function() {
                u(n, "PurchaseVerificationView")
            }, Roblox.GenericConfirmation.open({
                titleText: Roblox.ItemPurchase.strings.buyItemTitle,
                bodyContent: String.format(Roblox.ItemPurchase.strings.buyItemText, s, ft, tt, ut, p, t ? Roblox.ItemPurchase.strings.accessText : ""),
                imageUrl: d,
                acceptText: t ? Roblox.ItemPurchase.strings.buyAccessText : Roblox.ItemPurchase.strings.buyNowText,
                acceptColor: Roblox.GenericConfirmation.green,
                onAccept: it,
                declineText: Roblox.ItemPurchase.strings.cancelText,
                footerText: String.format(Roblox.ItemPurchase.strings.balanceText, o),
                allowHtmlContentInBody: !0,
                dismissable: !0,
                onOpenCallback: function() {
                    $(".ConfirmationModal .roblox-item-image").html("").attr("data-item-id", rt), Roblox.require("Widgets.ItemImage", function(n) {
                        n.load($(".ConfirmationModal .roblox-item-image"))
                    })
                }
            })
        }
    }

    function o(i) {
        var r;
        r = i.Price == 0 ? "<span class='currency CurrencyColorFree'>" + Roblox.ItemPurchase.strings.freeText + "</span>" : "<span class='currency CurrencyColor" + i.Currency + "'>" + i.Price + "</span>";
        var e = $("#ItemPurchaseAjaxData").attr("data-imageurl"),
            o = function() {
                var n = $("#ItemPurchaseAjaxData").attr("data-continueshopping-url");
                n != undefined && n != "" && (document.location.href = n)
            },
            u = !1,
            f = "";
        i.AssetIsWearable && (f = "<a class='CustomizeCharacterLink' href='/My/Character.aspx'>" + Roblox.ItemPurchase.strings.customizeCharacterText + "</a>", u = !0), Roblox.GenericConfirmation.open({
            titleText: Roblox.ItemPurchase.strings.purchaseCompleteTitle,
            bodyContent: String.format(Roblox.ItemPurchase.strings.purchaseCompleteText, i.TransactionVerb, i.AssetName, i.AssetType, i.SellerName, r, t ? Roblox.ItemPurchase.strings.accessText : ""),
            imageUrl: e,
            acceptText: Roblox.ItemPurchase.strings.continueShoppingText,
            xToCancel: !0,
            onAccept: o,
            onCancel: function() {
                i.IsMultiPrivateSale && window.location.reload()
            },
            declineColor: Roblox.GenericConfirmation.none,
            footerText: f,
            allowHtmlContentInBody: !0,
            allowHtmlContentInFooter: u,
            dismissable: !0,
            onOpenCallback: function() {
                $(".ConfirmationModal .roblox-item-image").html("").attr("data-item-id", i.AssetID), Roblox.require("Widgets.ItemImage", function(n) {
                    n.load($(".ConfirmationModal .roblox-item-image"))
                })
            }
        }), n(i)
    }
    if (!(this instanceof Roblox.ItemPurchase)) return new Roblox.ItemPurchase(n);
    var h = $("#ItemPurchaseAjaxData").attr("data-authenticateduser-isnull"),
        v = $("#ItemPurchaseAjaxData").attr("data-user-balance-robux"),
        l = $("#ItemPurchaseAjaxData").attr("data-user-balance-tickets"),
        a = $("#ItemPurchaseAjaxData").attr("data-user-bc"),
        s = $("#ItemPurchaseAjaxData").attr("data-alerturl"),
        p = $("#ItemPurchaseAjaxData").attr("data-builderscluburl"),
        t = !1;
    return {
        showProcessingModal: f,
        purchaseItem: u,
        openPurchaseVerificationView: c,
        openPurchaseConfirmationView: o,
        redirectToLogin: e,
        purchaseConfirmationCallback: n,
        openErrorView: i,
        addCommasToMoney: r,
        formatMoney: y
    }
}, Roblox.ItemPurchase.ModalClose = function(n) {
    $.modal.close("." + n)
};