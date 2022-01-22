(function(n) {
    n.toJSON = function(t) {
        var s, o, p, h, f, e, r, v, c, a, u, l, i, y;
        if (typeof JSON == "object" && JSON.stringify) return JSON.stringify(t);
        if (i = typeof t, t === null) return "null";
        if (i == "undefined") return undefined;
        if (i == "number" || i == "boolean") return t + "";
        if (i == "string") return n.quoteString(t);
        if (i == "object") {
            if (typeof t.toJSON == "function") return n.toJSON(t.toJSON());
            if (t.constructor === Date) return s = t.getUTCMonth() + 1, s < 10 && (s = "0" + s), o = t.getUTCDate(), o < 10 && (o = "0" + o), p = t.getUTCFullYear(), h = t.getUTCHours(), h < 10 && (h = "0" + h), f = t.getUTCMinutes(), f < 10 && (f = "0" + f), e = t.getUTCSeconds(), e < 10 && (e = "0" + e), r = t.getUTCMilliseconds(), r < 100 && (r = "0" + r), r < 10 && (r = "0" + r), '"' + p + "-" + s + "-" + o + "T" + h + ":" + f + ":" + e + "." + r + 'Z"';
            if (t.constructor === Array) {
                for (v = [], c = 0; c < t.length; c++) v.push(n.toJSON(t[c]) || "null");
                return "[" + v.join(",") + "]"
            }
            a = [];
            for (u in t) {
                if (i = typeof u, i == "number") l = '"' + u + '"';
                else if (i == "string") l = n.quoteString(u);
                else continue;
                typeof t[u] != "function" && (y = n.toJSON(t[u]), a.push(l + ":" + y))
            }
            return "{" + a.join(", ") + "}"
        }
    }, n.evalJSON = function(n) {
        return typeof JSON == "object" && JSON.parse ? JSON.parse(n) : eval("(" + n + ")")
    }, n.secureEvalJSON = function(n) {
        if (typeof JSON == "object" && JSON.parse) return JSON.parse(n);
        var t = n;
        if (t = t.replace(/\\["\\\/bfnrtu]/g, "@"), t = t.replace(/"[^"\\\n\r]*"|true|false|null|-?\d+(?:\.\d*)?(?:[eE][+\-]?\d+)?/g, "]"), t = t.replace(/(?:^|:|,)(?:\s*\[)+/g, ""), /^[\],:{}\s]*$/.test(t)) return eval("(" + n + ")");
        throw new SyntaxError("Error parsing JSON, source is not valid.");
    }, n.quoteString = function(n) {
        return n.match(t) ? '"' + n.replace(t, function(n) {
            var t = i[n];
            return typeof t == "string" ? t : (t = n.charCodeAt(), "\\u00" + Math.floor(t / 16).toString(16) + (t % 16).toString(16))
        }) + '"' : '"' + n + '"'
    };
    var t = /["\\\x00-\x1f\x7f-\x9f]/g,
        i = {
            "\b": "\\b",
            "\t": "\\t",
            "\n": "\\n",
            "\f": "\\f",
            "\r": "\\r",
            '"': '\\"',
            "\\": "\\\\"
        }
})(jQuery);