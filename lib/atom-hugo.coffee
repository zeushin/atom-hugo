{CompositeDisposable} = require 'atom'

module.exports = AtomHugo =
  subscriptions: null

  config:
    site:
      type: 'object'
      order: 1
      properties:
        format:
          type: 'string'
          default: 'toml'
          enum: ['yaml', 'json', 'toml']
          title: 'Format'
          description: 'Config frontmatter format'
    build:
      type: 'object'
      order: 2
      properties:
        buildDrafts:
          type: 'boolean'
          default: false
          title: 'Build drafts'
          description: 'Include content marked as draft'
        buildExpired:
          type: 'boolean'
          default: false
          title: 'Build expired'
          description: 'Include expired content'
        buildFuture:
          type: 'boolean'
          default: false
          title: 'Build future'
          description: 'Include content with publishdate in the future'
        watch:
          type: 'boolean'
          default: false
          title: 'Watch'
          description: 'Watch filesystem for changes and recreate as needed'
    server:
      type: 'object'
      order: 3
      properties:
        buildDrafts:
          type: 'boolean'
          default: false
          title: 'Build drafts'
          description: 'Include content marked as draft'
        buildExpired:
          type: 'boolean'
          default: false
          title: 'Build expired'
          description: 'Include expired content'
        buildFuture:
          type: 'boolean'
          default: false
          title: 'Build future'
          description: 'Include content with publishdate in the future'
        watch:
          type: 'boolean'
          default: true
          title: 'Watch'
          description: 'Watch filesystem for changes and recreate as needed'

  activate: (state) ->
    # Events subscribed to in atom's system can be easily cleaned up with a CompositeDisposable
    @subscriptions = new CompositeDisposable

    # Register command that toggles this view
    @subscriptions.add atom.commands.add 'atom-workspace',
      'atom-hugo:new': => @new()
      'atom-hugo:new-site': => @newSite()
      'atom-hugo:build': => @build()
      'atom-hugo:server': => @server()
      'atom-hugo:kill-server': => @killServer()

  deactivate: ->
    @subscriptions.dispose()

  toggle: ->
    console.log 'AtomHugo was toggled!'

    if @modalPanel.isVisible()
      @modalPanel.hide()
    else
      @modalPanel.show()
