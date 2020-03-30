//= require bootstrap-datepicker
//= require bootstrap-datepicker/core
//= require bootstrap-datepicker/locales/bootstrap-datepicker.es.js
//= require bootstrap-datepicker/locales/bootstrap-datepicker.fr.js
$(function() {
    $('#sandbox-container .input-daterange').datepicker({
        todayBtn: true,
        clearBtn: true,
        todayHighlight: true
    });
});