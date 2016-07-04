module.exports = (robot) ->

  robot.brain.data.snippet_database = {
    "next_id": 1,
    "snippets": [
      {"id": 0, "code": "Blablabla"}
    ],
    "rmquote": [],
    "purgeallquotes": false
  }


  robot.respond /addcode (.*)?$/i, (msg) ->
    if msg.match[1]
      for snippet_index in robot.brain.data.snippet_database.snippets
        if snippet_index.snippet == msg.match[1]
          msg.send "This snippet already exists: #{snippet_index.snippet}]"
          return
      snippet_id = robot.brain.data.snippet_database.next_id++
      snippetInput = msg.match[1]
      robot.brain.data.snippet_database.snippets.push {"id": snippet_id, "code": msg.match[1]}
      msg.send "This snippet has been added: ID: [#{snippet_id}] code: #{snippetInput}."
    else
      msg.send "You must supply some text after 'addcode'.  For example: 'addcode This will be added to the DB.'."

  robot.respond /searchcode (.*)?$/i, (msg) ->
    # Find all codesnippets by a pattern
    if msg.match[1]
      searchQuery = toString(msg.match[1])
      snippet_found = false
      for snippet_index in robot.brain.data.snippet_database.snippets
        snippetData = toString(snippet_index.snippets)
        if snippetData.match new RegExp(searchQuery)
          #Displays code of the search results
          showCode = toString(this)
          snippet_found = true
          msg.send "#{showCode}"

      if not snippet_found
        msg.send "There were no matching snippets found [Pattern: #{msg.match[1]}]."

    else
      msg.send "You must supply a pattern to match after 'searchcode'.  For example: 'searchcode (F|f)oobar'."
#
