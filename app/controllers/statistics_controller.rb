class StatisticsController < ApplicationController

  # GET /new_dot
  def new_dot
    @dot = Statistic.new_dot
    render json: @dot
  end

  # GET /game_online
  def game_online
  	@game_online = Statistic.game_online
    render json: @game_online
  end
end