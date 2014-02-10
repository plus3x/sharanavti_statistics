class ChartsController < ApplicationController

  # GET /charts/game_online
  def game_online
    respond_to do |format|
      format.html
      format.js { render json: @data = Chart.game_online }
    end
  end

  # GET /on_date
  def on_date
    if date = params[:date]
      @date = Date.new(date[:year].to_i, date[:month].to_i, date[:day].to_i)
    else
      @date = Date.current
    end
    respond_to do |format|
      format.html
      format.json { render json: @data = Chart.game_online_on_date( @date ) }
      format.js   { render nothing: true unless @data = Chart.game_online_on_date( @date ) }
    end
  end

  # POST /new_point
  def new_point
    render json: @point = Chart.new_point
  end
end