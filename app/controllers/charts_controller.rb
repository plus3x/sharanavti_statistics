class ChartsController < ApplicationController
  
  # GET /game_online
  def game_online
    @game_online = Chart.game_online
  end

  # GET /new_dot
  def new_dot
    @dot = Statistic.new_dot
    render json: @dot
  end
end