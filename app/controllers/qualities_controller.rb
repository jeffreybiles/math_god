class QualitiesController < ApplicationController
  load_and_authorize_resource

  make_resourceful do
    actions :show, :new, :create, :destroy, :update, :edit
  end

  def index
    @search = Quality.search(params[:search])
    @qualities = @search.all
  end
end
