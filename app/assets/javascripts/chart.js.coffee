# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

$ ->
  get_game_online_thread = ()->
    chart = $('#highchart_game_online').highcharts()
    series = chart.series[0]
    series_length = series.points.length
    last_point    = series.points[series_length - 1]
    latest_point  = series.points[series_length - 2]

    # Update currency
    difference = last_point.y - latest_point.y
    if difference < 0
      color = '#c00'
    else
      color = '#0a0'
    $('#current').text last_point.y
    $('#difference').text difference
    $('#difference').css color: color

    # Mark last point
    last_point.update { marker: { enabled: true } }

    setInterval (->
      $.post '/charts/new_dot'
        .fail ->
          console.log 'Нет данных от сайта!'
        .done (y)->
          x = (new Date()).getTime() + 4 * 60 * 60 * 1000

          series.addPoint [x, y]

          series_length = series.points.length
          last_point    = series.points[series_length - 1]
          latest_point  = series.points[series_length - 2]

          latest_point.update { marker: { enabled: false } }
          last_point.update   { marker: { enabled: true  } }

          # Update currency
          difference = last_point.y - latest_point.y
          if difference < 0
            color = '#c00'
          else
            color = '#0a0'
          $('#current').text last_point.y
          $('#difference').text difference
          $('#difference').css color: color
    ), 5 * 1000

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
        subtitle: { text: 'Date: ', x: -20 }

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
