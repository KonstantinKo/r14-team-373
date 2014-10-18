$(document).ready ->
  $('#mytags').tagit(
    tagSource: (search, showChoices) ->
      that = this
      $.ajax
        url: "/tags/autocomplete.json",
        data:
          q: search.term
        success: (choices) ->
          showChoices that._subtractArray(choices, that.assignedTags())
    show_tag_url: '/tags/'
    singleField: true
    singleFieldNode: $('#submit_tag_names')
  ).children('li').children('input').addClass "form-control"
