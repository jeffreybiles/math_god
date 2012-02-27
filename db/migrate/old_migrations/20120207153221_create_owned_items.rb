class CreateOwnedItems < ActiveRecord::Migration
  def change
    create_table :owned_items do |t|
      t.integer :item_id
      t.integer :user_id
      t.integer :number_owned

      t.timestamps
    end
  end
end
