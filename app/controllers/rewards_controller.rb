class RewardsController < ApplicationController
  load_and_authorize_resource

  make_resourceful do
    actions :all
  end
end
