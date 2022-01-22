function addMonths() {
	$("<option>").attr("value", 1).text(Roblox.Login.Resources.january).appendTo('select[name="Month"]'),
	$("<option>").attr("value", 2).text(Roblox.Login.Resources.february).appendTo('select[name="Month"]'),
	$("<option>").attr("value", 3).text(Roblox.Login.Resources.march).appendTo('select[name="Month"]'),
	$("<option>").attr("value", 4).text(Roblox.Login.Resources.april).appendTo('select[name="Month"]'),
	$("<option>").attr("value", 5).text(Roblox.Login.Resources.may).appendTo('select[name="Month"]'),
	$("<option>").attr("value", 6).text(Roblox.Login.Resources.june).appendTo('select[name="Month"]'),
	$("<option>").attr("value", 7).text(Roblox.Login.Resources.july).appendTo('select[name="Month"]'),
	$("<option>").attr("value", 8).text(Roblox.Login.Resources.august).appendTo('select[name="Month"]'),
	$("<option>").attr("value", 9).text(Roblox.Login.Resources.september).appendTo('select[name="Month"]'),
	$("<option>").attr("value", 10).text(Roblox.Login.Resources.october).appendTo('select[name="Month"]'),
	$("<option>").attr("value", 11).text(Roblox.Login.Resources.november).appendTo('select[name="Month"]'),
	$("<option>").attr("value", 12).text(Roblox.Login.Resources.december).appendTo('select[name="Month"]')
}

function addDays() {
	for(var n=1;
	n<=31;
	n++)$("<option>").attr("value", n).text(n).appendTo('select[name="Day"]')
}

function addYears() {
	for(var n=(new Date).getFullYear();
	n>=(new Date).getFullYear()-100;
	n--)$("<option>").attr("value", n).text(n).appendTo('select[name="Year"]')
}

$(function() {
	addDays(), addMonths(), addYears(), $("[roblox-js-onclick]").click(function() {
		return $("#loginForm").submit(), !1
	}
	), $("[roblox-js-onsignup]").click(function() {
		var i=$('select[name="Month"] option:selected').val(), r=$('select[name="Day"] option:selected').val(), u=$('select[name="Year"] option:selected').val(), n=$("#ReturnUrl").val(), t=String.format("/account/signupredir?month={0}&day={1}&year={2}", i, r, u);
		return n!=""&&(t+="&returnUrl="+n), window.location=t, !1
	}
	), $("[roblox-js-oncancel]").click(function() {
		return window.close(), !1
	}
	), $("#MonthSelect").change(function() {
		var i=$('select[name="Month"] option:selected').val(), r=$('select[name="Day"] option:selected').val(), n=$('select[name="Year"] option:selected').val(), t=String.format("/IDE/Login?isSignup=true&month={0}&day={1}&year={2}", i, r, n);
		$("[roblox-js-onsignup]").attr("href", t)
	}
	), $("#DaySelect").change(function() {
		var i=$('select[name="Month"] option:selected').val(), r=$('select[name="Day"] option:selected').val(), n=$('select[name="Year"] option:selected').val(), t=String.format("/IDE/Login?isSignup=true&month={0}&day={1}&year={2}", i, r, n);
		$("[roblox-js-onsignup]").attr("href", t)
	}
	), $("#YearSelect").change(function() {
		var i=$('select[name="Month"] option:selected').val(), r=$('select[name="Day"] option:selected').val(), n=$('select[name="Year"] option:selected').val(), t=String.format("/IDE/Login?isSignup=true&month={0}&day={1}&year={2}", i, r, n);
		$("[roblox-js-onsignup]").attr("href", t)
	}
	), $("#errorBanner").text().trim().length==0&&$("#errorBanner").hide(), $("#Username").focus(), $(document).keydown(function(n) {
		if(n.which==13)return $("#loginForm").submit(), !1
	}
	)
}

);