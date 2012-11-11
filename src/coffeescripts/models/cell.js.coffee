#= require frame
$ = undefined

class Dashboard.Cell extends Backbone.Model
  class FrameSet extends Backbone.Collection
    model: Dashboard.Frame

  defaults:
    face: 0

  initialize: (attributes, options) ->
    @frames = new FrameSet()
    @frames.on "add", @assert_face, @
    @frames.on "add",
      (frame) => @trigger "cell:add", frame, @

  addUrl: (url) ->
    @add new Dashboard.Frame( url: url )

  at: (index) ->
    @frames.at index

  each: (callback) ->
    @frames.each callback

  add: (frames) ->
    @frames.add frames

  flip: ->
    face = @get 'face'
    @set 'face', (face + 1) % 2

  assert_face: ->
    front_frame = @frames.find (frame) -> frame.front()
    @frames.at(0).flip() unless front_frame

  backFacing: () ->
    @get( "face" ) > 0
