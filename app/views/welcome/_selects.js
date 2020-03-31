$(document).ready(function () {
    $('#filterrific_search_query, .component-select').selectize({
        theme: 'links',
        maxOptions: 5,
        sortField: 'text',
        placeholder: '¿Qué ciudad búscas?'
    });
});