{CompositeDisposable} = require 'atom'
{spawn} = require 'child_process'
Dialog = require './dialog'

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

  new: ->
    dialog = new Dialog {
      initialPath: 'post/'
      prompt: 'Create new content for your site'
    }
    dialog.onConfirm = (path) ->
      # Spawn "hugo new [path] [flags]"
      h = spawn 'hugo', ['new', path, "-s=#{atom.project.getPaths()[0]}"]

      # Show notifications for output and error messages
      h.stdout.on 'data', (data) -> atom.notifications.addSuccess data.toString()
      h.stderr.on 'data', (data) -> atom.notifications.addError data.toString()

      dialog.close()

    dialog.attach()

  newSite: ->
    dialog = new Dialog {
      initialPath: atom.config.get('core.projectHome')
      prompt: 'Create a new site (skeleton)'
    }
    dialog.onConfirm = (path) ->
      # Spawn "hugo new site [path] [flags]"
      h = spawn 'hugo', ['new', 'site', path, "-f=#{atom.config.get('atom-hugo.site.format')}"]

      # Show notifications for output and error messages
      h.stdout.on 'data', (data) -> atom.notifications.addSuccess data.toString()
      h.stderr.on 'data', (data) -> atom.notifications.addError data.toString()

      dialog.close()

    dialog.attach()
