/*global jQuery */
/*!	
* FitText.js 1.0
*
* Copyright 2011, Dave Rupert http://daverupert.com
* Released under the WTFPL license 
* http://sam.zoy.org/wtfpl/
*
* Date: Thu May 05 14:23:00 2011 -0600
*/

(function( $ ){
	
  $.fn.fitText = function( kompressor, options ) {
	   
    // Setup options
    var compressor = kompressor || 1,
        settings = $.extend({
          'minFontSize' : Number.NEGATIVE_INFINITY,
          'maxFontSize' : Number.POSITIVE_INFINITY
        }, options);
	
    return this.each(function(){

      // Store the object
      var $this = $(this); 
        
      // Resizer() resizes items based on the object width divided by the compressor * 10
      var resizer = function () {
        $this.css('font-size', Math.max(Math.min($this.width() / (compressor*10), parseFloat(settings.maxFontSize)), parseFloat(settings.minFontSize)));
      };

      // Call once to set.
      resizer();
				
      // Call on resize. Opera debounces their resize by default. 
      $(window).on('resize', resizer);
      	
    });

  };

})( jQuery );

$(function(){
  $('[title]').tooltip();

  $('.carousel').carousel({interval: 10000});

  $("#jumbotron").fitText(0.8, { minFontSize: '40px', maxFontSize: '70px' });

  $('#icon-size-buttons').on('click','.btn',function(){
    $('#icons i').css('font-size',jQuery(this).val());
  });
  $('#icon-shadow-buttons').on('click','.btn',function(){
    $('#icons i').css('text-shadow',jQuery(this).val());
  });
  $('#icon-color-buttons').on('click','.btn',function(){
    $('#icons i').css('color',jQuery(this).val());
  });
});
