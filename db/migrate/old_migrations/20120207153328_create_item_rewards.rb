class CreateItemRewards < ActiveRecord::Migration
  def change
    create_table :item_rewards do |t|
      t.integer :item_id
      t.integer :choice_id
      t.integer :number_awarded

      t.timestamps
    end
  end
end
