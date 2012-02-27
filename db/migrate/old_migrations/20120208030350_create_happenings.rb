class CreateHappenings < ActiveRecord::Migration
  def change
    create_table :happenings do |t|
      t.integer :user_id
      t.string :event_id
      t.integer :stage

      t.timestamps
    end
  end
end
