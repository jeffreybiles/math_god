class CreateLocations < ActiveRecord::Migration
  def change
    create_table :locations do |t|
      t.string :name
      t.integer :universe_id
      t.string :description
      t.integer :image_id

      t.timestamps
    end
  end
end
