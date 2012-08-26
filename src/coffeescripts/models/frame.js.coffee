$ = undefined
window.Dashboard ?= {}

class Dashboard.Frame extends Backbone.Model
  @BACK:  0
  @FRONT: 1

  defaults:
    refresh_rate: undefined
    face:         Frame.BACK

  initialize: () ->
    refresh_after = @get "refresh_after"
    @refresh_after_ms = refresh_after && (refresh_after * 1000)

    if @refresh_after_ms?
      @start_refresh( @refresh_after_ms )

  start_refresh: (period) ->
    @interval_id = setInterval( _.bind( @refresh, this ), period )

  halt: () ->
    clearInterval( @interval_id )

  refresh: () ->
    @trigger "change"

  front: ->
    @get('face') == Frame.FRONT

  flip: ->
    face = @get 'face'
    face = (face + 1) % 2
    @set 'face', face
    @
