# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

$ ->
  $('#datepicker').datepicker(
    format: 'yyyy-mm-dd'
    endDate: 'today'
    todayBtn: 'linked'
    language: 'ru'
    todayHighlight: true
  )

$(document).on 'ready page:load', ->

  highchart_game_online_on_date_exist = ->
    $('#highchart_game_online_on_date').length > 0

  if highchart_game_online_on_date_exist
    $.getJSON '/charts/on_date.json'
      .fail ->
        $('#highchart_game_online_on_date').text 'Нет данных от сайта!'
      .done ( data )->
        $('#highchart_game_online_on_date').highcharts(
          chart:
            type: 'area'
            zoomType: 'x'
            height: 750
            events:
              load: ->
                $('#average').text data.average
                $('#max').text data.max
                $('#min').text data.min

          title: { text: 'Статистика количества игроков в игре Шаранавты', x: -20 }
          # subtitle: { text: 'Date: ', x: -20 }

          xAxis: { type: 'datetime', tickInterval: 30 * 60 * 1000 }
          yAxis: { title: {text: 'Количество шариков'}, plotLines: [ value: 0, width: 1, color: '#808080'], min: 0 }

          tooltip: { valueSuffix: ' шарик(ов)' }
          legend:  { enabled: false }
          credits: { enabled: false }
          exporting: { filename: 'game_online' }
          lang: { noData: 'Нет данных из API!' }
          noData: { style: { fontWeight: 'bold', fontSize: '15px', color: '#303030' } }

          series: [{ name: 'Шарики', data: data.points, color: '#09f', animation: false }]

          plotOptions:
            area:
              fillColor: { linearGradient: { x1: 0, y1: 0, x2: 0, y2: 1}, stops: [[0, '#09f'],[1, '#0df']] }
              lineWidth: 1
              marker: { enabled: false }
              shadow: false
              states: { hover: { lineWidth: 1 } }
              threshold: null
        )
