class AddImageIdToUser < ActiveRecord::Migration
  def change
    add_column :users, :image_id, :integer
  end
end
