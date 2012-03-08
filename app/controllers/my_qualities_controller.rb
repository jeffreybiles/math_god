class MyQualitiesController < ApplicationController
  load_and_authorize_resource
  # GET /my_qualities
  # GET /my_qualities.json

  make_resourceful do
    actions :index, :show, :edit, :new, :create, :destroy
  end

  def my_gods
    if params[:id]
      @user = User.find(params[:id])
    else
      @user = current_user
    end
    @my_qualities = all_my_gods(@user)
  end

  def show_mine
    if params[:id]
      @user = User.find(params[:id])
    else
      @user = current_user
    end
    @my_qualities = @user.my_qualities.joins(:quality).where('quality_type != ? AND quality_type != ? AND name != ?', 'god', 'currency', 'favor')
  end

  def update
    @my_quality = MyQuality.find(params[:id])

    if params[:my_quality][:exp_to_level] != ''
      @storylet = Storylet.find(params[:my_quality][:current_storylet_id])
      #if params[:my_quality][:exp_to_level] == params[:my_quality][:exp_to_delevel]
      if rand <= params[:my_quality][:exp_to_level].to_f
        redirect_to "/storylets/#{@storylet.id}/success/#{log_code}"
      else
        redirect_to "/storylets/#{@storylet.id}/failure/#{log_code}"
      end
    else
      respond_to do |format|
        if @my_quality.update_attributes(params[:my_quality])
          format.html { redirect_to @my_quality, notice: 'My quality was successfully updated.' }
          format.json { head :ok }
        else
          format.html { render action: "edit" }
          format.json { render json: @my_quality.errors, status: :unprocessable_entity }
        end
      end
    end
  end
end
