class MainController < ApplicationController
  
  # GET /
  def index
    @game_online = Chart.game_online
  end
end
