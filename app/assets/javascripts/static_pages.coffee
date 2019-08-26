# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/


$(document).ready ->
  $('#loadingSpinner').hide()
  # show spinner on AJAX start
  $(document).ajaxStart ->
    $('#loadingSpinner').show()
    return
  # hide spinner on AJAX stop
  $(document).ajaxStop ->
    $('#loadingSpinner').delay(3000).hide(0)
    return
  return
  
$(document).on 'ajax:before ajaxStart page:fetch', (event) ->
  $('#loadingSpinner').show()
  $('#releaseByPlatform').hide()
  
$(document).on 'ajax:complete ajaxComplete page:change', (event) ->
  $('#loadingSpinner').hide()
  $('#releaseByPlatform').show()