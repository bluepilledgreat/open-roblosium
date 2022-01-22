function addEllipses() {
    var n = $($(".Avatar a")[0]).width() - 5;
    $(".Name").find("a").each(function() {
        $(this).text(htmlDecode(fitStringToWidthSafe($(this).text(), n)))
    })
}

function htmlDecode(n) {
    return $("<div/>").html(n).text()
}

function updateRolesetCount() {
    $(".Members_DropDown select option:selected").html($(".Members_DropDown select option:selected").html() + " (" + $(".Members_DropDown .RolesetCountHidden").val() + ")"), $.browser.msie && $(".MembersDropDownList").width() > 485 && $(".MembersDropDownList").css("width", "485px")
}
var currentPeopleTab;
$(function() {
    var t, n;
    $(".GroupListContainer").hasClass("GroupsPage") || $("#GroupThumbnails").click(function(n) {
        var t;
        t = $(n.target).hasClass("GroupListItemContainer") ? $(n.target) : $(n.target).parentsUntil("#GroupThumbnails", ".GroupListItemContainer")[0], $(t).hasClass("GroupListItemContainer") && (window.location = $(t).find("a")[0].href)
    }), window.location.href.indexOf("/My/") > -1 && (t = $("#GroupDesc_Full"), t.length > 0 && (n = t.val(), n.length > 150 && (n = n.substring(0, 147) + "... <a onclick=\"toggleDesc('more');\">" + Roblox.Resources.more + "</a>"), $("#GroupDescP").html("<pre>" + n + "</pre>"))), $("#GroupsPeople_Places").click(togglePeopleTab), $("#GroupsPeople_Items").click(togglePeopleTab), $("#GroupsPeople_Members").click(togglePeopleTab), $("#GroupsPeoplePane_Allies").children(".grouprelationshipscontainer").length > 0 ? $("#GroupsPeople_Allies").click(togglePeopleTab) : $("#GroupsPeople_Allies").hide(), $("#GroupsPeoplePane_Enemies").children(".grouprelationshipscontainer").length > 0 ? $("#GroupsPeople_Enemies").click(togglePeopleTab) : $("#GroupsPeople_Enemies").hide(), currentPeopleTab = $("#GroupsPeople_Places").length > 0 ? "Places" : "Members", addEllipses(), updateRolesetCount(), $("#GroupThumbnails").find(".GroupListName").each(function() {
        $(this).text(htmlDecode(fitStringToWidthSafe($(this).text(), $(this).width())))
    })
});
var toggleDesc = function(n) {
        n == "more" ? $("#GroupDescP").html("<pre>" + $("#GroupDesc_Full").val() + "   <a onclick=\"toggleDesc('less');\">" + Roblox.Resources.less + "</a></pre>") : n == "less" && $("#GroupDescP").html("<pre>" + $("#GroupDesc_Full").val().substring(0, 147) + "... <a onclick=\"toggleDesc('more');\">" + Roblox.Resources.more + "</a></pre>")
    },
    togglePeopleTab = function(n) {
        var i = $(n.target),
            t;
        i.parentsUntil("#GroupsPeopleContainer", ".StandardTabGrayActive").length > 0 || (t = i.parentsUntil("#GroupsPeopleContainer", ".StandardTabGray").attr("id").replace("GroupsPeople_", ""), $("#GroupsPeople_" + currentPeopleTab).removeClass("StandardTabGrayActive").addClass("StandardTabGray"), $("#GroupsPeoplePane_" + currentPeopleTab).hide(), $("#GroupsPeople_" + t).removeClass("StandardTabGray").addClass("StandardTabGrayActive"), $("#GroupsPeoplePane_" + t).show(), currentPeopleTab = t, $.browser.msie && $(".MembersDropDownList").width() > 485 && $(".MembersDropDownList").css("width", "485px"))
    },
    loading = function(n) {
        n == "members" ? ($('<div class="loading"></div>').insertBefore($($(".GroupMember")[0])), $(".MembersUpdatePanel").find(".GroupMember").remove()) : n == "wall" && $('<div class="loading"><div class="content"></div><div class="background"></div></div>').insertBefore($(".GroupWallPane .FooterPager")), window.setTimeout(function() {
            $(".loading").length > 0 && $(".loading").css("display", "block")
        }, 500)
    },
    handlePagerClick = function(n, t) {
        var i = n.target;
        i == undefined && (i = n.srcElement), i.tagName == "A" && $(i).hasClass("pagerbtns") && loading(t)
    };