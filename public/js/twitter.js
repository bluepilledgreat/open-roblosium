! function(n, t, i) {
    var r, u = n.getElementsByTagName(t)[0];
    n.getElementById(i) || (r = n.createElement(t), r.id = i, r.src = "//platform.twitter.com/widgets.js", u.parentNode.insertBefore(r, u))
}(document, "script", "twitter-wjs");