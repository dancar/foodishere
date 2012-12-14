# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://jashkenas.github.com/coffee-script/
#
last_filter = ""

arrived = (div) ->
  id = parse_row_id(this)
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

parse_row_id = (row) ->
  parseInt(row.id.match(/rest_([\d]+)/)[1])

invoke_filtering = () ->
  filter_text = $("#filter").val()
  return if filter_text == last_filter
  console.log "filtering #{last_filter}"
  for id, rest of window.restData
    pass = filter(filter_text, rest.name)
    func = if pass then "show" else "hide"
    $(rest.row)[func]()
  last_filter = filter_text

filter = (filter_text, rest_name) ->
  # "fuzzy" fuzzy matching: true iff all chars from filter_text are somewhere in rest_name (=orderly, but not consequently)
  pos = -1
  for char, index in filter_text.split("")
    pos = rest_name.indexOf(char, pos + 1)
    return false if pos == -1
  true

$(document).ready ->
  $(".restRow").hover( ->
    $(this).addClass("restHover")
  , ->
    $(this).removeClass("restHover")
  )

  # Find all rest rows and bind them
  $(".restRow").each (index, row) ->
    $(row).click arrived
    rest_id = parse_row_id(row)
    window.restData[rest_id].row = row
  $("#confirmCancel").click confirmCancel
  setInterval invoke_filtering, 500
