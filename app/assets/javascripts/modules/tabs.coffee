deactivate_input = ->
  $('a[data-toggle="tab"]').on 'shown.bs.tab', (e) ->
    $('.deactivatable').attr('disabled', 'true')
    $('.active .deactivatable').removeAttr('disabled')


$(document).ready deactivate_input
$(document).on 'page:load', deactivate_input
$(document).on 'cocoon:after-insert', deactivate_input
