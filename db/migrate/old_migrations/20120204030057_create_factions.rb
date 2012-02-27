class CreateFactions < ActiveRecord::Migration
  def change
    create_table :factions do |t|
      t.string :name
      t.string :description
      t.integer :creator_id
      t.integer :image_id

      t.timestamps
    end
  end
end
