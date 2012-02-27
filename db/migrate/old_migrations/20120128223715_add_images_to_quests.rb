class AddImagesToQuests < ActiveRecord::Migration
  def change
    add_column :quests, :front_image_id, :integer
    add_column :quests, :choices_image_id, :integer
  end
end
