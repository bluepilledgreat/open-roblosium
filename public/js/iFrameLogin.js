/*
 * ROBLOSIUM 2013
 * Deobfuscation by Matt Brown/Nostal-ia#7440. If you get any errors with this file, contact me via Discord.
 */
if (typeof Roblox === "undefined") {
	Roblox = {};
}

Roblox.iFrameLogin = new function() {
    var ChallengeOrResponseMissingCode = "1",
        UnableToVerifyCaptchaCode = "2",
        ErrorOccurredCode = "3",
        RequireTwoFactorAuthCode = "4",
        FeatureDisabledCode = "5",
        CaptchaChangedCode = "6",
        IncorrectCredentialCode = "7",
        CaptchaValidationError = "8";
    function init() {
        var requireRedirect = $(document.body).data("redirecttohttp"),
            captchaOn = $(document.body).data("captchaon"),
            holdOnAnotherEnter = false,
            inValidUserName = true,
            resizeParent = function(size) {
                var parentUrl = $(document.body).data("parent-url");
                $.postMessage("resize," + size, parentUrl, parent)
            };
        if (captchaOn) {
            resizeParent("265px")
        } else {
            resizeParent("128px");
        }
        var showLoggingIn = function(displayLoggingIn) {
                if (displayLoggingIn) {
                    $("#LoginButton").hide()
                    $("#LoggingInStatus").show()
                } else {
                    $("#LoginButton").show()
                    $("#LoggingInStatus").hide()
                }
            },
            validateInputs = function() {
                var invalid = false,
                    inputs = [$("#Password"), $("#UserName")];
                if (captchaOn) {
                    inputs.push($("#recaptcha_response_field"))
                }
                jQuery.each(inputs, function() {
                    var input = $(this);
                    if (input.val() == "") {
                        displayInputError(input, true)
                        invalid = true
                    } else {
                        displayInputError(input, false)
                    }
                })
                return invalid
            },
            displayInputError = function(div, mode) {
                holdOnAnotherEnter = false
                showLoggingIn(false)
                if (mode) {
                    div.css({
                        "background-color": "#FDD"
                    })
                } else {
                    div.css({
                        "background-color": "white"
                    })
                }
            },
            submitLogin = function() {
                if (validateInputs()) return false;
                if (inValidUserName) {
                    displayInputError($("#UserName"), true)
                    return false
                }
                holdOnAnotherEnter = true
                showLoggingIn(true)
                var password = $("#Password").val(),
                    userName = $("#UserName").val(),
                    ch = "",
                    resp = "";
                if (captchaOn) {
                    ch = $("#recaptcha_challenge_field").val()
                    resp = $("#recaptcha_response_field").val()
                    if (ch == "" || resp == "") {
                        displayInputError($("#recaptcha_response_field"), true)
                        return false
                    }
                }
                if (captchaOn) {
                    $("#Captcha_upBadCaptcha").text("")
                }
                var onSuccess = onError = function(result) {
                    if (result.IsValid) {
                        if (requireRedirect) window.location = "/LoginRedirect.aspx";
                        else {
                            var topUrl = window.parent.location.href;
                            if (topUrl.indexOf("#") != -1) {
                                topUrl = window.parent.location.href.split("#")[0]
                            }
                            if (topUrl.indexOf("?") == -1) {
                                topUrl += "?nl=true"
                            } else {
                                topUrl += "&nl=true"
                            }
                            window.parent.location = topUrl
                        }
                    } else {
                        if (result.ErrorCode.indexOf(CaptchaChangedCode) != -1) {
                            if (userName != "" && window.location.href.indexOf("username")) {
                                window.location.href = window.location.href + "&username=" + userName
                            } else {
                                window.location.reload()
                            }
                            return false
                        }
                        if (result.ErrorCode.indexOf(RequireTwoFactorAuthCode) != -1) {
                            window.parent.location = "/login/twofactorauth?username=" + encodeURIComponent(userName)
                        }
                        if (result.ErrorCode.indexOf(IncorrectCredentialCode) != -1) {
                            displayInputError($("#Password"), true)
                            $("#NotAMemberLink").hide()
                            $("#ForgotPasswordLink").show()
                        }
                        else if (result.ErrorCode.indexOf(ErrorOccurredCode) != -1) {
                            resizeParent("145px")
                            $("#ErrorMessage").text(result.Message)
                        }
                        else if (result.ErrorCode.indexOf(FeatureDisabledCode) != -1) {
                            $("#ErrorMessage").text(result.Message)
                        }
                        else {
                            resizeParent("280px")
                            displayInputError($("#Password"), false)
                            $("#Captcha_upBadCaptcha").show()
                            $("#Captcha_upBadCaptcha").css("color", "red")
                            if (result.Message == "incorrect-captcha-sol") {
                                $("#Captcha_upBadCaptcha").text(Roblox.iFrameLogin.Resources.invalidCaptchaEntry)
                            } else {
                                $("#Captcha_upBadCaptcha").text(result.Message)
                            }
                        }
                        if (captchaOn) {
                            Recaptcha.reload("t")
                        }
                        $("#Password").val("")
                        $("#Password").focus()
                        holdOnAnotherEnter = false
                        showLoggingIn(false)
                        return false
                    }
                }
				var onSuccessPOST = onErrorPOST = function(result) {
                    if (result.IsValid) {
                        if (requireRedirect) window.location = "/LoginRedirect.aspx";
                        else {
                            var topUrl = window.parent.location.href;
                            if (topUrl.indexOf("#") != -1) {
                                topUrl = window.parent.location.href.split("#")[0]
                            }
                            if (topUrl.indexOf("?") == -1) {
                                topUrl += "?nl=true"
                            } else {
                                topUrl += "&nl=true"
                            }
                            window.parent.location = topUrl
                        }
                    } else {
                        if (result.ErrorCode == CaptchaChangedCode) {
                            if (userName != "" && window.location.href.indexOf("username")) {
                                window.location.href = window.location.href + "&username=" + userName
                            } else {
                                window.location.reload()
                            }
                            return false
                        }
                        if (result.ErrorCode == RequireTwoFactorAuthCode) {
                            window.parent.location = "/login/twofactorauth?username=" + encodeURIComponent(userName)
                        }
                        if (result.ErrorCode == IncorrectCredentialCode) {
                            displayInputError($("#Password"), true)
                            $("#NotAMemberLink").hide()
                            $("#ForgotPasswordLink").show()
                        }
                        else if (result.ErrorCode == ErrorOccurredCode) {
                            resizeParent("145px")
                            $("#ErrorMessage").text(result.Message)
                        }
                        else if (result.ErrorCode == FeatureDisabledCode) {
                            $("#ErrorMessage").text(result.Message)
                        }
                        else {
                            resizeParent("280px")
                            displayInputError($("#Password"), false)
                            $("#Captcha_upBadCaptcha").show()
                            $("#Captcha_upBadCaptcha").css("color", "red")
                            if (result.Message == "incorrect-captcha-sol") {
                                $("#Captcha_upBadCaptcha").text(Roblox.iFrameLogin.Resources.invalidCaptchaEntry)
                            } else {
                                $("#Captcha_upBadCaptcha").text(result.Message)
                            }
                        }
                        if (captchaOn) {
                            Recaptcha.reload("t")
                        }
                        $("#Password").val("")
                        $("#Password").focus()
                        holdOnAnotherEnter = false
                        showLoggingIn(false)
                        return false
                    }
                }
                //Roblox.Website.Services.Secure.LoginService.ValidateLogin(userName, password, captchaOn, ch, resp, onSuccess, onError)
				// SOAP support has yet to be added. use a POST request using ajax for now
				$.post("/Login/iFrameLoginHandler.ashx", {
					userName: userName,
					password: password,
					isCaptchaOn: captchaOn,
					challenge: ch,
					captchaResponse: resp
				}, function(data, ts) {
					onSuccessPOST(data)
				}, "json")
            },
            verifyUserName = function() {
                var userName = $("#UserName").val()
                userName = userName.replace(/ /g, "")
                $("#UserName").val(userName)
                var onSuccess = onError = function(result) {
                    displayInputError($("#UserName"), !result.success)
                    inValidUserName = !result.success
                    if (!result.success) {
                        $("#NotAMemberLink").show()
                        $("#ForgotPasswordLink").hide()
                    }
                }
                if (userName != "") {
                    $.ajax({
                        type: "GET",
                        url: "/UserCheck/doesusernameexist?username=" + userName,
                        success: onSuccess,
                        error: onError
                    })
                }
            };
        $("#LoginButton").click(function() {
            submitLogin()
        })
        $("#UserName").blur(function() {
            verifyUserName()
        })
        $(document).keydown(function(event) {
            if (event.which == 13 && !holdOnAnotherEnter) {
                submitLogin()
                return false
            }
        }), $(function() {
            var n = 1;
            $("input,select").each(function() {
                if (this.type != "hidden") {
                    var t = $(this);
                    t.attr("tabindex", n), n++
                }
            })
        }), $(function() {
            if ($("#UserName").val() != "" || $("#UserName").val() != undefined);
            inValidUserName = false
        }), $(function() {
            $("#CaptchaContainer").css({
                "margin-left": "0",
                "margin-top": "8px",
                width: "none"
            })
        })
    }
    return {
        init: init
    }
};