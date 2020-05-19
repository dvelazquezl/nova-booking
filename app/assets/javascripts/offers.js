$(function () {
    $(document).on('keypress', '.discount', function () {
        let input = $(event.target).val() + (event.charCode - 48);
        return (input >= 1 && input < 100)
    });

    $(document).on('paste', '.discount', function (e) {
        input = $(this).val() + e.originalEvent.clipboardData.getData('text');
        if (e.originalEvent.clipboardData.getData('text').match(/[^\d]/))
            e.preventDefault(); //prevent the default behaviour
        if (parseInt(input) < 1 || parseInt(input) >= 100)
            e.preventDefault();
    });

    let generalOptions = {};
    let prevValue = '';
    $(document).on('focus', '.room-select', function () {
        prevValue = this.value;
    });

    $(document).on('change', '.room-select', function (e) {
        e.stopImmediatePropagation();
        // lista de selects
        const list = $('.room-select');
        // select cambiado
        const changedSelect = $(this);
        // lista de selects sin el cambiado
        const unchangedSelects = list.filter(function () {
            return $(this).attr('id') !== changedSelect.attr('id')
        });
        // obtener del select cambiado
        const selectedValue = changedSelect.children("option:selected").val();
        const selectOptions = getOptionValues(changedSelect);
        // habilitar link para agregar mas filas
        let add_fields = document.getElementsByClassName('add_fields')[0];
        (selectedValue !== "") ? add_fields.style.display = "block" : add_fields.style.display = "none";
        // para esconder link agregar habitacion
        if (getOptionValues($("#" + changedSelect.attr('id') + " option")).length === 2) add_fields.style.display = "none";
        // restar opcion seleccionada con todas las opciones
        // del select cambiado
        const subs = selectOptions.filter((option) => {
            return option !== selectedValue.toString()
        });
        // ver lo de lista general
        generalOptions = $.isEmptyObject(generalOptions) ? getOptionsHash(list.first()) : generalOptions;
        // iterar por resto de selects
        unchangedSelects.each((key, value) => {
            // obtener valores del select no cambiado
            const options = getOptionValues($("#" + value.id + " option"));
            // quitar opcion seleccionada
            let optionsWithoutSelected = options.filter((option) => {
                return option !== selectedValue.toString();
            });
            // para el valor previo seleccionado
            if (!optionsWithoutSelected.includes(prevValue)) optionsWithoutSelected.push(prevValue);
            // revisar mañana
            let set = new Set(optionsWithoutSelected);
            // agregar los valores restantes al set de option
            subs.forEach((option) => {
                set.add(option);
            });
            let currentSelect = $("#" + value.id);
            // obtener seleccionado
            const selected = currentSelect.children("option:selected").val();
            currentSelect.empty();
            set.forEach((val) => {
                currentSelect.append(`<option value="${val}"> 
                                       ${generalOptions[val]} 
                                  </option>`);
            });
            currentSelect.val(selected);
        });
    });

    function getOptionValues(select) {
        let optionValues = [];
        select.each(function () {
            optionValues.push($(this).val());
        });
        return optionValues;
    }

    function getOptionsHash(select) {
        let hashes = {};
        let options = select.children();
        options.each(function () {
            hashes[$(this).val()] = $(this).text()
        });
        return hashes;
    }

// al eliminar una fila del formulario de ofertas
    $(document).on('click', '.delete-room', function () {
        if ($('.delete-room').length >= 1) {
            // obtener select de fila a eliminar
            let select = $(this).parent().parent().children().first().children().first();
            const selectVal = select.val();
            // habilitar link de agregar habitacion
            let add_fields = document.getElementsByClassName('add_fields')[0];
            // por ej: si select tiene: Seleccionar, Mi Habitacion
            if (getOptionValues(select).length >= 2) add_fields.style.display = "block";
            $('.room-select').each((key, value) => {
                const select = $("#" + value.id);
                // obtener valores del select
                const options = getOptionValues($("#" + value.id + " option"));
                if (!options.includes(selectVal)) {
                    const selectedOption = select.children("option:selected").val();
                    select.append(`<option value="${selectVal}"> 
                                       ${generalOptions[selectVal]} 
                                  </option>`);
                    select.val(selectedOption);
                }
            })
        }
    });

    $(document).on('click', '.add_fields', function (e) {
        e.stopImmediatePropagation();
        // para filtrar
        let optionsLeft = JSON.parse(JSON.stringify(generalOptions));
        // opciones seleccionadas
        let options = [];
        // selects
        let list = $('.room-select');
        let lastSelect = list.last();
        const prevsSelects = list.filter(function () {
            return $(this).attr('id') !== lastSelect.attr('id')
        });
        // obtener valores de selects anteriores
        prevsSelects.each(function (key, value) {
            const selectedVal = $("#" + value.id).children("option:selected").val();
            options.push(selectedVal);
        });
        // quitar opciones ya elegidas
        options.forEach((option) => {
            delete optionsLeft[option]
        });
        // vaciar ultimo select
        lastSelect.empty();
        for (const [key, value] of Object.entries(optionsLeft)) {
            // agregar opciones disponibles a ultimo select
            lastSelect.append(`<option value="${key}"> 
                                       ${value} 
                                  </option>`);
        }
        lastSelect.val("");
        // esconder link
        $(this).hide();
    });

    let isInDOM = false;
    let observer = new MutationObserver(mutations => {
        const element = document.getElementsByClassName('add_fields')[0];
        if (document.body.contains(element) && !isInDOM) {
            element.style.display = "none";
            isInDOM = true;
        }

    });

    // observar todo menos los atributos
    observer.observe(document, {
        childList: true, // observar children
        subtree: true, // y sus descendants tambien
    });

});
