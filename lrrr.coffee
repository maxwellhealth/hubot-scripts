# Description:
#   translate tickets to their proper project
#
# Configuration:
#   none

module.exports = (robot) ->

  robot.hear /LRRR-(\d+)/i, (res) ->
    res.send 'I am Lrrr, ruler of the planet Omicron Persei 8!'
    id = res.match[1]
    url = 'https://' + process.env.HUBOT_JIRA_DOMAIN + '/browse/OMICRON-' + id
    res.send url
