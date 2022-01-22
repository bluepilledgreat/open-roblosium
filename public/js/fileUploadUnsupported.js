$(function() {
    $("input[type='file']:disabled'").after("<div style='color:red;font-size:11px'>" + Roblox.FileUploadUnsupported.Resources.notSupported + "</div>")
});