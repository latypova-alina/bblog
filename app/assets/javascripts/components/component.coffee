class Component
  constructor: (el, props = {}) ->
    @refs ?= {}
    @$refs = {}
    @el = el
    @$el = $(el)
    @props = props
    @beforeInitialize()
    @_initRefs()
    @initialize()
    @bindings()
    @componentDidMount()

  initialize: ->
    #template method

  bindings: ->
    #template method

  beforeInitialize: ->
    #template method

  componentDidMount: ->
    #template method

  _initRefs: =>
    @$refs[name] = $(selector, @$el) for name, selector of @refs

window.Components =
  Base: Component
