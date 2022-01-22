jQuery.extend(jQuery.expr[":"], {
    focus: function(n) {
        return n == document.activeElement
    }
});