class AddChoiceIdToBlessing < ActiveRecord::Migration
  def change
    add_column :blessings, :choice_id, :integer
  end
end
