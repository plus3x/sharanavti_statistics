# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

$(document).on 'ready page:load', ->
  one_minute = 60 * 1000

  highchart_game_online_exist = ->
    $('#highchart_game_online').length > 0

  mark_last_point = ( latest_point, last_point )->
    latest_point.update { marker: { enabled: false } }
    last_point.update   { marker: { enabled: true  } }

  update_currency = ( latest_point, last_point )->
    difference = last_point.y - latest_point.y
    if difference < 0
      color = '#c00'
    else
      color = '#0a0'
    $('#current').text last_point.y
    $('#difference').text difference
    $('#difference').css color: color

  mark_last_point_and_update_currency = ( series )->
    series_length = series.points.length
    last_point    = series.points[series_length - 1]
    latest_point  = series.points[series_length - 2]

    mark_last_point( latest_point, last_point )
    update_currency( latest_point, last_point )

  get_game_online_thread = ()->
    chart = $('#highchart_game_online').highcharts()
    series = chart.series[0]

    mark_last_point_and_update_currency( series )

    setInterval (->
      $.post '/charts/new_point'
        .fail ->
          console.log 'Нет данных от сайта!'
        .done (new_point)->
          series.addPoint [new_point.x, new_point.y]

          mark_last_point_and_update_currency( series )
    ), one_minute

  if highchart_game_online_exist
    $.getJSON '/charts/game_online'
      .fail ->
        $('#highchart_game_online').text 'Нет данных от сайта!'
      .done (data)->
        $('#highchart_game_online').highcharts(
          chart:
            type: 'area'
            zoomType: 'x'
            height: 750
            events: { load: get_game_online_thread }

          title:    { text: 'Статистика количества игроков в игре Шаранавты', x: -20 }
          subtitle: { text: 'Online', x: -20 }

          xAxis: { type: 'datetime', tickInterval: 30 * 60 * 1000 }
          yAxis: { title: {text: 'Количество шариков'}, plotLines: [ value: 0, width: 1, color: '#808080'], min: 0 }

          tooltip: { valueSuffix: ' шарик(ов)' }
          legend:  { enabled: false }
          credits: { enabled: false }
          exporting: { filename: 'game_online' }
          lang: { noData: 'Нет данных из API!' }
          noData: { style: { fontWeight: 'bold', fontSize: '15px', color: '#303030' } }

          series: [{ name: 'Шарики', data: data, color: '#09f' }]

          plotOptions:
            area:
              fillColor: { linearGradient: { x1: 0, y1: 0, x2: 0, y2: 1}, stops: [[0, '#09f'],[1, '#0df']] }
              lineWidth: 1
              marker: { symbol: 'circle', fillColor: '#93c', radius: 6, enabled: false }
              shadow: false
              states: { hover: { lineWidth: 1 } }
              threshold: null
        )
