# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/



$(document).ready ->
  $('#small-calendar').fullCalendar
    defaultView: 'basicWeek',
    aspectRatio: 3,
    firstDay: 1,
    eventSources: [{
      url: '/events',
      allDay: false
    }]

ready = ->
  $('.flag').click ->
    country = $(this).data('locale');    
    WorldFlagsUrlHelper.reloadWithLocaleParam(country);
 
$(document).ready(ready)
$(document).on('page:load', ready)
