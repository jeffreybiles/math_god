class CreateBlessings < ActiveRecord::Migration
  def change
    create_table :blessings do |t|
      t.integer :user_id
      t.integer :god_id
      t.integer :level
      t.decimal :exp_to_level

      t.timestamps
    end

    add_index :blessings, :user_id
    add_index :blessings, :god_id
    add_index :blessings, [:user_id, :god_id], unique: true
  end
end
