
saved_repos = {}
saved_branches = {}
saved_tree = {}

reopen = false

typeahead_cb = (q,cb,result) ->
  matches = []

  # regex used to determine if a string contains the substring `q`
  substrRegex = new RegExp(q, "i")

  # iterate through the pool of strings and for any string that
  # contains the substring `q`, add it to the `matches` array
  $.each result, (i, res) ->

    # the typeahead jQuery plugin expects suggestions to a
    # JavaScript object, refer to typeahead docs for more info
    matches.push res  if substrRegex.test(res["value"])

  cb(matches)

autocomplete_items = (query, cb)->
  reg = query.match(/([\w-]+)\/([\w-]*)/)
  if reg
    user = reg[1]
    repo = reg[2]
    if saved_repos[user]
      typeahead_cb(query,cb,saved_repos[user])
    else
      $.getJSON "github/repos.json",{user: user}, (data) ->
        saved_repos[user] = data
        typeahead_cb(query,cb,saved_repos[user])
  reg = query.match(/([\w-]+)\/([\w-]+)\/([\w-]*)/)
  if reg
    repo = "#{reg[1]}/#{reg[2]}"
    branch = reg[3]
    if saved_branches[repo]
      typeahead_cb(query,cb,saved_branches[repo])
    else
      $.getJSON "github/branches.json",{repo: repo}, (data) ->
        saved_branches[repo] = data
        typeahead_cb(query,cb,saved_branches[repo])
  reg = query.match(/([\w-]+)\/([\w-]+)\/([\w-]+)(\/.*)\/?/)
  if reg
    repo = "#{reg[1]}/#{reg[2]}"
    branch = reg[3]
    querypath = reg[4]
    path = querypath.match(/(.*)\/(.*$)/)[1]
    identifier = "#{repo}/#{branch}#{path}"
    if saved_tree[identifier]
      typeahead_cb(query,cb,saved_tree[identifier])
    else
      $.getJSON "github/tree.json",{repo: repo, branch: branch, path: path}, (data) ->
        saved_tree[identifier] = data
        typeahead_cb(query,cb,saved_tree[identifier])

codepicker = ->
  codepick = $('#codepicker').typeahead
    hint: true,
    highlight: true,
    minLength: 1
  ,
    displayKey: 'value',
    source: autocomplete_items

  codepick.on "typeahead:selected" ,(e,suggest,s) ->
    if suggest["path"] && suggest["type"] != "dir"
      reopen = false
      $.get "github/content.html",
        repo: suggest["repo"]
        branch: suggest["branch"]
        path: suggest["path"]
      , (data) ->
        $('#onebox').html data
        $('#onebox').parent().addClass('in')
    else
      reopen = true

  codepick.on "typeahead:closed", ->
    if reopen
      reopen = false
      withSlash = codepick.typeahead('val') + '/'
      codepick.typeahead('val', withSlash)
      setTimeout ->
        codepick.data('ttTypeahead').dropdown.update(withSlash)
        codepick.data('ttTypeahead').dropdown.open()
      , 100
  $('#codepicker').keypress (e)->
    if (e.which == 13) 
      e.preventDefault();
      return false;





$(document).ready codepicker
$(document).on 'page:load', codepicker
$(document).on 'cocoon:after-insert', codepicker
