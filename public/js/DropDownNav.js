typeof Roblox == "undefined" && (Roblox = {}), (Roblox.DropDownNav = function() {
    function i(n) {
        var i = $(n.target),
            f, u;
        i.attr("drop-down-nav-button") || (i = i.parents("[drop-down-nav-button]")), i.addClass("active"), f = i.attr("drop-down-nav-button"), u = t.filter('[drop-down-nav-container="' + f + '"]'), u.show(), t.not(u).hide(), r.not(i).removeClass("active"), n.stopPropagation(), i.trigger("showDropDown")
    }

    function u(n) {
        $("[drop-down-nav-button]").unbind("click", f), i(n), $("[drop-down-nav-button]").bind("mouseleave", e)
    }

    function e() {
        n(), $("[drop-down-nav-button]").unbind("mouseleave", e)
    }

    function f(t) {
        $("[drop-down-nav-button]").unbind("mouseenter", u), i(t), $(document).bind("click", function() {
            n()
        }), $("[drop-down-nav-button]").bind("click", o)
    }

    function o() {
        $(document).unbind("click", function() {
            n()
        }), n(), $("[drop-down-nav-button]").bind("click", i)
    }

    function n() {
        t.hide(), r.removeClass("active")
    }
    var t, r;
    $(function() {
        t = $("[drop-down-nav-container]"), r = $("[drop-down-nav-button]"), $("[drop-down-nav-button]").bind("click", f), $("[drop-down-nav-button]").bind("mouseenter", u)
    })
})();