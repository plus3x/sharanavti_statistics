class MainController < ApplicationController
  
  # GET /
  def index
  	begin
      @sharics = Chart.statistic(Time.now, Time.now + 4.hours)
    rescue
      @sharics = nil
    end
  end
end
