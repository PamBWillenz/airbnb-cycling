// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, vendor/assets/javascripts,
// or any plugin's vendor/assets/javascripts directory can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// compiled file.
//
// Read Sprockets README (https://github.com/rails/sprockets#sprockets-directives) for details
// about supported directives.
//
//= require jquery
//= require jquery.turbolinks
//= require jquery_ujs
//= require jquery-ui/widgets/datepicker
//= require jquery-ui/widgets/sortable
//= require pickadate/picker
//= require pickadate/picker.date
//= require moment
//= require fullcalendar
//= require tether
//= require bootstrap-sprockets
//= require dropzone
//= require underscore
//= require gmaps/google
//= require markerclusterer
//= require turbolinks
//= require_tree .

$(document).on("page:load ready", function(){
    $("input.datepicker").datepicker();
});

