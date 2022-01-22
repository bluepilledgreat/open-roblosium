$(function () {
    if ($('.GenericForm').length > 0) {
        var IsLimitedRadioBtn = $("input[name = 'ProductOption.IsLimitedEdition'][value='True']");
        if (IsLimitedRadioBtn.attr("checked") != undefined) {
            $("input[name = 'ProductOption.IsLimitedEdition']").attr("disabled", "true");
            $("input[name = 'ProductOption.TotalAvailable']").attr("disabled", "true");
            $("input[name = 'Product.PriceInTickets']").attr("disabled", "true");
        }
        var makeCollectibleBtn = $('div[data-js-make-collectible-btn]');
        var makeCollectibleInput = $('input[data-js-make-collectible-input]');
        var itemIsCollectible = (makeCollectibleBtn.text() != "Make Collectible");
        makeCollectibleBtn.click(function () {
            if (!itemIsCollectible) {
                makeCollectibleInput.val("true");
            } else {
                makeCollectibleInput.val("false");
            }
            $('input[type="submit"]').removeAttr('disabled');
            $('input[type="submit"]').click();
        });
        if (itemIsCollectible) {
            $('.GenericForm input[type="submit"]').attr('disabled', 'disabled');
        }

        var minScale = $("#MarketingBoostPanel").data('mincale');
        var maxScale = $("#MarketingBoostPanel").data('maxscale');
        var currentValue = $("#BoostAmountScale").val();
        $("#slider").slider({
            value: currentValue,
            min: minScale,
            max: maxScale,
            step: 1,
            slide: function (event, ui) {
                $("#BoostAmountScale").val(ui.value);
            }
        });
        $("#BoostAmountScale").val($("#slider").slider("value"));
    }
    $('form:eq(1)').submit(function () {
        $('input[name="Product.AffiliatePercentageFee"]').removeAttr('disabled');
    });
});