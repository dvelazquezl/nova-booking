// Place all the behaviors and hooks related to the matching controller here.
// All this logic will automatically be available in application.js.
import $ from 'jquery';

import initImageCropper from './angle/modules/forms/imagecrop';
import initSelect2 from './angle/modules/forms/select2';
import initWizard from './angle/modules/forms/wizard';
import initXEditable from './angle/modules/forms/xeditable';

$(function() {

    initImageCropper();
    initSelect2();
    initWizard();
    initXEditable();
});
// for image preview in_form.html.erb
$(function() {
    $('#pictureInput').on('change', function(event) {
        let files = event.target.files;
        let image = files[0];
        let reader = new FileReader();
        reader.onload = function(file) {
            let img = new Image();
            img.src = file.target.result;
            img.classList.add("img-thumbnail")
            $('#target').append(img);
        };
        reader.readAsDataURL(image);
    });
});
