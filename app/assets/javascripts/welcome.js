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

//Función en caso de que no ingrese datos en alguno de los inputs formatea para que funciona el filtro
$(function () {
    if ($("#price_max").val() == '1000000000') {
        $("#price_max").val('');
    }
    if ($("#price_min").val() == '0') {
        $("#price_min").val('');
    }
});

//Función para validar entrada de inputs de precio (no permite ingresar ni pegar valores que no sean numericos)
$(function () {
    $(".price").on("keyup", function (event) {
        let input = $(event.target).val();
        input = input.replace(/[\D\s\._\-]+/g, "");
        input = input ? parseInt(input, 10) : 0;
        $(event.target).val(function () {
            return input == 0 ? '' : input;
        });
    });

    $(".price").on("keypress", function (event) {
        let input = window.Event ? event.which : event.keyCode
        return (input >= 48 && input <= 57)
    });

    $(".price").on("paste", function (e) {
        let input = $(this).val() + e.originalEvent.clipboardData.getData('text');
        if (e.originalEvent.clipboardData.getData('text').match(/[^\d]/))
            e.preventDefault(); //prevent the default behaviour
        if (parseInt(input) < 1)
            e.preventDefault();
    });
});