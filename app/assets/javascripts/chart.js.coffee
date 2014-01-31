# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/


# Globalized function for HighChart

# @after_load_online_updating = after_load_online_updating = ()->


#   console.log "this" + this
#   console.log "game_online text" + $('game_online').text()

#   chart = $('#game_online').highcharts()
#   series = chart.series[0]

#   console.log "chart series data length: " + chart.series[0].data.length

#   series_length = series.points.length
#   last_point = series.points[series_length - 1]
#   latest_point = series.points[series_length - 2]

#   # Update currency
#   difference = last_point.y - latest_point.y
#   if difference < 0
#     color = '#c00'
#   else
#     color = '#0a0'
#   $('#current').text last_point.y
#   $('#difference').text difference
#   $('#difference').css color: color

#   # Mark last point
#   last_point.update { marker: { enabled: true } }

#   setInterval (->
#     $.getJSON('/new_dot')
#       .fail ->
#         console.log 'Site not response!'
#       .done (y) ->
#         x = (new Date()).getTime()

#         series.addPoint [x, y]

#         series_length = series.points.length
#         last_point = series.points[series_length - 1]
#         latest_point = series.points[series_length - 2]

#         latest_point.update { marker: { enabled: false } }
#         last_point.update { marker: { enabled: true } }

#         # Update currency
#         difference = last_point.y - latest_point.y
#         if difference < 0
#           color = '#c00'
#         else
#           color = '#0a0'
#         $('#current').text last_point.y
#         $('#difference').text difference
#         $('#difference').css color: color
#   ), 60 * 1000