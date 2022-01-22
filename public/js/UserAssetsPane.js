function BindMouseClick() {
    $(".SetAddButton").click(function() {
        var i = $(this).parent().parent().attr("id").replace("setList_", ""),
            r = $(this).children(".setId")[0].value,
            n = "set_" + r + "_" + i,
            t = "waiting" + n;
        $(n).append("<img src='/images/spinners/spinner16x16.gif' id='" + t + "'"), $.ajax({
            type: "POST",
            async: !0,
            cache: !1,
            timeout: 5e4,
            url: "/Sets/SetHandler.ashx?rqtype=addtoset&assetId=" + i + "&setId=" + r,
            success: function(i) {
                i !== null && ($("#" + n).removeClass("SetAddButton"), $("#" + n).addClass("SetAddButtonAlreadyContainsItem"), $("#" + n).unbind("click"), $("#" + t).remove())
            },
            failure: function(n) {
                n !== null
            }
        })
    })
}

function BindMouseOver() {
    $(".SetList").hover(function() {
        var i = $(this).ID,
            t, n;
        $(".SetListDropDown").each(function() {
            $(this).parent().attr("id") != i && $(this).hide()
        }), t = new Date, n = Date.parse(t.toUTCString()) + 500, $(this).attr("mouseovertimeout", n), $(this).find("div").show()
    }, function() {
        var n = this;
        window.setTimeout(function() {
            var i = $(n).attr("mouseovertimeout"),
                t = Date.parse((new Date).toUTCString());
            i > t || $(n).find("div").fadeOut()
        }, 500)
    })
}

function BindNavPills() {
    $("ul.nav-pills li").click(function() {
        $(".nav-pills li.active").removeClass("active"), $(this).addClass("active")
    })
}
$(document).ready(function() {
    BindMouseClick(), BindNavPills()
}), Sys.Application.add_load(BindMouseClick), Sys.Application.add_load(BindMouseOver), Sys.Application.add_load(BindNavPills);