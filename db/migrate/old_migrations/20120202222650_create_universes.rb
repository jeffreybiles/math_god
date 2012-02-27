class CreateUniverses < ActiveRecord::Migration
  def change
    create_table :universes do |t|
      t.string :name
      t.string :focus
      t.integer :god_id
      t.string :description

      t.timestamps
    end
  end
end
