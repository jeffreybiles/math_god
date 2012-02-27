class CreateReputations < ActiveRecord::Migration
  def change
    create_table :reputations do |t|
      t.integer :user_id
      t.integer :faction_id
      t.integer :level
      t.decimal :exp_to_level
      t.decimal :exp_to_delevel

      t.timestamps
    end
  end
end
