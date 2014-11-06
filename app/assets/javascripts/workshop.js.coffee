# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

ready = ->
    $('input[type="checkbox"]').click ->
      checkedAtLeastOne = false

      $('input[type="checkbox"]').each ->

        if ($(this).is(":checked")) 
          checkedAtLeastOne = true
    
      return checkedAtLeastOne

    $(".fancybox").fancybox 
      prevEffect  : 'none',
      nextEffect  : 'none',

    $('#myCarousel').carousel
      interval: 0
  
    $('.carousel-inner').each ->
      if ($(this).children('div').length == 1) 
        $(this).siblings('.carousel-control').hide()


$(document).ready(ready)
$(document).on('page:load', ready)
