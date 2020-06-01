$(document).ready(function () {
    $("#date_from").datepicker({
        weekStart: 1,
        autoclose: true,
        orientation: "bottom auto",
        format: "dd MM yyyy",
        language: 'es',
        todayHighlight: true});
    $("#date_to").datepicker({
        weekStart: 1,
        autoclose: true,
        orientation: "bottom auto",
        format: "dd MM yyyy",
        language: 'es',
        todayHighlight: true});

});
