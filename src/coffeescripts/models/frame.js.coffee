class Dashboard.Frame extends Backbone.Model
  defaults:
    refresh_rate: undefined

  initialize: (url, refresh_after) ->
    @url = url
    @refresh_after_ms = refresh_after && (refresh_after * 1000)

    if @refresh_after_ms?
      @start_refresh( @refresh_after_ms )

  start_refresh: (period) ->
    @interval_id = setInterval( _.bind( @refresh, this ), period )

  halt: () ->
    clearInterval( @interval_id )

  refresh: () ->
    @trigger "change"
