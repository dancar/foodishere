# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://jashkenas.github.com/coffee-script/
arrived = (div) ->
  id = parseInt(this.id.substring("rest_".length))
  rest = window.restData[id]
  $("#confirmName").text(rest.name)
  $("#confirmImg").attr("src", rest.imgSrc)
  $("#tableContainer").hide()
  $("#rest_id").attr("value", id)
  if rest.announced_recently
     $("#confirmAlert").show()
  else
    $("#confirmAlert").hide()
  $("#confirmScreen").show()

confirmCancel = () ->
  $("#tableContainer").show()
  $("#confirmScreen").hide()


filter = () ->
  console.log "ok"

$(document).ready ->
  $(".restRow").hover( ->
    $(this).addClass("restHover")
  , ->
    $(this).removeClass("restHover")
  )
  $(".restRow").click arrived
  $("#confirmCancel").click confirmCancel
  # $("#filter").oninput filter
