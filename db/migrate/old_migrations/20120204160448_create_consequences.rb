class CreateConsequences < ActiveRecord::Migration
  def change
    create_table :consequences do |t|
      t.integer :choice_id
      t.string :text
      t.integer :image_id
      t.integer :god_id
      t.decimal :exp_gained
      t.decimal :currency_gained

      t.timestamps
    end
  end
end
