var Roblox = Roblox || {};

$(function () {
    Roblox.ConfigSettings = function (settingsArray) {
        settingsArray = settingsArray || {};
        var isTakeoverPage = false;
        if (settingsArray.isTakeoverPage != isTakeoverPage)
            isTakeoverPage = settingsArray.isTakeoverPage;

        function showAlertDialog(title, message) {
            var dlg = window.rbxAlertDialog;
            if (!dlg) {
                dlg = window.rbxAlertDialog = $("#alertDialog").dialog({
                    modal: true,
                    resizable: false,
                    width: 400,
                    autoOpen: false,
                    buttons: {
                        "OK": function () {
                            dlg.dialog("close");
                        }
                    }
                });
            }

            $("#alertDialogText").text(message);
            dlg.dialog("option", "title", title);
            dlg.dialog("open");
        }

        function showMessage(message) {
            window.scrollTo(0, 0);

            $("#messageDivText").text(message);
            $("#messageDiv").fadeIn();
        }

        function hideMessage() {
            $("#messageDiv").fadeOut("slow");
        }

        function showDeleteDialog(postUrl, id, message, updateHandler) {
            var dlg = window.rbxDeleteDialog;
            if (!dlg) {
                dlg = window.rbxDeleteDialog = $("#deleteDialog").dialog({
                    modal: true,
                    resizable: false,
                    width: 400,
                    autoOpen: false,
                    buttons: {
                        "Delete": function () {
                            dlg.onDelete();
                            dlg.dialog("close");
                        },
                        "Cancel": function () {
                            dlg.dialog("close");
                        }
                    }
                });
            };

            $("#deleteDialogMessage").text(message);
            dlg.currentId = id;
            dlg.onDelete = function () {
                $.post(postUrl, { id: id }, function (responseMessage) {
                    if (responseMessage) {
                        showAlertDialog("Success", responseMessage);
                        updateHandler();
                    }
                    else {
                        showAlertDialog("Error", "Delete failed!");
                    }
                });
            };
            dlg.dialog("open");
            return false;
        }

        var updateSettingResults = function (handler) {
            var url = "/Config/GetSettingsHtmlAjax?" + $.param({ GroupName: $("#GroupName").val(), NamePattern: $("#NamePattern").val() });
            $("#settingsResultsDiv").load(url, function () {
                if (handler) {
                    handler();
                }
            });
        };
        
        //if we have an override, use it instead
        if (settingsArray.updateSettingResults != undefined) {
            updateSettingResults = settingsArray.updateSettingResults;
        }


        var editSettingDialog = $("#settingsDialog").dialog({
            modal: true,
            resizable: false,
            width: 520,
            autoOpen: false,
            buttons: {
                "Save": function () {
                    var newSetting;

                    var params = {
                        id: editSettingDialog.currentId,
                        value: $("#dlgValue").val(),
                        comment: $("#dlgComment").val(),
                        env: $("#dlgIsEnvSpecific").prop("checked"),

                        // following settings will NOT get updated on save
                        group: $("#dlgGroup").val(),
                        type: $("#dlgType").val(),
                        name: $("#dlgName").val()
                    };

                    if (params.id == -1) {
                        // for new settings, append extra parameters
                        newSetting = true;
                    }

                    var url = (isTakeoverPage ? "/MarketingConfig/SetSettingAjax" : "/Config/SetSettingAjax");
                    $.post(url, params, function (response) {
                        if (response.SettingSaved) {
                            if (newSetting && $.inArray(params.group, window.groupNames) == -1) {
                                window.groupNames.push(params.group);
                                $("#GroupName").append('<option>' + params.group + '</option>');
                                $("#GroupName").val(params.group);
                            }

                            updateSettingResults(function () {
                                showMessage("Setting '" + params.group + "' - '" + params.name + "' was saved.");
                            });
                        }
                        else {
                            showAlertDialog("Error", "Setting was NOT saved! " + response.Message);
                        }
                        editSettingDialog.dialog("close");
                    });
                },
                "Cancel": function () {
                    editSettingDialog.dialog("close");
                }
            }
        });

        function init() {
            $("#messageDiv").live("click", function () {
                hideMessage();
            });

            $("#dlgGroup").autocomplete({ source: window.groupNames });
            $("#dlgType").autocomplete({ source: [
                "System.Boolean",
                "System.Byte",
                "System.Double",
                "System.Float",
                "System.Int32",
                "System.Int64",
                "System.TimeSpan",
                "System.String",
                "System.Guid"
            ]
            });

            $("#settingsResultsDiv a:contains('Edit')").live("click", function () {
                if (!Roblox.Admi.SettingsSemaphore.doesCurrentUserHoldSettingsSemaphore()) {
                    return false;
                }
                var id = $(this).closest("tr").data("sid");
                var url = (isTakeoverPage ? "/MarketingConfig/GetSettingAjax?id=" : "/Config/GetSettingAjax?id=");
                $.getJSON(url + id, function (s) {
                    $("#dlgGroup").attr("disabled", true).val(s.GroupName);
                    $("#dlgType").attr("disabled", true).val(s.Type);
                    $("#dlgName").attr("disabled", true).val(s.Name);
                    $("#dlgModified").val(s.LastModified);

                    $("#dlgValue").val(s.Value);
                    $("#dlgComment").val(s.Comment);
                    $("#dlgIsEnvSpecific").prop("checked", s.IsEnvironmentSpecific);

                    editSettingDialog.currentId = id;
                    editSettingDialog.dialog("option", "title", "Edit Setting");
                    editSettingDialog.dialog("open");
                });
                return false;
            });

            $("#settingsResultsDiv a:contains('Delete')").live("click", function () {
                if (!Roblox.Admi.SettingsSemaphore.doesCurrentUserHoldSettingsSemaphore()) {
                    return false;
                }
                var id = $(this).closest("tr").data("sid");
                return showDeleteDialog("/Config/DeleteSettingAjax", id, "Are you sure you want to delete this setting?", updateSettingResults);
            });

            $("#configTabs").tabs();

            $("span[data-make-button]").button();

            $("#CreateNewSettingButton").click(function () {
                if (!Roblox.Admi.SettingsSemaphore.doesCurrentUserHoldSettingsSemaphore()) {
                    return false;
                }
                // default to currently selected group
                var defaultName = $("#GroupName").val();
                if (defaultName == "*") {
                    defaultName = ""; // do not show * when all grups is selected in the drop down
                }
                $("#dlgGroup").attr("disabled", false).val(defaultName);
                $("#dlgType").attr("disabled", false).val("");
                $("#dlgName").attr("disabled", false).val("");
                $("#dlgModified").val("Set Automatically");

                $("#dlgValue").val("");
                $("#dlgComment").val("");
                $("#dlgIsEnvSpecific").prop("checked", false);

                editSettingDialog.currentId = -1;
                editSettingDialog.dialog("option", "title", "Create Setting");
                editSettingDialog.dialog("open");

                return false;
            });

            $("#GroupName").change(function () {
                if (this.value) {
                    updateSettingResults();
                }
            });

            $("#NamePattern").keyup(function () {
                updateSettingResults();
            });

            $("#ClearButton").click(function () {
                $("#NamePattern").val("");
                updateSettingResults();
            });

            updateSettingResults();
        }





        /////////////////////////////////////
        // edit connection strings

        var editConnectionDialog = $("#connectionStringDialog").dialog({
            modal: true,
            resizable: false,
            width: 520,
            autoOpen: false,
            buttons: {
                "Save": function () {
                    var params = {
                        id: editConnectionDialog.currentId,
                        value: $("#conDlgValue").val()
                    };

                    if (params.id == -1) {
                        // for new settings, append extra parameters
                        params.group = $("#conDlgGroup").val();
                        params.name = $("#conDlgName").val();
                    }

                    $.post("/Config/SetConnectionStringAjax", params, function (s) {
                        if (s) {
                            updateConnectionsResults();
                            showAlertDialog("Roblox", "Connection was saved");
                        }
                        else {
                            showAlertDialog("Error", "Connection was NOT saved!");
                        }

                        editConnectionDialog.dialog("close");
                    });

                },
                "Cancel": function () {
                    editConnectionDialog.dialog("close");
                }
            }
        });

        $("#connectionStringsResultsDiv a:contains('Edit')").live("click", function () {
            var id = $(this).closest("tr").data("id");
            $.getJSON("/Config/GetConnectionStringAjax?id=" + id, function (s) {
                $("#conDlgGroup").attr("disabled", true).val(s.GroupName);
                $("#conDlgName").attr("disabled", true).val(s.Name);
                $("#conDlgModified").val(s.LastModified);
                $("#conDlgValue").val(s.Value);

                editConnectionDialog.currentId = id;
                editConnectionDialog.dialog("option", "title", "Edit Connection String");
                editConnectionDialog.dialog("open");
            });
            return false;
        });

        $("#connectionStringsResultsDiv a:contains('Delete')").live("click", function () {
            var id = $(this).closest("tr").data("id");
            return showDeleteDialog("/Config/DeleteConnectionStringAjax", id, "Are you sure you want to delete this connection string?", updateConnectionsResults);
        });

        function updateConnectionsResults() {
            $("#connectionStringsResultsDiv").load("/Config/GetConnectionStringsHtmlAjax");
        }

        $("#CreateNewConnectionButton").click(function () {
            $("#conDlgGroup").attr("disabled", false).val("");
            $("#conDlgName").attr("disabled", false).val("");
            $("#conDlgModified").val("Set Automatically");
            $("#conDlgValue").val("");

            editConnectionDialog.currentId = -1;
            editConnectionDialog.dialog("option", "title", "Create Connection String");
            editConnectionDialog.dialog("open");

            return false;
        });


        updateConnectionsResults();

        ///////////// endpoints /////////////////////

        function updateEndpointsResults() {
            $("#endpointsResultsDiv").load("/Config/GetEndpointAddressListHtmlAjax");
        }

        updateEndpointsResults();



        var editEndpointDialog = $("#endpointDialog").dialog({
            modal: true,
            resizable: false,
            width: 520,
            autoOpen: false,
            buttons: {
                "Save": function () {
                    var params = {
                        id: editEndpointDialog.currentId,
                        uri: $("#epUri").val(),
                        name: $("#epName").val()
                    };

                    $.post("/Config/SetEndpointAjax", params, function (s) {
                        if (s) {
                            updateEndpointsResults();
                            showAlertDialog("Roblox", "WCF Endpoint was saved");
                        }
                        else {
                            showAlertDialog("Error", "WCF Endpoint was NOT saved!");
                        }

                        editEndpointDialog.dialog("close");
                    });

                },
                "Cancel": function () {
                    editEndpointDialog.dialog("close");
                }
            }
        });

        $("#CreateNewEndpointAddressButton").click(function () {
            $("#epId").val("Set Automatically");
            $("#epName").val("");
            $("#epUri").val("");

            editEndpointDialog.currentId = -1;
            editEndpointDialog.dialog("option", "title", "Create WCF Endpoint");
            editEndpointDialog.dialog("open");
        });

        $("#endpointsResultsDiv a:contains('Edit')").live("click", function () {
            var id = $(this).closest("tr").data("id");
            $.getJSON("/Config/GetEndpointAjax?id=" + id, function (s) {
                $("#epId").val(s.ID);
                $("#epName").val(s.EndpointConfigurationName);
                $("#epUri").val(s.Uri);
                editEndpointDialog.currentId = id;
                editEndpointDialog.dialog("option", "title", "Edit WCF Endpoint");
                editEndpointDialog.dialog("open");
            });
            return false;
        });

        $("#endpointsResultsDiv a:contains('Delete')").live("click", function () {
            var id = $(this).closest("tr").data("id");
            return showDeleteDialog("/Config/DeleteEndpointAjax", id, "Are you sure you want to delete this WCF endpoint?", updateEndpointsResults);
        });


        return {
            init: init
        };
    };
});


