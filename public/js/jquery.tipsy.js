(function(n) {
    function i(n, t) {
        return typeof n == "function" ? n.call(t) : n
    }

    function r(n) {
        while (n = n.parentNode)
            if (n == document) return !0;
        return !1
    }

    function t(t, i) {
        this.$element = n(t), this.options = i, this.enabled = !0, this.fixTitle()
    }
    t.prototype = {
        show: function() {
            var s = this.getTitle(),
                r;
            if (s && this.enabled) {
                r = this.tip(), r.find(".tipsy-inner")[this.options.html ? "html" : "text"](s), r[0].className = "tipsy", r.remove().css({
                    top: 0,
                    left: 0,
                    visibility: "hidden",
                    display: "block"
                }).prependTo(document.body);
                var t = n.extend({}, this.$element.offset(), {
                        width: this.$element[0].offsetWidth,
                        height: this.$element[0].offsetHeight
                    }),
                    e = r[0].offsetWidth,
                    o = r[0].offsetHeight,
                    f = i(this.options.gravity, this.$element[0]),
                    u;
                switch (f.charAt(0)) {
                    case "n":
                        u = {
                            top: t.top + t.height + this.options.offset,
                            left: t.left + t.width / 2 - e / 2
                        };
                        break;
                    case "s":
                        u = {
                            top: t.top - o - this.options.offset,
                            left: t.left + t.width / 2 - e / 2
                        };
                        break;
                    case "e":
                        u = {
                            top: t.top + t.height / 2 - o / 2,
                            left: t.left - e - this.options.offset
                        };
                        break;
                    case "w":
                        u = {
                            top: t.top + t.height / 2 - o / 2,
                            left: t.left + t.width + this.options.offset
                        }
                }
                f.length == 2 && (u.left = f.charAt(1) == "w" ? t.left + t.width / 2 - 15 : t.left + t.width / 2 - e + 15), r.css(u).addClass("tipsy-" + f), r.find(".tipsy-arrow")[0].className = "tipsy-arrow tipsy-arrow-" + f.charAt(0), this.options.className && r.addClass(i(this.options.className, this.$element[0])), this.options.fade ? r.stop().css({
                    opacity: 0,
                    display: "block",
                    visibility: "visible"
                }).animate({
                    opacity: this.options.opacity
                }) : r.css({
                    visibility: "visible",
                    opacity: this.options.opacity
                })
            }
        },
        hide: function() {
            this.options.fade ? this.tip().stop().fadeOut(function() {
                n(this).remove()
            }) : this.tip().remove()
        },
        fixTitle: function() {
            var n = this.$element;
            (n.attr("title") || typeof n.attr("original-title") != "string") && n.attr("original-title", n.attr("title") || "").removeAttr("title")
        },
        getTitle: function() {
            var i = this.$element,
                n = this.options,
                t;
            return this.fixTitle(), n = this.options, typeof n.title == "string" ? t = i.attr(n.title == "title" ? "original-title" : n.title) : typeof n.title == "function" && (t = n.title.call(i[0])), t = ("" + t).replace(/(^\s*|\s*$)/, ""), t || n.fallback
        },
        tip: function() {
            return this.$tip || (this.$tip = n('<div class="tipsy"></div>').html('<div class="tipsy-arrow"></div><div class="tipsy-inner"></div>'), this.$tip.data("tipsy-pointee", this.$element[0])), this.$tip
        },
        validate: function() {
            this.$element[0].parentNode || (this.hide(), this.$element = null, this.options = null)
        },
        enable: function() {
            this.enabled = !0
        },
        disable: function() {
            this.enabled = !1
        },
        toggleEnabled: function() {
            this.enabled = !this.enabled
        }
    }, n.fn.tipsy = function(i) {
        function r(r) {
            var u = n.data(r, "tipsy");
            return u || (u = new t(r, n.fn.tipsy.elementOptions(r, i)), n.data(r, "tipsy", u)), u
        }

        function s() {
            var n = r(this);
            n.hoverState = "in", i.delayIn == 0 ? n.show() : (n.fixTitle(), setTimeout(function() {
                n.hoverState == "in" && n.show()
            }, i.delayIn))
        }

        function h() {
            var n = r(this);
            n.hoverState = "out", i.delayOut == 0 ? n.hide() : setTimeout(function() {
                n.hoverState == "out" && n.hide()
            }, i.delayOut)
        }
        var u;
        if (i === !0) return this.data("tipsy");
        if (typeof i == "string") return u = this.data("tipsy"), u && u[i](), this;
        if (i = n.extend({}, n.fn.tipsy.defaults, i), i.live || this.each(function() {
                r(this)
            }), i.trigger != "manual") {
            var f = i.live ? "live" : "bind",
                o = i.trigger == "hover" ? "mouseenter" : "focus",
                e = i.trigger == "hover" ? "mouseleave" : "blur";
            this[f](o, s)[f](e, h)
        }
        return this
    }, n.fn.tipsy.defaults = {
        className: null,
        delayIn: 0,
        delayOut: 0,
        fade: !1,
        fallback: "",
        gravity: "n",
        html: !1,
        live: !1,
        offset: 0,
        opacity: .8,
        title: "title",
        trigger: "hover"
    }, n.fn.tipsy.revalidate = function() {
        n(".tipsy").each(function() {
            var t = n.data(this, "tipsy-pointee");
            t && r(t) || n(this).remove()
        })
    }, n.fn.tipsy.elementOptions = function(t, i) {
        return n.metadata ? n.extend({}, i, n(t).metadata()) : i
    }, n.fn.tipsy.autoNS = function() {
        return n(this).offset().top > n(document).scrollTop() + n(window).height() / 2 ? "s" : "n"
    }, n.fn.tipsy.autoWE = function() {
        return n(this).offset().left > n(document).scrollLeft() + n(window).width() / 2 ? "e" : "w"
    }, n.fn.tipsy.autoBounds = function(t, i) {
        return function() {
            var r = {
                    ns: i[0],
                    ew: i.length > 1 ? i[1] : !1
                },
                f = n(document).scrollTop() + t,
                e = n(document).scrollLeft() + t,
                u = n(this);
            return u.offset().top < f && (r.ns = "n"), u.offset().left < e && (r.ew = "w"), n(window).width() + n(document).scrollLeft() - u.offset().left < t && (r.ew = "e"), n(window).height() + n(document).scrollTop() - u.offset().top < t && (r.ns = "s"), r.ns + (r.ew ? r.ew : "")
        }
    }
})(jQuery);