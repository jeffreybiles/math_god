class CreateEventChanges < ActiveRecord::Migration
  def change
    create_table :event_changes do |t|
      t.integer :event_id
      t.integer :choice_id
      t.integer :stage

      t.timestamps
    end
  end
end
