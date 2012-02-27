class CreateBlessingRequirements < ActiveRecord::Migration
  def change
    create_table :blessing_requirements do |t|
      t.integer :god_id
      t.integer :requirer_id
      t.string :requirer_type
      t.integer :level_required

      t.timestamps
    end
  end
end
