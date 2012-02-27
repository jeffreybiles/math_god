class AddImagesToChoices < ActiveRecord::Migration
  def change
    add_column :choices, :choice_image_id, :integer
    add_column :choices, :success_image_id, :integer
    add_column :choices, :failure_image_id, :integer

    add_column :gods, :image_id, :integer
  end
end
