//= require jquery3
//= require bootstrap

$(function() {
$( "#with_date_gte" ).datepicker(
    {
            todayHighlight: true,
            autoclose: true,
            format: "YYYY/MM/DD",
            clearBtn: true,
            startDate: new Date()
    });

    $( "#with_date_lte" ).datepicker(
    {
            todayHighlight: true,
            autoclose: true,
            format: "YYYY/MM/DD",
            clearBtn: true,
            startDate: new Date()
    });
});