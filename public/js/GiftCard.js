function handleOnFocus(n) {
    $(".GCProductSelected").toggleClass("GCProductSelected"), $(n).toggleClass("GCProductSelected"), $("#SelectedProduct").val($(n).attr("pid"))
}
$(function() {
    $(".GCProduct").click(function() {
        $(".GCProductSelected").toggleClass("GCProductSelected"), $(this).toggleClass("GCProductSelected"), $("#SelectedProduct").val($(this).attr("pid"))
    }), $(".GCTheme").click(function() {
        $(".GCThemeSelected").toggleClass("GCThemeSelected"), $(this).toggleClass("GCThemeSelected"), $("#SelectedTheme").val($(this).attr("tid"))
    }), $(".GCTheme").hover(function() {
        $(".ThemePreview", this).toggle()
    }), $(".PreviewGiftCard").click(function() {
        var i = "height=830,width=640,left=10,top=10,resizable=1,scrollbars=1,toolbar=1,menubar=0,location=0,directories=no,status=yes",
            t = "GiftCard.ashx?action=preview&id=" + $(this).attr("lookupid"),
            n = window.open(t, "pdfWindow", i);
        n.title = "Preview Certificate.pdf"
    }), $("#MessageTextArea").bind("keydown keyup keypress paste", function(n) {
        if (n.which == 13) return !1;
        var t = $(this).val().replace("\n", "").substring(0, 250),
            i = t.length;
        $(this).val(t), $("#remainingCharacters").html(250 - i)
    }), $('[pid="' + $("#SelectedProduct").val() + '"]').toggleClass("GCProductSelected"), $('[tid="' + $("#SelectedTheme").val() + '"]').toggleClass("GCThemeSelected"), $("#MessageTextArea").length > 0 && $("#remainingCharacters").html(250 - $("#MessageTextArea").val().length)
});