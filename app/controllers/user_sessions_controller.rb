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
      if last_log
        redirect_to "/storylets/#{last_log.storylet_id}/#{last_log_status}/#{log_code}"
      else
        @user = current_user
        @storylet = Storylet.find_by_title('Zeroth storylet')
        PlayerLog.create(user: @user, storylet_id: @storylet.id)
        @user.update_permissions(params)
        @user.offer_code= ''
        @user.save
        render 'storylets/success'
      end
    else
      flash[:notice] = "The gods are not smiling upon your login.'"
      render :new
    end
  end

  def destroy
    current_user_session.destroy
    redirect_to new_user_session_path
  end
end
