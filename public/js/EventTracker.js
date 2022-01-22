EventTracker = new function() {
    var n = this;
    n.logMetrics = !1, n.transmitMetrics = !0;
    var i = new function() {
            var n = {};
            this.get = function(t) {
                return n[t]
            }, this.set = function(t, i) {
                n[t] = i
            }, this.remove = function(t) {
                delete n[t]
            }
        },
        r = function() {
            return (new Date).valueOf()
        },
        t = function(n, t) {
            var i = r();
            $.each(n, function(n, r) {
                u(r, t, i)
            })
        },
        u = function(t, r, u) {
            var e = i.get(t),
                f;
            e ? (i.remove(t), f = u - e, n.logMetrics && console.log("[event]", t, r, f), n.transmitMetrics && $.ajax({
                type: "GET",
                async: !0,
                cache: !1,
                timeout: 5e4,
                url: "/Game/JoinRate.ashx?c=" + t + "&r=" + r + "&d=" + f,
                success: function() {}
            })) : n.logMetrics && console.log("[event]", "ERROR: event not started -", t, r)
        };
    n.start = function() {
        var n = r();
        $.each(arguments, function(t, r) {
            i.set(r, n)
        })
    }, n.endSuccess = function() {
        t(arguments, "Success")
    }, n.endCancel = function() {
        t(arguments, "Cancel")
    }, n.endFailure = function() {
        t(arguments, "Failure")
    }
};