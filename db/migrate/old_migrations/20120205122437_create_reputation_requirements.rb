class CreateReputationRequirements < ActiveRecord::Migration
  def change
    create_table :reputation_requirements do |t|
      t.integer :faction_id
      t.integer :requirer_id
      t.string :requirer_type
      t.integer :level_required

      t.timestamps
    end
  end
end
