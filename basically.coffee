# Description:
#   Counts how often the word "basically" is used.
#
# Commands:
#   hubot <any text> basically? - Respond with the "basically" leaderboard
#

module.exports = (robot) ->

  robot.hear /^(?!.*\bmax\b).*basically/i, (res) ->
    user = res.message.user.name.toLowerCase()

    basicallyScores = robot.brain.get('basicallyScores') or {}
    userScore = basicallyScores[user] * 1 or 0
    basicallyScores[user] = userScore + 1
    
    robot.brain.set 'basicallyScores', basicallyScores
  
  robot.respond /.*basically\?$/i, (res) ->
    basicallyScores = robot.brain.get('basicallyScores') or {}
    
    if Object.keys(basicallyScores).length == 0 
      return

    leaderboard = (Object.keys(basicallyScores).sort (a, b) -> basicallyScores[b] - basicallyScores[a])[0...3]
    
    res.send "We're all basically winners in life. But the winners, basically, are: "
    for k in leaderboard
      res.send k + ': ' + basicallyScores[k] 
      
