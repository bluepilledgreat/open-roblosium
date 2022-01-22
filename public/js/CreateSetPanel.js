function chkSelect(n, t) {
    for (var f = [], i, e, u, r = 0; r < n.options.length; r++) n.options[r].selected && f.push(n.options[r].value);
    if (f.length > t)
        for (alert(Roblox.CreateSetPanel.Resources.youMaySelect + t + Roblox.CreateSetPanel.Resources.elementsInList), i = 0; i < n.length; i++) {
            for (e = !1, u = 0; u < prevSelected.length; u++)
                if (prevSelected[u] == n[i].value) {
                    n.options[i].selected = !0, e = !0;
                    break
                } e || (n.options[i].selected = !1)
        } else prevSelected = f
}

function updateSuperSafeNameDisplay() {
    for (var t = "", i = !0, f = document.getElementById(superSafeAdjectiveListClientId), r, u, n = 0; n < f.options.length; n++) f.options[n].selected && (i || (t += " "), i = !1, t += f.options[n].value);
    for (r = document.getElementById(superSafeCategoryListClientId), n = 0; n < r.options.length; n++) r.options[n].selected && (i || (t += " "), i = !1, t += r.options[n].value);
    for (u = document.getElementById(superSafeNameListClientId), n = 0; n < u.options.length; n++) u.options[n].selected && (i || (t += " ", i = !1), i = !1, t += u.options[n].value);
    $("#NameDisplay").html(userName + "'s " + t)
}

function updateRegularNameDisplay(n) {
    $("#NameDisplay").html(userName + "'s " + n.value.escapeHTML())
}

function enableButton() {
    if ($("#" + nameClientID).val() || $("#" + superSafeAdjectiveListClientId + " option:selected").length != 0 || $("#" + superSafeCategoryListClientId + " option:selected").length != 0 || $("#" + superSafeNameListClientId + " option:selected").length != 0) {
        if (fileUploadIsReady) return !0
    } else return !1;
    return !1
}

function ismaxlength(n) {
    var t = n.getAttribute ? parseInt(n.getAttribute("maxlength")) : "";
    n.getAttribute && n.value.length > t && (n.value = n.value.substring(0, t))
}