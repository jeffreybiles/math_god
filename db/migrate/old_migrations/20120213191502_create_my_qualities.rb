class CreateMyQualities < ActiveRecord::Migration
  def change
    create_table :my_qualities do |t|
      t.integer :quality_id
      t.integer :user_id
      t.integer :level
      t.decimal :exp

      t.timestamps
    end
  end
end
