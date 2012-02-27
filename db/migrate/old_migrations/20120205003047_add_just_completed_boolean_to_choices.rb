class AddJustCompletedBooleanToChoices < ActiveRecord::Migration
  def change
    add_column :choices, :just_completed, :boolean
  end
end
