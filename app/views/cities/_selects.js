$(document).ready(function () {
    $('#city_departament_id, .component-select').selectize({
        maxOptions: 5,
        sortField: 'text',
        placeholder: 'Seleccione un Departamento'
    });
});