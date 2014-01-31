class MainController < ApplicationController
  
  # GET /
  def index
    @game_online = Chart.game_online( 24.hours.ago, Time.now )
  end
end
