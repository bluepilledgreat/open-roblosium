$(function() {
    var n = 1500;
    $.fn.loadRobloxThumbnails = function() {
        function t(i) {
            var r = i.data("retry-url");
            $.ajax({
                url: r,
                dataType: "json",
                cache: !1,
                success: function(r) {
                    if (r.Final) {
                        var u = i.find("img");
                        u.attr("src", r.Url), i.removeAttr("data-retry-url")
                    } else i.retryCount = i.retryCount ? i.retryCount + 1 : 1, i.retryCount < 10 && setTimeout(function() {
                        t(i)
                    }, n)
                }
            })
        }
        return this.each(function() {
            var i = $(this);
            setTimeout(function() {
                t(i)
            }, n)
        })
    }
});