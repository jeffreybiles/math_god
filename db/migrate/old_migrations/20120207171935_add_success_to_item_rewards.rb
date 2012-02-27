class AddSuccessToItemRewards < ActiveRecord::Migration
  def change
    add_column :item_rewards, :success, :boolean
  end
end
