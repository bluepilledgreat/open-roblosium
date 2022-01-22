$(function () {
    $("span[data-make-button], input[data-make-button]").button();
    
    var appVersionForm = document.getElementById("app-version-form");

    var appVersionDialog = $("#app-version-dialog").dialog({
        modal: true,
        resizable: false,
        width: 520,
        autoOpen: false,
        buttons: {
            "Save": function () {
                appVersionForm.submit();
            },
            "Cancel": function () {
                appVersionDialog.dialog("close");
            }
        }
    });

    $("a[data-edit-app-version]").click(function () {
        var anchor = $(this);
        $("#app-version-id").val(anchor.data("id"));
        $("#app-version-value").val(anchor.data("value"));
        $("#app-version-platform-type-id").val(anchor.data("platform-type-id"));
        $("#app-version-status-type-id").val(anchor.data("status-type-id"));
        $("#app-version-description").val(anchor.data("description"));
        appVersionDialog.dialog("option", "title", "Edit App Version");        
        appVersionDialog.dialog("open");
        return false;
    });

    $("#create-new-app-version-button").click(function () {
        appVersionForm.reset();
        appVersionDialog.dialog("option", "title", "Create App Version");        
        appVersionDialog.dialog("open");
    });


    ///////// security versions ////////
    var securityVersionForm = document.getElementById("security-version-form");

    var securityVersionDialog = $("#security-version-dialog").dialog({
        modal: true,
        resizable: false,
        width: 520,
        autoOpen: false,
        buttons: {
            "Save": function () {
                securityVersionForm.submit();
            },
            "Cancel": function () {
                securityVersionDialog.dialog("close");
            }
        }
    });

    $("a[data-edit-security-version]").click(function () {
        var anchor = $(this);
        $("#security-version-id").val(anchor.data("id"));
        $("#security-version-value").val(anchor.data("value"));
        $("#security-version-is-valid").val(anchor.data("is-valid"));
        $("#security-version-description").val(anchor.data("description"));
        securityVersionDialog.dialog("option", "title", "Edit Security Version");
        securityVersionDialog.dialog("open");
        return false;
    });

    $("#create-new-security-version-button").click(function () {
        securityVersionForm.reset();
        securityVersionDialog.dialog("option", "title", "Create Security Version");
        securityVersionDialog.dialog("open");
    });
});

