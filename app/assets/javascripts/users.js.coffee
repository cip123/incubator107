# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/
 

$ ->
  $("#toggle_password_fields").change ->    
    $('#user_password').prop('disabled', !$('#toggle_password_fields').is(':checked'))
    $('#user_password_confirmation').prop('disabled', !$('#toggle_password_fields').is(':checked'))
