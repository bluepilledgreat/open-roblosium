typeof Roblox == "undefined" && (Roblox = {}), typeof Roblox.GenericConfirmation == "undefined" && (Roblox.GenericConfirmation = function() {
    function s(n) {
        var c = {
                titleText: "",
                bodyContent: "",
                footerText: "",
                acceptText: Roblox.GenericConfirmation.Resources.yes,
                declineText: Roblox.GenericConfirmation.Resources.No,
                acceptColor: u,
                declineColor: r,
                xToCancel: !1,
                onAccept: function() {
                    return !1
                },
                onDecline: function() {
                    return !1
                },
                onCancel: function() {
                    return !1
                },
                imageUrl: null,
                allowHtmlContentInBody: !1,
                allowHtmlContentInFooter: !1,
                dismissable: !0,
                fieldValidationRequired: !1,
                onOpenCallback: function() {}
            },
            o, e, h, s;
        n = $.extend({}, c, n), i.overlayClose = n.dismissable, i.escClose = n.dismissable, o = $("[roblox-confirm-btn]"), o.html(n.acceptText + "<span class='btn-text'>" + n.acceptText + "</span>"), o.attr("class", "btn-large " + n.acceptColor), o.unbind(), o.bind("click", function() {
            return n.fieldValidationRequired ? f(n.onAccept) : t(n.onAccept), !1
        }), e = $("[roblox-decline-btn]"), e.html(n.declineText + "<span class='btn-text'>" + n.declineText + "</span>"), e.attr("class", "btn-large " + n.declineColor), e.unbind(), e.bind("click", function() {
            return t(n.onDecline), !1
        }), $('[data-modal-handle="confirmation"] div.Title').text(n.titleText), h = $("[data-modal-handle='confirmation']"), n.imageUrl == null ? h.addClass("noImage") : (h.find("img.GenericModalImage").attr("src", n.imageUrl), h.removeClass("noImage")), n.allowHtmlContentInBody ? $("[data-modal-handle='confirmation'] div.Message").html(n.bodyContent) : $("[data-modal-handle='confirmation'] div.Message").text(n.bodyContent), $.trim(n.footerText) == "" ? $('[data-modal-handle="confirmation"] div.ConfirmationModalFooter').hide() : $('[data-modal-handle="confirmation"] div.ConfirmationModalFooter').show(), n.allowHtmlContentInFooter ? $('[data-modal-handle="confirmation"] div.ConfirmationModalFooter').html(n.footerText) : $('[data-modal-handle="confirmation"] div.ConfirmationModalFooter').text(n.footerText), $("[data-modal-handle='confirmation']").modal(i), s = $("a.genericmodal-close"), s.unbind(), s.bind("click", function() {
            return t(n.onCancel), !1
        }), n.xToCancel || s.hide(), n.onOpenCallback()
    }

    function n(n) {
        typeof n != "undefined" ? $.modal.close(n) : $.modal.close()
    }

    function t(t) {
        n(), typeof t == "function" && t()
    }

    function f(t) {
        if (typeof t == "function") {
            var i = t();
            if (i !== "undefined" && i == !1) return !1
        }
        n()
    }
    var o = "btn-primary",
        u = "btn-neutral",
        r = "btn-negative",
        e = "btn-none",
        i = {
            overlayClose: !0,
            escClose: !0,
            opacity: 80,
            overlayCss: {
                backgroundColor: "#000"
            }
        };
    return {
        open: s,
        close: n,
        green: o,
        blue: u,
        gray: r,
        none: e
    }
}());