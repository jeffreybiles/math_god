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
end
