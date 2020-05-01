$(function () {
    $(document).on('keypress', '.number', function () {
        let input = $(event.target).val() + (event.charCode - 48);
        return (input >= 1 && input < 100)
    });

    $(document).on('paste', '.number', function (e) {
        input = $(this).val() + e.originalEvent.clipboardData.getData('text');
        if (e.originalEvent.clipboardData.getData('text').match(/[^\d]/))
            e.preventDefault(); //prevent the default behaviour
        if (parseInt(input) < 1 || parseInt(input) >= 100)
             e.preventDefault();
    });

});

