class Chart
  def self.game_online
    from = Date.today.beginning_of_day
    to   = Time.now
    game_online = API.game_online_select from: from, to: to
    data = []
    game_online.each_with_index { |online, i| data << [ ((from.to_i + i.minutes.to_i) * 1000), online ] }
    date
  end

  def self.game_online_select_date( date )
    from = date.beginning_of_day
    to   = date.end_of_day

    game_online = API.game_online_select( from: from, to: to )

    return nil unless game_online

    data = []
    game_online.each_with_index { |online, i| data << [ ((from.to_i + i.minutes.to_i) * 1000), online ] }

    max_of_day = game_online.max
    min_of_day = game_online.min
    average_of_day = (game_online.sum.to_f / game_online.size) rescue nil

    LazyHighCharts::HighChart.new :game_online do |f|
      f.chart type: :area,
              zoom_type: :x,
              height: 750,
              events: { 
                load: %|
                    function() {
                      // Update currency
                      $("#average").text( #{ "%.2f" % average_of_day} );
                      $("#max").text( #{max_of_day} );
                      $("#min").text( #{min_of_day} );
                    }|.js_code
              }

      f.title text: 'Статистика количества игроков в игре Шаранавты', x: -20
      f.subtitle text: "Date: #{date}.", x: -20

      f.xAxis type: :datetime, tick_interval: 30.minutes * 1000
      f.yAxis title: {text: 'Количество шариков'}, plot_lines: [ value: 0, width: 1, color: '#808080'], min: 0

      f.tooltip value_suffix: ' шарик(ов)'
      f.legend enabled: false

      f.series name: 'Шарики', data: data, color: '#09f', animation: false
      f.plot_options area: {
                  fill_color: { linear_gradient: { x1: 0, y1: 0, x2: 0, y2: 1}, stops: [[0, '#09f'],[1, '#0df']] },
                  line_width: 1,
                  marker: { enabled: false },
                  shadow: false,
                  states: { hover: { line_width: 1 } },
                  threshold: nil
              }
    end
  end
end