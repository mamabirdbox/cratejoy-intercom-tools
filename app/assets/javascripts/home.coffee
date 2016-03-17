# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/
$ ->
  failureActions = (button) ->
    button.toggleClass('active')
    button.prop("disabled", false)
    button.removeClass('btn-success-outline')
    button.addClass('btn-danger-outline')
    button.text('Select a box')
  $('form[id*="edit_order_"').on "submit", (e) ->
    e.preventDefault()
    $this = $(this)
    $button = $this.siblings('.actions').children('button').first()
    $button.toggleClass('active')
    $button.prop("disabled", true)
    data = $(this).serialize()
    $.ajax({
      type: "POST",
      url: "/order.json",
      data: data,
      dataType: "JSON"
    }).success (json) ->
      if(json.status == "ok")
        $this.parent().fadeOut()
      else
        failureActions($button)
    .error (json) ->
      failureActions($button)

