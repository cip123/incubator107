# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

$(document).ready ->

  body = document.body
  html = document.documentElement;

  height = Math.max( body.scrollHeight, body.offsetHeight, 
                       html.clientHeight, html.scrollHeight, html.offsetHeight );

  if $(".sidebar").height() <= height
    $(".sidebar").css("min-height", height + 200)
  
  $('#subscribe-newsletter').popover()
  $('#subscribe-newsletter').click ->
    return false;

