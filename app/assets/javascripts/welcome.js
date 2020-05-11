//= require bootstrap-datepicker
//= require bootstrap-datepicker/core
//= require bootstrap-datepicker/locales/bootstrap-datepicker.es
//= require jquery.easy-autocomplete

$(function () {
    let options_easy = {

        url: "/welcome/resources.json",

        getValue: "name",

        list: {
            match: {
                enabled: true
            }
        },

        theme: "blue-light"
    };
    $("#with_search_home").easyAutocomplete(options_easy);
    $("#with_search_results").easyAutocomplete(options_easy);
});

$(function () {
    if ($("#price_max").val() == '1000000000')
        $("#price_max").val('');
    if ($("#price_min").val() == '0')
        $("#price_min").val('');
    $(document).on('paste', '.price', function (e) {
        if (e.originalEvent.clipboardData.getData('text').match(/[^\d]/))
            e.preventDefault(); //prevent the default behaviour
    });
    $(document).on('keypress', '.price', function () {
        let input = $(event.target).val() + (event.charCode - 48);
        console.log(input);
        return (input >= 1);
    });
})