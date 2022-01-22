Roblox.define("Pagelets.BestFriends", ["/CSS/My/BestFriends.css", "jQuery", "Widgets.AvatarImage"], function(n, t) {
    function i(i) {
        n.get("/my/best-friends", function(r) {
            n(i).html(r), t.populate()
        })
    }
    return {
        init: i
    }
});