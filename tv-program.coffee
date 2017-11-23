module.exports = (env) ->

  Promise = env.require 'bluebird'
  assert = env.require 'cassert'
  M = env.matcher
  t = env.require('decl-api').types
  Request = require 'request'
  Xml2Json = require 'xml2json'

  nowUrl = "http://www.tvspielfilm.de/tv-programm/rss/jetzt.xml"
  eveningUrl = "http://www.tvspielfilm.de/tv-programm/rss/heute2015.xml"
  nightUrl = "http://www.tvspielfilm.de/tv-programm/rss/heute2200.xml"

  class TvProgramPlugin extends env.plugins.Plugin

    init: (app, @framework, @config) =>

      deviceConfigDef = require("./device-config-schema")
      @framework.deviceManager.registerDeviceClass("TvProgramDevice",{
        configDef : deviceConfigDef.TvProgramDevice,
        createCallback : (config) => new TvProgramDevice(config,this)
      })

      @framework.on "after init", =>
        mobileFrontend = @framework.pluginManager.getPlugin 'mobile-frontend'
        if mobileFrontend?
          mobileFrontend.registerAssetFile 'js', "pimatic-tv-program/app/tvTempl-page.coffee"
          mobileFrontend.registerAssetFile 'html', "pimatic-tv-program/app/tvTempl-template.html"
          mobileFrontend.registerAssetFile 'css', "pimatic-tv-program/app/css/tv.css"

        return

  class TvProgramDevice extends env.devices.Device
    template: 'tvProgram'

    attributes:
      schedule:
        description: 'the schedule data'
        type: t.string
      time:
        description: 'time of tv programm'
        type: t.string
      interval:
        description: 'refresh interval in minutes'
        type: t.number
      short:
        description: 'Show only short information without pictures and description'
        type: t.boolean

    actions:
      reLoadSchedule:
        description: "reloads the schedule"

    constructor: (@config, @plugin) ->
      @id = @config.id
      @name = @config.name
      @time = @config.time or "now"
      @interval = @config.interval or 5
      @short = @config.short or false
      @schedule = ""

      @reLoadSchedule()

      @timerId = setInterval ( =>
        @reLoadSchedule()
      ), (@interval * 60000)

      super()

    destroy: () ->
      if @timerId?
        clearInterval @timerId
        @timerId = null
      super()

    getTime: -> Promise.resolve(@time)

    setTime: (value) ->
      if @time is value then return
      @time = value

    getInterval: -> Promise.resolve(@interval)

    setInterval: (value) ->
      if @interval is value then return
      @interval = value

    getShort: -> Promise.resolve(@short)

    setShort: (value) ->
      if @short is value then return
      @short = value

    getSchedule: -> Promise.resolve(@schedule)

    setSchedule: (value) ->
      @schedule = value
      @emit 'schedule', value

    reLoadSchedule: ->
      if @time is "20:15"
        url = eveningUrl
      else if @time is "22:00"
        url = nightUrl
      else
        url = nowUrl

      Request.get url, (error, response, body) =>
        if error
          throw error

        data = JSON.parse(Xml2Json.toJson(body))

        items = data.rss.channel.item

        if items and items.length > 0
          placeholder = "<div class=\"tv-program\">"
          for i in [0...items.length - 1] by 1
            item = items[i]
            itemHtml = ""
            itemHtml = itemHtml + '<div class="tv-program-item">'
            itemHtml = itemHtml + '<div class="title">' + item.title + '</div>'
            if not @short and item.enclosure and item.enclosure.url
              itemHtml = itemHtml + '<div class="image"><img src="' + item.enclosure.url + '" /></div>'

            if not @short and Object.keys(item.description).length > 0
              description = item.description
              itemHtml = itemHtml + '<div class="description">' + description + '</div>'

            itemHtml = itemHtml + '</div><div style="clear:both;">&nbsp;</div>'

            placeholder = placeholder + itemHtml

          placeholder = placeholder + "</div>"

          @setSchedule(placeholder)

    actions:
      loadSchedule:
        description: "turns the switch on"

    destroy: ->
      super()

  tvProgramPlugin = new TvProgramPlugin
  return tvProgramPlugin