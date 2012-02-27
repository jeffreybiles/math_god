class CreateItemRequirements < ActiveRecord::Migration
  def change
    create_table :item_requirements do |t|
      t.integer :item_id
      t.integer :requirer_id
      t.string :requirer_type
      t.integer :number_required

      t.timestamps
    end
  end
end
