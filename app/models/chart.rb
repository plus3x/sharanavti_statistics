class Chart
  def self.game_online(from, to)
    people_on_game = Statistic.select(from: from, to: to)
    
    if people_on_game
      game_online = []
      people_on_game.each_with_index { |people, index| game_online << {x: (from + 1.minutes * index).to_i * 1000, y: people} }

      LazyHighCharts::HighChart.new do |f|
        f.chart type: :area, animation: 'Highcharts.svg',
                events: {
                  load: %|function() {
                          var series = this.series[0];
                          setInterval(function() {
                              var x = (new Date()).getTime(), // current time
                                  y = Math.random() * 180 + 20;
                              series.addPoint([x, y], true, true);
                          }, 60000); // 1 minute
                      }|.js_code
                }

        f.title    text: 'Статистика количества игроков в игре Шаранавты', x: -20
        f.subtitle text: "Онлайн #{game_online[-1][:y]} шарик(ов). За последнее время пришло #{game_online[-1][:y]-game_online[-2][:y]}", x: -20

        f.xAxis type: :datetime, tickInterval: 1.hour.to_i * 1000
        f.yAxis title: {text: 'Количество шариков'}, plot_lines: [{ value: 0, width: 1, color: '#808080'}]

        f.tooltip value_suffix: ' шарик(ов)'
        f.legend enabled: false

        f.series name: 'Шарики', data: game_online
      end
    else
      nil
    end
  end

  def self.dynamic
    from = Time.now - 2.hours
    to = Time.now

    people_on_game = Statistic.select(from: from, to: to)
    if people_on_game
      game_online = []
      people_on_game.each_with_index { |people, index| game_online << {x: (from + 1.minutes * index).to_i * 1000, y: people} }

      LazyHighCharts::HighChart.new do |f|
        f.chart type: :area,
                animation: 'Highcharts.svg',
                events: {
                  load: %|
                      function() {
                        var series = this.series[0];
                        setInterval(function() {
                          var x = (new Date()).getTime(), // current time
                              y = Math.random() * 180 + 20;
                          $.getJSON("/new_dot", function(data) {
                            y = 5; // change 5 to 'data'!!!
                          });
                          series.addPoint([x, y], true, true);
                        }, 60000); // 1 minute
                      }|.js_code
                }

        f.title    text: 'Статистика количества игроков в игре Шаранавты', x: -20
        f.subtitle text: "Онлайн #{game_online[-1][:y]} шарик(ов). За последнее время пришло #{game_online[-1][:y]-game_online[-2][:y]}", x: -20

        f.xAxis type: :datetime, tickInterval: 1.hour.to_i * 1000
        f.yAxis title: {text: 'Количество шариков'}, plot_lines: [{ value: 0, width: 1, color: '#808080'}]

        f.tooltip value_suffix: ' шарик(ов)'
        f.legend enabled: false

        f.series name: 'Шарики', data: game_online
      end
    else
      nil
    end
  end
end