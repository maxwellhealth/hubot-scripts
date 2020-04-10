# Description:
#   Manage alerts with Hubot.
#
# Commands:
#   hubot alerts take
#   hubot alerts who
#
# Configuration:
#   none

module.exports = (robot) ->

  robot.respond /alerts (.*)/i, (msg) ->
    room = msg.message.room
    lobe = "alerts-#{room}"
    alerts = robot.brain.get(lobe) or 'no one'
    username = msg.message.user.name.toLowerCase()
    method = msg.match[1]
    if method is "take"
      msg.send alerts + ' was on alerts, now ' + username + ' is on alerts.'
      robot.brain.set lobe, username
    else if method is "taketh"
      msg.send "Forsooth! " + alerts + " was the alertee, but " + username + " taketh alerts henceforth!  May thy crits be not.."
      msg.send "/me bows"
      robot.brain.set lobe, username
    else if method is "takizzle"
      msg.send "Sup " + alerts + " dawg, looks like home slice " + username + "'s pickin' up yo 'lerts, woooord homes."
      robot.brain.set lobe, username
    else if method is "01110100011000010110101101100101"
      msg.send alerts + " 01110111011000010111001100100000011011110110111000100000011000010110110001100101011100100111010001110011001011000010000001101110011011110111011100100000 " + username + " 011010010111001100100000011011110110111000100000011000010110110001100101011100100111010001110011"
      robot.brain.set lobe, username
    else if method is "1"
      msg.send alerts + " : 0 " + username + " : 1"
      robot.brain.set lobe, username
    else if /whom?|0/.test(method)
      msg.send alerts + ' is on alerts.'
    else if /giveth/.test(method)
      username = method.replace('giveth ', '').replace(/\s+/g, '').toLowerCase()
      return usage msg if username is "giveth"
      msg.send "Forsooth! " + alerts + " was the alertee, but " + username + " taketh alerts henceforth!  May thy crits be not.."
      msg.send "/me bows"
      robot.brain.set lobe, username
    else if /give/.test(method)
      username = method.replace('give ', '').replace(/\s+/g, '').toLowerCase()
      return usage msg if username is "give"
      msg.send alerts + ' was on alerts, now ' + username + ' is on alerts.'
      robot.brain.set lobe, username
    else if /givizzle/.test(method)
      username = method.replace('givizzle ', '').replace(/\s+/g, '').toLowerCase()
      return usage msg if username is "givizzle"
      msg.send "Sup " + alerts + " dawg, looks like home slice " + username + "'s pickin' up yo 'lerts, woooord homes."
      robot.brain.set lobe, username
    else
      usage msg

  usage = (msg) -> msg.reply "Usage: alerts < who | take | give [name] >"
