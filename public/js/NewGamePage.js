$(document).ready(function() {
    $(".PurchaseButton").each(function(n, t) {
        $(t).unbind().click(function() {
            return Roblox.PlaceItemPurchase.openPurchaseVerificationView(t), !1
        })
    }), Roblox.PlaceItemPurchase = new Roblox.ItemPurchase(function(n) {
        $(".PurchaseButton[data-item-id=" + n.AssetID + "]").each(function() {
            $("#PurchaseContainer").hide(), $("#VisitButtonContainer").show()
        })
    })
});