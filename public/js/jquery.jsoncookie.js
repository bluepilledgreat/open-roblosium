function RobloxJSONCookie(n) {
    this._cookiename = n
}(function(n) {
    var t = function(n) {
        return typeof n == "object" && !(n instanceof Array) && n !== null
    };
    n.extend({
        getJSONCookie: function(t, i) {
            var r = n.cookie(t);
            return i ? r : r ? JSON.parse(r) : {}
        },
        setJSONCookie: function(i, r, u) {
            var f = "";
            return u = n.extend({
                expires: 90,
                path: "/"
            }, u), f = t(r) ? JSON.stringify(r) : r, n.cookie(i, f, u)
        },
        removeJSONCookie: function(t) {
            return n.cookie(t, null)
        },
        JSONCookie: function(t, i, r) {
            return i && n.setJSONCookie(t, i, r), n.getJSONCookie(t)
        }
    })
})(jQuery), RobloxJSONCookie.prototype = {
    Delete: function() {
        return $.removeJSONCookie(this._cookiename)
    },
    SetObj: function(n, t) {
        return t || (t = {
            path: "/"
        }), $.JSONCookie(this._cookiename, n, t)
    },
    SetJSON: function(n, t) {
        return t || (t = {
            path: "/"
        }), $.JSONCookie(this._cookiename, n, t)
    },
    GetObj: function() {
        var n = $.getJSONCookie(this._cookiename, !1);
        return n == null ? {} : n
    },
    GetJSON: function() {
        return $.getJSONCookie(this._cookiename, !0)
    }
};