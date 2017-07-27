AtomHugoView = require './atom-hugo-view'
{CompositeDisposable} = require 'atom'

module.exports = AtomHugo =
  atomHugoView: null
  modalPanel: null
  subscriptions: null

  activate: (state) ->
    @atomHugoView = new AtomHugoView(state.atomHugoViewState)
    @modalPanel = atom.workspace.addModalPanel(item: @atomHugoView.getElement(), visible: false)

    # Events subscribed to in atom's system can be easily cleaned up with a CompositeDisposable
    @subscriptions = new CompositeDisposable

    # Register command that toggles this view
    @subscriptions.add atom.commands.add 'atom-workspace', 'atom-hugo:toggle': => @toggle()

  deactivate: ->
    @modalPanel.destroy()
    @subscriptions.dispose()
    @atomHugoView.destroy()

  serialize: ->
    atomHugoViewState: @atomHugoView.serialize()

  toggle: ->
    console.log 'AtomHugo was toggled!'

    if @modalPanel.isVisible()
      @modalPanel.hide()
    else
      @modalPanel.show()
