typeof Roblox.GenericModal == "undefined" && (Roblox.GenericModal = function() {
    function i(t, i, u, f, e) {
        n = f;
        var o = $("div.GenericModal").filter(":first");
        o.find("div.Title").text(t), i === null ? o.addClass("noImage") : (o.find("img.GenericModalImage").attr("src", i), o.removeClass("noImage")), o.find("div.Message").html(u), e && (o.removeClass("smallModal"), o.addClass("largeModal")), o.modal(r)
    }

    function t() {
        $.modal.close(), typeof n == "function" && n()
    }
    var r = {
            overlayClose: !0,
            escClose: !0,
            opacity: 80,
            overlayCss: {
                backgroundColor: "#000"
            }
        },
        n;
    return $(function() {
        $(document).on("click", ".GenericModal .roblox-ok", function() {
            t()
        })
    }), {
        open: i
    }
}());