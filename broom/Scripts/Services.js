$(function () {
    function warningPrompt(promptToShow) {
        var text = promptToShow + "\n\nType YES to confirm.";
        var result = prompt(text);
        return result == "YES";
    }

    $("span[data-make-button]").button();
    
    ////////////// clients page starts //////////////
    var clientDialog = $("#clientDialog").dialog({
        title: "Create New Api Client",
        modal: true,
        resizable: false,
        width: 500,
        autoOpen: false,
        buttons: {
            "Generate Guid": function() {
                // get a guid from the server
                $.get("/ServicesConfig/GenerateGuid", function(guid) {
                    $("#clientKey").val(guid);  
                });                
            },

            "Save": function () {
                var params = {
                    key: $("#clientKey").val(),
                    note: $("#clientNote").val(),
                };

                $.post("/ServicesConfig/AddClient", params, function () {
                    clientDialog.dialog("close");
                    window.location.reload();
                });
            },
            
            "Cancel": function () {
                clientDialog.dialog("close");
            }
        }
    });

    $("#create-new-client-button").click(function () {
        clientDialog.dialog("open");
    });
    
    /*
    $("a[data-delete-client]").click(function () {
        var tr = $(this).closest("tr");
        var note = tr.data("note");
        if (warningPrompt("Are you sure you want to delete client '" + note + "'?")) {
            var key = tr.data("key");
            
            // do deletion
            $.post("/ServicesConfig/DeleteClient", { key: key }, function() {
                window.location.reload();
            });
        }
        return false;
    });
    */
    //////////////// clients page ends //////////////////////
    

    ////////////////// services page starts //////////////////////
    var serviceDialog = $("#serviceDialog").dialog({
        title: "Create New Api Service",
        modal: true,
        resizable: false,
        width: 500,
        autoOpen: false,
        buttons: {
            "Save": function () {
                var params = {
                    name: $("#serviceName").val(),
                };

                $.post("/ServicesConfig/AddService", params, function () {
                    serviceDialog.dialog("close");
                    window.location.reload();
                });
            },
            
            "Cancel": function () {
                serviceDialog.dialog("close");
            }
        }
    });

    $("#create-new-service-button").click(function () {
        serviceDialog.dialog("open");
    });

    /*
    $("a[data-delete-service]").click(function () {
        var tr = $(this).closest("tr");
        var serviceName = tr.data("name");
        if (warningPrompt("Are you sure you want to delete service '" + serviceName + "'?")) {
            
            // do deletion
            $.post("/ServicesConfig/DeleteService", { name: serviceName }, function() {
                window.location.reload();
            });
        }
        return false;
    });
    */
    //////////////// services page ends ////////////////////////////

    ///////////// operations page starts ///////////////////
    var operationDialog = $("#operationDialog").dialog({
        title: "Create New Operation",
        modal: true,
        resizable: false,
        width: 500,
        autoOpen: false,
        buttons: {
            "Save": function () {
                var params = {
                    operationName: $("#operationName").val(),
                    serviceName: $("#current-service-name").val()
                };

                $.post("/ServicesConfig/AddOperation", params, function () {
                    operationDialog.dialog("close");
                    window.location.reload();
                });
            },
            
            "Cancel": function () {
                operationDialog.dialog("close");
            }
        }
    });

    $("#create-new-operation-button").click(function () {
        operationDialog.dialog("open");
    });

    
    $("a[data-delete-operation]").click(function () {
        var tr = $(this).closest("tr");
        var operationName = tr.data("name");
        if (warningPrompt("Are you sure you want to delete operation '" + operationName + "'?")) {
            // do deletion
            var operationId = $(this).data("operationid");
            var params = {
                operationId: operationId
            };

            $.post("/ServicesConfig/DeleteOperation", params, function() {
                window.location.reload();
            });
        }
        return false;
    });
    
    ///////////// operations page ends ///////////////////

    /////////// service authorizations page starts ////////////////
    var serviceAuthorizationDialog = $("#serviceAuthorizationDialog").dialog({
        title: "Create New Service Authorization",
        modal: true,
        resizable: false,
        width: 530,
        autoOpen: false,
        buttons: {
            "Save": function () {
                var params = {
                    key: $("#clientKey").val(),
                    serviceName: $("#serviceName").val(),
                    authorizationType: $("#authorizationType").val()
                };

                $.post("/ServicesConfig/AddServiceAuthorization", params, function () {
                    serviceAuthorizationDialog.dialog("close");
                    window.location.reload();
                });
            },
            
            "Cancel": function () {
                serviceAuthorizationDialog.dialog("close");
            }
        }
    });
    
    $("#create-new-service-authorization-button").click(function () {
        serviceAuthorizationDialog.dialog("open");
    });
    
    $("a[data-change-service-authorization]").click(function() {
        var tr = $(this).closest("tr");
        var serviceName = tr.data("service-name");
        var authorizationType = $(this).text();
        if (warningPrompt("Are you sure you want to change authorization of '" + serviceName +"' to '" + authorizationType + "'? Please note that changing authorization to 'None' will delete it.")) {
            var params = {
                key: $("#clientKey").val(),
                serviceName: serviceName,
                authorizationType: authorizationType
            };

            $.post("/ServicesConfig/AddServiceAuthorization", params, function () {
                window.location.reload();
            });
        }
        return false;        
    });
    /////////// service authorizations page ends ////////////////
    
    /////////// operation authorizations page starts ////////////////
    var serviceNameDropDown = $("#operationAuthorizationDialog #serviceName");
    var operationNameDropDown = $("#operationAuthorizationDialog #operationName");

    var operationAuthorizationDialog = $("#operationAuthorizationDialog").dialog({
        title: "Create New Operation Authorization",
        modal: true,
        resizable: false,
        width: 530,
        autoOpen: false,
        
        buttons: {
            "Save": function () {
                var params = {
                    key: $("#clientKey").val(),
                    serviceName: serviceNameDropDown.val(),
                    operationName: operationNameDropDown.val(),
                    authorizationType: $("#authorizationType").val()
                };

                $.post("/ServicesConfig/AddOperationAuthorization", params, function () {
                    operationAuthorizationDialog.dialog("close");
                    window.location.reload();
                });
            },
            
            "Cancel": function () {
                operationAuthorizationDialog.dialog("close");
            }
        }
    });

    serviceNameDropDown.change(function() {
        $.get("/ServicesConfig/GetOperations", { serviceName: serviceNameDropDown.val() }, function(opsArray) {
            operationNameDropDown.empty(); // clear
            for (var i = 0; i < opsArray.length; i++) {
                var opName = opsArray[i];
                operationNameDropDown.append("<option>" + opName + "</option>");
            }
        });
    });
    
    var createNewOpAuthButton = $("#create-new-operation-authorization-button");
    createNewOpAuthButton.one("click", function() {
        serviceNameDropDown.trigger("change"); // pre-populate for the first time only
    });
    createNewOpAuthButton.click(function () {
        operationAuthorizationDialog.dialog("open");
    });


    $("a[data-change-operation-authorization]").click(function() {
        var tr = $(this).closest("tr");
        var serviceName = tr.data("service-name");
        var operationName = tr.data("operation-name");
        var authorizationType = $(this).text();
        if (warningPrompt("Are you sure you want to change authorization of operation '" + operationName +"' of service '" + serviceName +"' to '" + authorizationType + "'? Please note that changing authorization to 'None' will delete it.")) {
            var params = {
                key: $("#clientKey").val(),
                serviceName: serviceName,
                operationName: operationName,
                authorizationType: authorizationType
            };

            $.post("/ServicesConfig/AddOperationAuthorization", params, function () {
                window.location.reload();
            });
        }
        return false;        
    });
    /////////// operation authorizations page ends ////////////////
});


