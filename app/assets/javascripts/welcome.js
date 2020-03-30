//= require jquery3
//= require bootstrap
//= require bootstrap-datepicker
//= require bootstrap-datepicker/core
$(function() {
    $('#with_date_gte, #with_date_lte').datepicker({
        todayBtn: true,
        clearBtn: true,
        todayHighlight: true
    });
});