typeof Roblox == "undefined" && (Roblox = {}), Roblox.SignupFormValidator = function() {
    function t() {
        return $("#MaleBtn:checked").length == 0 && $("#FemaleBtn:checked").length == 0 ? ($("#genderError").show(), $("#genderGood").hide(), !1) : ($("#genderError").hide(), $("#genderGood").show(), !0)
    }

    function f() {
        if (u(), $("#Password").val().length == 0) {
            $("#passwordError").hide(), $("#passwordGood").hide();
            return
        }
        var n = b($("#Password").val(), $("#UserName").val());
        n != "" ? ($("#passwordErrorMessage").html(n), $("#passwordError").show(), $("#passwordGood").hide()) : ($("#passwordError").hide(), $("#passwordGood").show())
    }

    function u() {
        var i = $("#Password").val(),
            t = $("#PasswordConfirm").val(),
            n;
        if ($("#passwordError").css("display") != "none" || t == "" || i == "") {
            $("#passwordConfirmGood").hide(), $("#passwordConfirmError").hide();
            return
        }
        n = v(i, t), n ? ($("#passwordConfirmGood").show(), $("#passwordConfirmError").hide()) : ($("#passwordConfirmError").show(), $("#PasswordConfirmMessage").html("<p>" + Roblox.SignupFormValidator.Resources.doesntMatch + "</p>"), $("#passwordConfirmGood").hide())
    }

    function e() {
        if ($("#UserName").val().length == 0) {
            $("#usernameGood").hide(), $("#UsernameError").hide();
            return
        }
        var n = a($("#UserName").val());
        n != "" ? ($("#usernameErrorMessage").html(n), $("#usernameErrorMessage").show(), $("#UsernameError").show(), $("#usernameGood").hide()) : ($("#UsernameError").hide(), c())
    }

    function n(n) {
        var r = parseInt($("#lstYears option:selected").val()),
            i = parseInt($("#lstMonths option:selected").val()),
            t = parseInt($("#lstDays option:selected").val());
        return r <= 0 || i <= 0 || t <= 0 || t > new Date(r, i, 0).getDate() ? (n && (r == 0 && i == 0 && t == 0 ? $("#birthdayErrorParagraph").html(Roblox.SignupFormValidator.Resources.requiredField) : $("#birthdayErrorParagraph").html("Invalid birthday"), $("#birthdayError").show(), $("#birthdayGood").hide()), !1) : ($("#birthdayError").hide(), $("#birthdayGood").show(), !0)
    }

    function y() {
        return $("#passwordError").css("display") == "none" && $("#passwordConfirmError").css("display") == "none"
    }

    function v(n, t) {
        return t == "" || n.length > 0 && t != "" && n == t ? !0 : !1
    }

    function a(n) {
        var t = "";
        return n.length > 20 && (t += "<p>" + Roblox.SignupFormValidator.Resources.tooLong + "</p>"), n.length < 3 && (t += "<p>" + Roblox.SignupFormValidator.Resources.tooShort + "</p>"), n.match(/^[a-zA-Z0-9]*$/) || (t += "<p>" + Roblox.SignupFormValidator.Resources.containsInvalidCharacters + "</p>"), t
    }

    function b(n, t) {
        var i = "";
        return n.length > 20 ? i += "<p>" + Roblox.SignupFormValidator.Resources.tooLong + "</p>" : n.length < 6 ? i += "<p>" + Roblox.SignupFormValidator.Resources.tooShort + "</p>" : (p(n) < 4 && (i += "<p>" + Roblox.SignupFormValidator.Resources.needsFourLetters + "</p>"), l(n) < 2 && (i += "<p>" + Roblox.SignupFormValidator.Resources.needsTwoNumbers + "</p>"), w(n) > 0 && (i += "<p>" + Roblox.SignupFormValidator.Resources.noSpaces + "</p>")), o(n) && (i += "<p>" + Roblox.SignupFormValidator.Resources.weakKey + "</p>"), n == t && (i += "<p>" + Roblox.SignupFormValidator.Resources.invalidName + "</p>"), i
    }

    function w(n) {
        var r = /^\s$/,
            i = 0,
            t;
        if (n == null || n == "") return 0;
        for (t = 0; t < n.length; t++) n.charAt(t).match(r) && (i += 1);
        return i
    }

    function p(n) {
        var r = /^[A-Za-z]$/,
            i = 0,
            t;
        if (n == null || n == "") return 0;
        for (t = 0; t < n.length; t++) n.charAt(t).match(r) && (i += 1);
        return i
    }

    function l(n) {
        var r = /^[0-9]$/,
            i = 0,
            t;
        if (n == null || n == "") return 0;
        for (t = 0; t < n.length; t++) n.charAt(t).match(r) && (i += 1);
        return i
    }

    function o(n) {
        return n.indexOf("asdf") > -1 ? !0 : n.indexOf(Roblox.SignupFormValidator.Resources.password) > -1 || n.indexOf("qwer") > -1 || n.indexOf("zxcv") > -1 || n.indexOf("aaaa") > -1 || n.indexOf("zzzz") > -1 ? !0 : !1
    }

    function i() {
        var f = n(!0),
            e = t(),
            i = r(),
            u = $("#UsernameError").css("display") == "none";
        return f && e && i && y() && u ? !0 : !1
    }

    function s() {
        n(!0), t(), e(), f(), r()
    }

    function c() {
        var i = $get("UserName").value,
            t = function(n) {
                n.data == 1 ? ($("#usernameErrorMessage").html("<p>" + Roblox.SignupFormValidator.Resources.alreadyTaken + "</p>"), $("#usernameErrorMessage").show(), $("#UsernameError").show(), $("#usernameGood").hide()) : n.data == 2 ? ($("#usernameErrorMessage").html("<p>" + Roblox.SignupFormValidator.Resources.cantBeUsed + "</p>"), $("#usernameErrorMessage").show(), $("#UsernameError").show(), $("#usernameGood").hide()) : n.data == 0 && ($("#usernameErrorMessage").hide(), $("#UsernameError").hide(), $("#usernameGood").show())
            },
            n = function() {};
        $.ajax({
            type: "GET",
            url: "/UserCheck/checkifinvalidusernameforsignup?username=" + i,
            success: t,
            error: n
        })
    }

    function r() {
        var n = !0;
        return $("#Password").val().length == 0 && ($("#passwordError").show(), $("#passwordErrorMessage").html("<p>" + Roblox.SignupFormValidator.Resources.requiredField + "</p>"), n = !1), $("#PasswordConfirm").val().length == 0 && ($("#passwordConfirmError").show(), $("#PasswordConfirmMessage").html("<p>" + Roblox.SignupFormValidator.Resources.requiredField + "</p>"), n = !1), $("#UserName").val().length == 0 && ($("#UsernameError").show(), $("#usernameErrorMessage").html("<p>" + Roblox.SignupFormValidator.Resources.requiredField + "</p>"), $("#usernameErrorMessage").show(), n = !1), n
    }
    $(function() {
        $("#UserName,#Password,#PasswordConfirm").keypress(function(n) {
            n.which == "13" && i() && document.getElementById("ButtonCreateAccount").click()
        }), $("#UserName").blur(Roblox.SignupFormValidator.checkUsername)
    });
    return {
        checkBirthday: n,
        checkUsername: e,
        checkPassword: f,
        checkGender: t,
        checkPasswordConfirm: u,
        ValidateForm: i,
        ValidateAndShowResponses: s
    }
}();