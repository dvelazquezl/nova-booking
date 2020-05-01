$(function () {
    $(".number").on("keypress", function (event) {
        let input = $(event.target).val() + (event.charCode - 48);
        return (input >= 1 && input <= 100)
    });
});