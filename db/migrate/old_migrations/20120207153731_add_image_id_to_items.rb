class AddImageIdToItems < ActiveRecord::Migration
  def change
    add_column :items, :image_id, :integer
  end
end
