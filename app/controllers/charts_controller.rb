class ChartsController < ApplicationController

  # GET /chart/game_online_select?from=&to=
  def game_online_select
    from = params[:from]
    to   = params[:to]
    to = Time.now if params[:to].to_datetime > Time.now
    @game_online = Chart.game_online( from, to )
  end
end