class MainController < ApplicationController
  
  # GET /
  def index
  	begin
      @game_online = Chart.game_online(Time.now, Time.now + 4.hours)
    rescue
      @game_online = nil
    end
    @dynamic = Chart.dynamic
  end

  # GET /new_dot
  def new_dot
    @people = Statistic.new_dot
    render json: {x: Time.now, y: @people}
  end
end
