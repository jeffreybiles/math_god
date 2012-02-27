class CreateRequirements < ActiveRecord::Migration
  def change
    create_table :requirements do |t|
      t.integer :storylet_id
      t.integer :quality_id
      t.integer :min_level
      t.integer :max_level

      t.timestamps
    end
  end
end
