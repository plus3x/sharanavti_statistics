class Chart

  # OPTIMIZE - move java script to assets(chart.js.coffee)
  def self.game_online
    from = 24.hours.ago
    to   = Time.now

    game_online = API.game_online_select(from: from, to: to)

    return nil unless game_online

    data = []
    game_online.each_with_index { |online, i| data << [ ((from.to_i + i.minutes.to_i) * 1000), online ] }

    LazyHighCharts::HighChart.new :game_online do |f|
      f.chart type: :area,
              zoom_type: :x,
              animation: 'Highcharts.svg',
              events: {
                load: %|
                    function() {
                      var series = this.series[0],
                          chart = this,
                          color = '#0a0',
                          series_length = series.points.length,
                          last_point    = series.points[series_length - 1],
                          latest_point  = series.points[series_length - 2],
                          difference = last_point.y - latest_point.y;

                      // Update currency
                      if (difference < 0) { color = '#c00'; }
                      $("#current").text( last_point.y );
                      $("#difference").text( difference );
                      $("#difference").css({ color: color });

                      // Mark last point
                      last_point.update({ marker: { enabled: true  } });

                      setInterval(function() {
                        color = '#0a0';
                        difference = 0;

                        $.getJSON("/new_dot" )
                          .fail( function() { console.log("API not response!"); } )
                          .done( function( y ) {
                            // // iso8601 to integer(time)
                            // var date = new Date();
                            // date = Date(new_point.x);
                            // var x = new Date(date).getTime();

                            x = (new Date()).getTime();

                            series.addPoint([ x, y ]);

                            series_length = series.points.length;
                            last_point    = series.points[series_length - 1];
                            latest_point  = series.points[series_length - 2];

                            latest_point.update({ marker: { enabled: false } });
                              last_point.update({ marker: { enabled:  true } });

                            // Update currency
                            difference = last_point.y - latest_point.y;
                            if (difference < 0) { color = '#c00'; }
                            $("#current").text( last_point.y );
                            $("#difference").text( difference );
                            $("#difference").css({ color: color });
                          });
                      }, #{1.minute * 1000});
                    }|.js_code
              }

      f.title text: 'Статистика количества игроков в игре Шаранавты', x: -20
      f.subtitle text: 'За последние сутки!', x: -20

      f.xAxis type: :datetime, tick_interval: 30.minutes * 1000
      f.yAxis title: {text: 'Количество шариков'}, plot_lines: [ value: 0, width: 1, color: '#808080']

      f.tooltip value_suffix: ' шарик(ов)'
      f.legend enabled: false

      f.series name: 'Шарики', data: data, color: '#09f'
      f.plot_options area: {
                  fill_color: { linear_gradient: { x1: 0, y1: 0, x2: 0, y2: 1}, stops: [[0, '#09f'],[1, '#0df']] },
                  line_width: 1,
                  marker: { fillColor: "#93c", radius: 6, enabled: false },
                  shadow: false,
                  states: { hover: { line_width: 1 } },
                  threshold: nil
              }
    end
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
      f.chart type: :area, zoom_type: :x,
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
      f.yAxis title: {text: 'Количество шариков'}, plot_lines: [ value: 0, width: 1, color: '#808080']

      f.tooltip value_suffix: ' шарик(ов)'
      f.legend enabled: false

      f.series name: 'Шарики', data: data, color: '#09f'
      f.plot_options area: {
                  fill_color: { linear_gradient: { x1: 0, y1: 0, x2: 0, y2: 1}, stops: [[0, '#09f'],[1, '#0df']] },
                  line_width: 1,
                  marker: { fillColor: "#93c", radius: 6, enabled: false },
                  shadow: false,
                  states: { hover: { line_width: 1 } },
                  threshold: nil
              }
    end
  end
end