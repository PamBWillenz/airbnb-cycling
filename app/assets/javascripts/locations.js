$(function() {
    $('#datepicker-start').pickadate()
    $('#datepicker-end').pickadate()
});

// $(document).ready('turbolinks:load', function() { 
//   jQuery(function($) {
//     $("#datepicker-start").pickadate({
//             dateFormat: "d MM, yy"
//     });
//     $("#datepicker-end").pickadate({
//             dateFormat: "d MM, yy"
//     });
//   });
// });

// LONGER VERSION

// $(document).ready('turbolinks:load', function(){
//   jQuery(function($) {
//     var dateFormat = "dd/mm/yy",
//       from = $("#datepicker-start").datepicker({
//         defaultDate: "+1w",
//         minDate: "0",
//         dateFormat: "dd/mm/yy",
//         changeMonth: true,
//         numberOfMonths: 1,
//         beforeShowDay: function(date){
//           var string = jQuery.datepicker.formatDate('yy-mm-dd', date);
//           if (typeof availableDates !== 'undefined') {
//             return [ availableDates.indexOf(string) != -1 ]
//           } else {
//             return [ true ]
//           }
//         }
//       })
      
//       .on("change", function() {
//         to.datepicker("option", "minDate", getDate(this));
//       }),
//       to = $("#datepicker-end").datepicker({
//         defaultDate: "+1w",
//         dateFormat: "dd/mm/yy",
//         changeMonth: true,
//         numberOfMonths: 1,
//         beforeShowDay: function(date){
//           var string = jQuery.datepicker.formatDate('yy-mm-dd', date);
//           if (typeof availableDates !== 'undefined') {
//             return [ availableDates.indexOf(string) != -1 ]
//           } else {
//             return [ true ]
//           }
//         }
//       })
//       .on("change", function() {
//         from.datepicker( "option", "maxDate", getDate( this ));
//       })

//       function getDate( element ) {
//         var date;
//         try {
//           date = $.datepicker.parseDate( dateFormat, element.value );
//           date = new Date(date.getFullYear(), date.getMonth(), date.getDate() + 1);
//         } catch( error ) {
//           date = null;
//         }
//         return date;
//       }
//     });
//   });
