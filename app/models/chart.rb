class Chart
  def self.game_online(from, to)
    people_on_game = Statistic.select(from: from, to: to)
    game_online = []
    people_on_game.each_with_index { |people, index| game_online << [(from + 1.minutes * index).to_i * 1000, people] }
    
    LazyHighCharts::HighChart.new do |f|
      f.chart type: :area#, animation: 'Highcharts.svg', events: { load: js_set_interval }

      f.title    text: 'Статистика количества игроков в игре Шаранавты', x: -20
      f.subtitle text: "Онлайн #{game_online[-1][1]} шарик(ов). За последнее время пришло #{game_online[-1][1]-game_online[-2][1]}", x: -20

      f.xAxis type: :datetime, tickInterval: 1.hour.to_i * 1000
      f.yAxis title: {text: 'Количество шариков'}, plot_lines: [{ value: 0, width: 1, color: '#808080'}]

      f.tooltip value_suffix: ' шарик(ов)'

      f.legend layout: :vertical, align: :right, verticalAlign: :top, x: -10, y: 100, borderWidth: 0

      f.series name: 'Шарики', data: game_online
    end
  end

  def js_set_integval
    %| function() {
      // set up the updating of the chart each second
      var series = this.series[0];
      setInterval(function() {
        var x = (new Date()).getTime(), // current time
            y = Math.random();
        series.addPoint([x,y],true,true);
      }, 1000);
    }|.js_code
  end

  def js_set_interval_with_get_json
    %| function() {
      series = this.series[0];
      setInterval(function() {
        x = (new Date()).getTime() // current time
        $.getJSON("/get_new_dot, function(data) {
            y = data;
          }
        });
        series.addPoint([x, y], true, true);
      }, 1000); // 1 second
    }|.js_code
  end

  def self.dynamic
    from = Time.now - 2.hours
    to = Time.now

    people_on_game = Statistic.select(from: from, to: to)
    game_online = []
    people_on_game.each_with_index { |people, index| game_online << {x: (from + 1.minutes * index).to_i * 1000, y: people} }

    LazyHighCharts::HighChart.new do |f|
      f.chart type: :area, 
              animation: 'Highcharts.svg', 
              marginRight: 10, 
              events: { 
                load: %|function() {
                        // set up the updating of the chart each second
                        var series = this.series[0];
                        setInterval(function() {
                            var x = (new Date()).getTime(), // current time
                                y = Math.random() * 180 + 20;
                            series.addPoint([x, y], true, true);
                        }, 60000);
                    }|.js_code
              }

      f.title text: 'Live random data'

      f.xAxis type: :datetime, tickInterval: 1.hour * 1000
      f.yAxis title: {text: 'шарики'}, plot_lines: [{ value: 0, width: 1, color: '#808080'}]

      f.tooltip value_suffix: ' шарик(ов)'

      f.legend enabled: false
      f.exporting enabled: false

      f.series name: 'Онлайн', data: game_online
    end
  end
end