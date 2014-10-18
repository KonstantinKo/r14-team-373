$(document).ready ->
  $('#tags').tagit(
    tagSource: (search, showChoices) ->
      that = this
      $.ajax
        url: "/tags/autocomplete.json",
        data:
          q: search.term
        success: (choices) ->
          showChoices that._subtractArray(choices, that.assignedTags())
    tagLimit: 5
    singleField: true
    singleFieldNode: $('[name="treasure[tag_list]"]')
    placeholderText: 'Give us a few tags.'
  ).children('li').children('input').attr(
    class: "form-control"
  )