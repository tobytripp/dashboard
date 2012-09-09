window.Timer = ->
Timer::interval = (ms, callback) ->
  @id = window.setInterval callback, ms
Timer::once = (ms, callback) ->
  @id = window.setTimeout callback, ms
Timer::stop = () ->
  window.clearInterval @id
