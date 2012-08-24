class DashboardView extends Backbone.View
  el: $ '#dashboard'

  initialize: ->
    _.bindAll @               # bind all instance methods to this instance
    @dashboard = new Dashboard
    @dashboard.bind "add", @appendCell

    @render()

  render: ->
    $(@el).append "<p>Dashboard</p>"

  appendCell: (cell) ->
    cell_view = new CellView model: cell
    # TODO: append cell_view.render().el to our container

jQuery ->
  dashboard_view = new DashboardView
