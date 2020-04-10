# Description:
#   post the url to the github project for the bot
#
# Dependencies:
#   None
#
# Configuration:
#   None
#
# Commands:
#   hubot contribute - get the link to the bot repo
#
# Notes:
#   None
#
# Author:
#   Brad Clark <bdashrad@gmail.com>

module.exports = (robot) ->

  robot.respond /\bcontrib(ute)?\b/, (res) ->
    res.send "https://github.com/DailyFeats/maxbot"
