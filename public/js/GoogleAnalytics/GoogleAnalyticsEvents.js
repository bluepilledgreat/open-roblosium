var GoogleAnalyticsEvents = new function() {
    this.FireEvent = function(n) {
        if (typeof _gaq != typeof undefined) {
            var i = ["_trackEvent"],
                t = ["b._trackEvent"];
            _gaq.push(i.concat(n)), _gaq.push(t.concat(n))
        }
    }
};