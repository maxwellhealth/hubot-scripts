# Description:
#   Do the someone else's problem dance
#
# Commands:
# hubot sep
#
# Configuration:
#   none

module.exports = (robot) ->

  robot.hear /(someone else's problem)/i, (res) ->
    dance(res)

  robot.respond /(sep|someone else'?s problem)/i, (res) ->
    dance(res)

dance = (res) ->
  res.send "♫♫ Someone Else's Problem! ♫♫"
  res.send "(>'o')>"
  res.send "<('o'<)"
  res.send "^( '.' )^"
  res.send "v( '.' )v"
