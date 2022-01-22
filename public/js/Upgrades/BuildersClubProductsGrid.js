$(function() {
    $("a.product-button").click(function() {
        var i = $(this).data("pid"),
            r = $(this).data("rank"),
            n = $("#UserDataInfo").attr("data-auth"),
            t = $("#UserDataInfo").attr("data-active-bc");
        n == "false" && (window.location.href = "/NewLogin?ReturnUrl=" + encodeURIComponent(location.pathname + location.search)), n == "true" && t == "false" && (window.location.href = "/Upgrades/PaymentMethods.aspx?ap=" + i), n == "true" && t == "true" && $.ajax({
            type: "GET",
            url: "/Upgrades/BuildersClubMembershipsConfirmation",
            data: {
                productId: i,
                bcType: r
            },
            cache: !1,
            success: function(n) {
                $("#dialog-confirmation").html(n), $("#dialog-confirmation").modal({
                    overlayClose: !0,
                    escClose: !0,
                    opacity: 80,
                    overlayCss: {
                        backgroundColor: "#000"
                    }
                }), navigator.appVersion.indexOf("MSIE 7.") != -1 && $("#simplemodal-container").css("top", $("#simplemodal-container").css("top").substr(0, 3) - 200)
            }
        })
    })
});