$(function () {
	var minScale = $("#MarketingBoostPanel").data('mincale');
	var maxScale = $("#MarketingBoostPanel").data('maxscale');
	var currentValue = $("#BoostAmountScale").val();
	$("#slider").slider({
		value: currentValue,
		min: minScale,
		max: maxScale,
		step: 1,
		slide: function (event, ui) {
			$("#BoostAmountScale").val(ui.value);
		}
	});
	$("#BoostAmountScale").val($("#slider").slider("value"));
	$("#ReleaseDate").bind('blur keyup change', (function () {
		var startDate = $(this).val();
		$("#BoostStartDate").val(startDate);
		$("#BoostEndDate").val("");
	}));
});