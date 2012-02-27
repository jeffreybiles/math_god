class CreateGods < ActiveRecord::Migration
  def change
    create_table :gods do |t|
      t.string :name
      t.string :description
      t.integer :max_level

      t.timestamps
    end
  end
end
