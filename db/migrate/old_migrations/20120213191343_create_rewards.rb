class CreateRewards < ActiveRecord::Migration
  def change
    create_table :rewards do |t|
      t.integer :storylet_id
      t.integer :quality_id
      t.boolean :on_success
      t.boolean :on_fail
      t.boolean :default_exp
      t.integer :number_increased

      t.timestamps
    end
  end
end
