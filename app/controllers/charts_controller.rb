class ChartsController < ApplicationController

  # GET /on_date
  def on_date
    @game_online_select = Chart.game_online_select_date(Date.current)
    @date = Date.current
  end

  # GET /charts/game_online
  def game_online
    from = Date.today.beginning_of_day
    to   = Time.now
  	game_online = API.game_online_select from: from, to: to
    @data = []
    game_online.each_with_index { |online, i| @data << [ ((from.to_i + i.minutes.to_i) * 1000), online ] }
  	render json: @data
  end

  # GET /charts/game_online_select?date=2013-12-01
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