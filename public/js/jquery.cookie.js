jQuery.cookie = function(n, t, i) {
    var o, r, f, e, u, s;
    if (typeof t != "undefined") {
        i = i || {}, t === null && (t = "", i.expires = -1), o = "", i.expires && (typeof i.expires == "number" || i.expires.toUTCString) && (typeof i.expires == "number" ? (r = new Date, r.setTime(r.getTime() + i.expires * 864e5)) : r = i.expires, o = "; expires=" + r.toUTCString());
        var h = i.path ? "; path=" + i.path : "",
            c = i.domain ? "; domain=" + i.domain : "",
            l = i.secure ? "; secure" : "";
        document.cookie = [n, "=", encodeURIComponent(t), o, h, c, l].join("")
    } else {
        if (f = null, document.cookie && document.cookie != "")
            for (e = document.cookie.split(";"), u = 0; u < e.length; u++)
                if (s = jQuery.trim(e[u]), s.substring(0, n.length + 1) == n + "=") {
                    f = decodeURIComponent(s.substring(n.length + 1));
                    break
                } return f
    }
};