class PlayerLogsController < ApplicationController
  load_and_authorize_resource

  def current_player_logs
    @player_logs = PlayerLog.order('created_at DESC').find_all_by_user_id(params[:id] || current_user.id)

    render 'player_logs/index'
  end

  make_resourceful do
    actions :show, :destroy
  end

  def index
    @search = PlayerLog.search(params[:search])
    @player_logs = @search.all
  end

  def special_storylets
    @player_logs =  PlayerLog.order('created_at DESC').find_all_by_user_id(params[:id]|| current_user.id)
    @special_player_logs = @player_logs.find_all{|player_log| player_log.storylet.special}

    render 'player_logs/special_storylets'
  end

  def storylet_show
    @log = PlayerLog.find(params[:id])
    @storylet = @log.storylet

    render 'player_logs/storylet'
  end
end
