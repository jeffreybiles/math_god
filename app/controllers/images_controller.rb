class ImagesController < ApplicationController
  load_and_authorize_resource

  make_resourceful do
    actions :show, :new, :create, :destroy, :update, :edit
  end

  def index
    @search = Image.search(params[:search])
    @images = @search.all
  end

  def unfinished_business
    @images = Image.find_all_by_picture(nil)

    @qualities_without_pictures = Quality.find_all_by_image_id(nil)

    @storylets_without_pictures = Storylet.find_all_by_preview_image_id(nil)
    @storylets_without_pictures |= (Storylet.find_all_by_success_image_id(nil))

    @storylets_with_notes = Storylet.where("notes != ?", '')

    render 'application/unfinished_business'
  end
end
