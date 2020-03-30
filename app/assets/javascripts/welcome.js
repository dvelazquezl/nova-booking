//= require jquery3
//= require bootstrap
//= require bootstrap-datepicker
//= require bootstrap-datepicker/core
$(function() {
    var startDate = new Date();
    var FromEndDate = new Date();
    var ToEndDate = new Date();
    
    ToEndDate.setDate(ToEndDate.getDate()+365);
    FromEndDate.setDate(FromEndDate.getDate()+365);
    
    $('#with_date_gte').datepicker({
    
        weekStart: 1,
        startDate: startDate,
        endDate: FromEndDate, 
        autoclose: true
    })
        .on('changeDate', function(selected){
            startDate = new Date(selected.date.valueOf());
            startDate.setDate(startDate.getDate(new Date(selected.date.valueOf())));
            $('#with_date_lte').datepicker('setStartDate', startDate);
        }); 
    $('#with_date_lte')
        .datepicker({
    
            weekStart: 1,
            startDate: startDate,
            endDate: ToEndDate,
            autoclose: true
        })
        .on('changeDate', function(selected){
            FromEndDate = new Date(selected.date.valueOf());
            FromEndDate.setDate(FromEndDate.getDate(new Date(selected.date.valueOf())));
            $('#with_date_gte').datepicker('setEndDate', FromEndDate);
        });
});