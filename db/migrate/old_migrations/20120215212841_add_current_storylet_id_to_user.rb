class AddCurrentStoryletIdToUser < ActiveRecord::Migration
  def change
    add_column :users, :current_storylet_id, :integer
  end
end
