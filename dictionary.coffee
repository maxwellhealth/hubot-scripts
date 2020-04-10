# Description:
#   Manage a growing dictionary of terms and acronyms with Hubot.
#
# Commands:
#   hubot define word definition
#   hubot what is word
#   hubot lookup word
#
# Configuration:
#   none

module.exports = (robot) ->

  robot.respond /define (\w*) (.*)/i, (msg) ->
    word = msg.match[1].toLowerCase()
    definition = msg.match[2].toLowerCase()
    if !definition
      msg.send 'You need to provide a definition'
    else
      msg.send word + ' is now defined as ' + definition
      robot.brain.set word, definition

  robot.respond /(?:what is|lookup) (\w*)/i, (msg) ->
    word = msg.match[1].toLowerCase()
    definition = robot.brain.get(word) or 'I do not have a definition for that, maybe you should add it?'
    msg.send definition
