# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/
$ ->
  $('form[id*="edit_order_"').on "submit", (e) ->
    $this = $(this)
    e.preventDefault()
    data = $(this).serialize()
    $.ajax({
      type: "POST",
      url: "/order.json",
      data: data,
      dataType: "JSON"
    }).success (json) ->
      if(json.status == "ok")
        $this.siblings('.actions').children('input').first().replaceWith('<span class="label label-primary">Updated</span>')
