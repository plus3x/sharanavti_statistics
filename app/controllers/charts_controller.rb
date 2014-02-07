class ChartsController < ApplicationController

  # GET /on_date
  def on_date
    @game_online_select = Chart.game_online_select_date(Date.current)
    @date = Date.current
  end

  # GET /chart/game_online_select?date=2013-12-01
  def game_online_select
    @date = Date.new(params[:date][:year].to_i, params[:date][:month].to_i, params[:date][:day].to_i)
    @game_online_select = Chart.game_online_select_date( @date )
  end
  
  # POST /new_dot
  def new_dot
    @dot = API.game_online_dot
    render json: @dot
  end
end