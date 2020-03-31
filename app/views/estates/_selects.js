$(document).ready(function () {
    $('#estate_city_id, .component-select').selectize({
        maxOptions: 5,
        sortField: 'text',
        placeholder: 'Seleccione una ciudad'
    });
});