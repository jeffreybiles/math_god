class AddLocationChangeToChoices < ActiveRecord::Migration
  def change
    add_column :choices, :success_location_change_id, :integer
    add_column :choices, :failure_location_change_id, :integer
  end
end
