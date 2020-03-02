import $ from 'jquery';

import initImageCropper from './angle/modules/forms/imagecrop';
import initSelect2 from './angle/modules/forms/select2';
import initWizard from './angle/modules/forms/wizard';
import initXEditable from './angle/modules/forms/xeditable';

$(function () {

    initImageCropper();
    initSelect2();
    initWizard();
    initXEditable();
});

$(function() {

    $('#pictureInput').on('change', function(event) {
        $('#target').empty();
    });
});