class CreateLinks < ActiveRecord::Migration
  def change
    create_table :links do |t|
      t.integer :previous_id
      t.integer :next_id
      t.boolean :on_success
      t.boolean :on_failure
      t.string :extra_text

      t.timestamps
    end
  end
end
