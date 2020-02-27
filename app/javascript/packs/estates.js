// Place all the behaviors and hooks related to the matching controller here.
// All this logic will automatically be available in application.js.

import $ from 'jquery';

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
