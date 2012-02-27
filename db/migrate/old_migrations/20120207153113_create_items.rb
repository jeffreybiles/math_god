class CreateItems < ActiveRecord::Migration
  def change
    create_table :items do |t|
      t.string :name
      t.string :description
      t.integer :value
      t.integer :creator_id

      t.timestamps
    end
  end
end
