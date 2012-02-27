class AddSuccessBooleanToEventChanges < ActiveRecord::Migration
  def change
    add_column :event_changes, :success, :boolean
  end
end
