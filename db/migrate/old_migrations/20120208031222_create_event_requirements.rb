class CreateEventRequirements < ActiveRecord::Migration
  def change
    create_table :event_requirements do |t|
      t.integer :event_id
      t.integer :requirer_id
      t.string :requirer_type
      t.integer :stage_required

      t.timestamps
    end
  end
end
