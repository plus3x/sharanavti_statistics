class MainController < ApplicationController
  
  # GET /
  def index
    @chart = Chart.basic_line_chart
  end
end
