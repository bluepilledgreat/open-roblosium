if (typeof jQuery != "undefined" && jQuery.fn.jquery != "1.7.2") var conflict = !0;
Roblox.define("jQuery", "/js/jquery/jquery-1.7.2.min.js", function() {
    return conflict ? jQuery.noConflict(!0) : jQuery
});