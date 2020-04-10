# Description
#   Grabs the current forecast from Dark Sky
#
# Dependencies
#   None
#
# Configuration
#   HUBOT_DARK_SKY_API_KEY
#   HUBOT_DARK_SKY_DEFAULT_LOCATION
#   HUBOT_DARK_SKY_SEPARATOR (optional - defaults to "\n")
#   HUBOT_DARK_SKY_UNITS (defaults to "us")
#
# Commands:
#   hubot forecast - Get the weekly forecast for HUBOT_DARK_SKY_DEFAULT_LOCATION
#   hubot forecast <location> - Get the weekly forecaset for <location>
#   hubot weather - Get the weather for HUBOT_DARK_SKY_DEFAULT_LOCATION
#   hubot weather <location> - Get the weather for <location>
#
# Notes:
#   If HUBOT_DARK_SKY_DEFAULT_LOCATION is blank, weather commands without a location will be ignored
#
# Author:
#   kyleslattery
#   awaxa
#   bdashrad
module.exports = (robot) ->
  robot.respond /(weather|forecast)\s?(\w+)?/i, (msg) ->
    action = msg.match[1]
    location = msg.match[2] || process.env.HUBOT_DARK_SKY_DEFAULT_LOCATION
    return if not location

    unless process.env.HUBOT_DARK_SKY_API_KEY
      msg.send "HUBOT_DARK_SKY_API_KEY not set!"
      return

    options =
      api_key: process.env.HUBOT_DARK_SKY_API_KEY
      label: "°C"
      separator: process.env.HUBOT_DARK_SKY_SEPARATOR ? "\n"
      units: process.env.HUBOT_DARK_SKY_UNITS ? "us"

    if options.units == "us"
      options.label = "°F"


    googleurl = "http://maps.googleapis.com/maps/api/geocode/json"
    q = sensor: false, address: location
    msg.http(googleurl)
      .query(q)
      .get() (err, res, body) ->
        result = JSON.parse(body)

        if result.results.length > 0
          lat = result.results[0].geometry.location.lat
          lng = result.results[0].geometry.location.lng
          darkSkyMe msg, lat, lng, action, options.api_key, options.separator, options.units, options.label, (darkSkyText) ->
            response = "Weather for #{result.results[0].formatted_address} (Powered by DarkSky https://darksky.net/poweredby/)#{options.separator}"
            response += darkSkyText
            response += "#{options.separator}"
            msg.send response
        else
          msg.send "Couldn't find #{location}"

darkSkyMe = (msg, lat, lng, action, api_key, separator, units, label, cb) ->
  url = "https://api.darksky.net/forecast/#{api_key}/#{lat},#{lng}/?units=#{units}"
  msg.http(url)
    .get() (err, res, body) ->
      result = JSON.parse(body)

      if result.error
        cb "#{result.error}"
        return

      console.log action
      response = "Currently: #{result.currently.summary} #{result.currently.temperature}#{label}."
      if action == "weather"
        response += ". Feels like #{result.currently.apparentTemperature}#{label}."
        response += "#{separator}Next Hour: #{result.minutely.summary}"
      response += "#{separator}Today: #{result.hourly.summary}"
      if action == "forecast"
        response += "#{separator}Coming week: #{result.daily.summary}"
      cb response
