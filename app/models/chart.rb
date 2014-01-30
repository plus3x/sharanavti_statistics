class Chart
  def self.game_online
    from = 16.hours.ago # Date.today.beginning_of_day
    to   = Time.now

    people_on_game = Statistic.select(from: from, to: to)

    return nil unless people_on_game

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
                      var current_time = (new Date()).getTime();

                      last_point.update({ marker: { enabled: true  } });

                      console.log("New mark, new draw,last_point.y " + last_point.y);

                      setInterval(function() {
                        var x = (new Date()).getTime(), // current time
                        color = '#0a0';
                        difference = 0;

                        $.getJSON("/new_dot", function(new_point) {
                          series.addPoint([x , new_point]);

                          series_length = series.points.length;
                          last_point    = series.points[series_length - 1];
                          latest_point  = series.points[series_length - 2];

                          latest_point.update({ marker: { enabled: false } });
                            last_point.update({ marker: { enabled:  true } });

                          difference = last_point.y - latest_point.y;
                          if (difference < 0) { color = '#c00'; }

                          console.log( "New point: " + new_point + "(difference = " + difference + ", color = " + color + ")" );

                          $("#current").text( last_point.y );
                          $("#difference").text( difference );
                          $("#difference").css({ color: color });
                        });
                      }, #{20.seconds * 1000}); // 20 seconds
                    }|.js_code
              }

      f.title text: 'Статистика количества игроков в игре Шаранавты', x: -20

      f.xAxis type: :datetime, tick_interval: 1.hour.to_i / 2 * 1000
      f.yAxis title: {text: 'Количество шариков'}, plot_lines: [ value: 0, width: 1, color: '#808080']

      f.tooltip value_suffix: ' шарик(ов)'
      f.legend enabled: false

      f.series name: 'Шарики', data: people_on_game, color: '#09f'
      f.plot_options area: {
                  fill_color: { linear_gradient: { x1: 0, y1: 0, x2: 0, y2: 1}, stops: [[0, '#09f'],[1, '#0df']] },
                  line_width: 1,
                  marker: {
                    fillColor: "#93c",
                    radius: 6,
                    enabled: false
                  },
                  shadow: false,
                  states: { hover: { line_width: 1 } },
                  threshold: nil
              }
    end
  end

  def self.dynamic # all works!
    from = 16.hours.ago # Date.today.beginning_of_day
    to   = Time.now     # Date.today.end_of_day

    people_on_game = Statistic.select(from: from, to: to)

    return nil unless people_on_game
    
    game_online = []
    people_on_game.each_with_index { |people, index| game_online << {x: (from + 1.minutes * index).to_i * 1000, y: people} }

    LazyHighCharts::HighChart.new do |f|
      f.chart type: :area,
              zoom_type: :x,
              animation: 'Highcharts.svg',
              events: {
                load: %|
                    function() {
                      var series = this.series[0];
                      setInterval(function() {
                        var x = (new Date()).getTime(); // current time
                        $.getJSON("/new_dot", function(dot) {
                          series.addPoint([x , dot], true, true);
                        });
                      }, #{1.minute * 1000}); // 1 minute
                    }|.js_code
              }
      f.title    text: 'Статистика количества игроков в игре Шаранавты', x: -20
      f.subtitle text: "Онлайн #{game_online[-1][:y]} шарик(ов). За последнее время пришло #{game_online[-1][:y]-game_online[-2][:y]}", x: -20

      f.xAxis type: :datetime, tick_interval: 1.hour.to_i / 2 * 1000
      f.yAxis title: {text: 'Количество шариков'}, plot_lines: [{ value: 0, width: 1, color: '#808080'}]

      f.tooltip value_suffix: ' шарик(ов)'
      f.legend enabled: false

      f.series name: 'Шарики', data: game_online, color: '#09f'
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