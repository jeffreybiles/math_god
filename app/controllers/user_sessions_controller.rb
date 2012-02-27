class UserSessionsController < ApplicationController
  load_and_authorize_resource

  def intro_page
     render 'layouts/home'
  end

  def new
    @user_session = UserSession.new
  end

  def create
    @user_session = UserSession.new(params[:user_session])
    if @user_session.save
      redirect_to "/storylets/#{last_log.storylet_id}/#{last_log_status}/#{log_code}"
    else
      flash[:notice] = "Didn't work a wink.'"
      render :new
    end
  end

  def destroy
    current_user_session.destroy
    redirect_to new_user_session_path
  end
end
