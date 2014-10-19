
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

  codepick = $('.codepicker').not(".typeahead-loaded").typeahead
    hint: true,
    highlight: true,
    minLength: 1
  ,
    displayKey: 'value',
    source: autocomplete_items
  $('.codepicker').addClass("typeahead-loaded")

  codepick.on "typeahead:selected" ,(e,suggest,s) ->
    container = $(e.target).closest(".nested-fields")
    if suggest["path"] && suggest["type"] != "dir"
      reopen = false
      $.get "github/content.html",
        repo: suggest["repo"]
        branch: suggest["branch"]
        path: suggest["path"]
      , (data) ->
        $('.CodeMirror').remove()
        container.find('.codeedit').val data
        container.find('.codeedit').parent().addClass('in')
        $(".treasure_snippets_code > textarea.text").each ->
            c = CodeMirror.fromTextArea this,
                lineNumbers: true,
                tabSize: 2
            c.on "change", (cm, change) ->
              cm.save()


    else
      reopen = true

  codepick.on "typeahead:closed", ->
    if reopen
      reopen = false
      withSlash = $(this).typeahead('val') + '/'
      $(this).typeahead('val', withSlash)
      $that = $(this)
      setTimeout ->
        $that.data('ttTypeahead').dropdown.update(withSlash)
        $that.data('ttTypeahead').dropdown.open()
      , 100
  $('.codepicker').keypress (e)->
    if (e.which == 13)
      e.preventDefault();
      return false;
  $(".treasure_snippets_code > textarea.text").each () ->
    textarea = $(this)
    if ($(this).siblings(".CodeMirror").length == 0)
      c = CodeMirror.fromTextArea this,	lineNumbers: true, tabSize: 2
      c.on "change", (cm, change) ->
        cm.save()






$(document).ready codepicker
$(document).on 'page:load', codepicker
$(document).on 'cocoon:after-insert', codepicker
