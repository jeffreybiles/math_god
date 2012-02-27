class AddImagesToAllTheNewStuff < ActiveRecord::Migration
  def change
    add_column :storylets, :preview_image_id, :integer
    add_column :storylets, :action_image_id, :integer
    add_column :storylets, :success_image_id, :integer
    add_column :storylets, :failure_image_id, :integer

    add_column :qualities, :image_id, :integer
  end
end
