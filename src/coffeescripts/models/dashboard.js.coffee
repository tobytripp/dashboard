class Dashboard extends Backbone.Collection
  defaults:
    columns: 3,
    rows:    2

  model: Dashboard.Cell
