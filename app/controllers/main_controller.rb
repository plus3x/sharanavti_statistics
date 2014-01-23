class MainController < ApplicationController
  
  # GET /
  def index
    @chart = Chart.basic_line_chart
  	begin
      @sharics = Chart.statistic(Time.now, Time.now + 4.hours)
    rescue
      @sharics = nil
    end
  end
end
