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
end
