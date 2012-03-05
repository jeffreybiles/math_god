class UsersController < ApplicationController
  load_and_authorize_resource

  make_resourceful do
    actions :edit, :destroy, :index, :show
  end

  def new
    current_user_session.destroy if current_user_session

    @user = User.new
  end

  def create
    @user = User.new(params[:user])

    @user.player= true

     if @user.save
        @storylet = Storylet.find_by_title('Zeroth storylet')
        PlayerLog.create(user: @user, storylet_id: @storylet.id)
        update_permissions(params)
        @user.offer_code= ''
        @user.save
        render 'storylets/success'
      else
        render action: "new"
      end
  end

  def update
    @user = User.find(params[:id]) || current_user

    sign_in @user, :bypass => true
    @user.update_without_password(params[:user])
    @user.update_permissions(params[:user])
    @user.offer_code= ''
    @user.save!

    redirect_to @user
  end


end
