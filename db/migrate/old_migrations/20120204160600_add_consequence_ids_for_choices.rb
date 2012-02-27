class AddConsequenceIdsForChoices < ActiveRecord::Migration
  def change
    add_column :choices, :success_id, :integer
    add_column :choices, :failure_id, :integer
  end
end
