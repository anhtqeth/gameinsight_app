# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

$(document).on 'turbolinks:load', ->
    
    pad = (n) ->
      if n < 10 then '0' + n else n
    
    getTimeLeft = ->
      
      time_left = Math.abs(new Date(end_time*1000) - (new Date))
      seconds = time_left/1000
      days = Math.floor(seconds / 24 / 60 / 60)
      hoursLeft = Math.floor(seconds - (days * 86400))
      hours = Math.floor(hoursLeft / 3600)
      minutesLeft = Math.floor(hoursLeft - (hours * 3600))
      minutes = Math.floor(minutesLeft / 60)
      remainingSeconds = Math.floor(seconds % 60)
         

      $('#result').text(pad(days) + ' Days ' + pad(hours) + ' Hours ' + pad(minutes) + ' Minutes ' + pad(remainingSeconds)+ ' Seconds')
      # $('#result').text minutes + ':' + seconds
      $('#js-endate').text 'END TIME '+new Date(end_time*1000)
      $('#js-newdate').text 'CURRENT TIME ' + new Date
      return

    setInterval(getTimeLeft, 1000)
return