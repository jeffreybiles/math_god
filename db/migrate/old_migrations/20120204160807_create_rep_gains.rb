class CreateRepGains < ActiveRecord::Migration
  def change
    create_table :rep_gains do |t|
      t.integer :consequences_id
      t.integer :faction_id
      t.decimal :rep_gained

      t.timestamps
    end
  end
end
