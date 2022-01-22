Roblox.define("Widgets.DropdownMenu", ["jQuery"], function(n) {
    function t() {
        var t = n(".button").not(".init");
        t.each(function() {
            var i = n(this).outerWidth() - parseInt(n(this).css("border-left-width")) - parseInt(n(this).css("border-right-width")),
                t;
            n(this).siblings(".dropdown-list").css("min-width", i), t = n(this).siblings('.dropdown-list[data-align="right"]').first(), t.css("right", 0)
        }), n(".dropdown-list").hide(), t.click(function() {
            return n(this).hasClass("active") ? (n(this).removeClass("active"), n(this).siblings(".dropdown-list").hide()) : (n(this).addClass("active"), n(this).siblings(".dropdown-list").show()), !1
        }), n(document).click(function() {
            t.removeClass("active"), n(".dropdown-list").hide()
        }), t.addClass("init")
    }
    return {
        InitializeDropdown: t
    }
});