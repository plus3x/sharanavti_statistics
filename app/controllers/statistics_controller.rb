class StatisticsController < ApplicationController

  # GET /new_dot
  def new_dot
    @dot = API.game_online_dot
    render json: @dot
  end

  # GET /game_online
  def game_online
  	@game_online = API.game_online_select( 12.hours.ago, Time.now )
    render json: @game_online
  end
end