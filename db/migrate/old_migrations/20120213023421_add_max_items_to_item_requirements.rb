class AddMaxItemsToItemRequirements < ActiveRecord::Migration
  def change
    add_column :item_requirements, :max_items, :integer
  end
end
