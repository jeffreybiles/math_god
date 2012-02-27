class ChangeHappeningEventIdFromStringToInteger < ActiveRecord::Migration
  def change
    remove_column :happenings, :event_id

    add_column :happenings, :event_id, :integer
  end
end
