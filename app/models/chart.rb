class Chart
  def self.basic_line_chart
    LazyHighCharts::HighChart.new :basic_line do |f|
      f.chart type: :line, marginRight: 130, marginBottom: 25

      f.title text: 'Monthly Average Temperature', x: -20
      f.subtitle text: 'Source: WorldClimate.com', x: -20

      f.xAxis categories: ['Jan', 'Feb', 'Mar', 'Apr', 'May', 'Jun', 'Jul', 'Aug', 'Sep', 'Oct', 'Nov', 'Dec']
      f.yAxis title: {text: 'Temperature (°C)'}, plotLines: [{ value: 0, width: 1, color: '#808080'}]

      f.tooltip valueSuffix: '°C'

      f.legend layout: :vertical, align: :right, verticalAlign: :top, x: -10, y: 100, borderWidth: 0

      f.series name: 'Tokyo',    data: [ 7.0, 6.9, 9.5, 14.5, 18.2, 21.5, 25.2, 26.5, 23.3, 18.3, 13.9, 9.6]
      f.series name: 'New York', data: [-0.2, 0.8, 5.7, 11.3, 17.0, 22.0, 24.8, 24.1, 20.1, 14.1,  8.6, 2.5]
      f.series name: 'Berlin',   data: [-0.9, 0.6, 3.5,  8.4, 13.5, 17.0, 18.6, 17.9, 14.3,  9.0,  3.9, 1.0]
      f.series name: 'London',   data: [ 3.9, 4.2, 5.7,  8.5, 11.9, 15.2, 17.0, 16.6, 14.2, 10.3,  6.6, 4.8]
    end
  end
  
  def self.statistic(from, to)
    people_on_game = Statistic.select(from: from, to: to)
    data = []
    people_on_game.each_with_index { |e,i| data << [(from + 1.minutes * i).to_i, e] }
    
    LazyHighCharts::HighChart.new do |f|
      f.chart type: :area,
              animation: 'Highcharts.svg',
              events: { load: %|
                    function() {
                        // set up the updating of the chart each second
                        var series = this.series[0];
                        setInterval(function() {
                            var x = (new Date()).getTime(), // current time
                                y = Math.random();
                            series.addPoint([x, y], true, true);
                        }, 1000);
                    }|.js_code }
      
      f.title    text: 'Статистика количества игроков в игре Шаранавты', x: -20
      f.subtitle text: "Онлайн #{data[-1][1]} шарик(ов). За последнее время пришло #{data[-1][1]-data[-2][1]}", x: -20

      f.xAxis type: :datetime

      f.yAxis title: {text: 'Количество шариков'}, 
              plot_lines: [{ value: 0, width: 1, color: '#808080'}]
              # { afterSetExtremes:
              #     %|function(e) {
              #       series = this.series[0];
              #       setInterval(function() {
              #         x = (new Date()).getTime() // current time
              #         $.getJSON("/get_new_dot, function(data) {
              #             y = data;
              #           }
              #         });
              #         series.addPoint([x, y], true, true);
              #       }, 60000); // 1 minute
              #     }|.js_code
              #   }

      f.tooltip value_suffix: ' шарик(ов)'

      f.legend layout: :vertical, align: :right, verticalAlign: :top, x: -10, y: 100, borderWidth: 0

      f.series name: 'Шарики', data: data
    end
  end
end