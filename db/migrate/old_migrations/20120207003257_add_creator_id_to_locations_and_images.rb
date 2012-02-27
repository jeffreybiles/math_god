class AddCreatorIdToLocationsAndImages < ActiveRecord::Migration
  def change
    add_column :locations, :creator_id, :integer
    add_column :images, :creator_id, :integer
  end
end
