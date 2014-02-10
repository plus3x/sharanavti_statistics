class ChartsController < ApplicationController

  # GET /on_date
  def on_date
    @game_online_select = Chart.game_online_select_date(Date.current)
    @date = Date.current
  end

  # GET /charts/game_online
  def game_online
    respond_to do |format|
      format.hrml
      format.js { render json: @data = Chart.game_online }
    end
  end

  # GET /charts/game_online_select?date=2013-12-01
  def game_online_select
    @date = Date.new(params[:date][:year].to_i, params[:date][:month].to_i, params[:date][:day].to_i)
    @game_online_select = Chart.game_online_select_date( @date )
  end
  
  # POST /new_point
  def new_point
    dot = API.game_online_dot
    @point = { x: ((Time.now.to_i + Time.now.gmt_offset) * 1000), y: dot }
    render json: @point
  end
end