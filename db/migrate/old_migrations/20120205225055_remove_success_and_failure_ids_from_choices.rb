class RemoveSuccessAndFailureIdsFromChoices < ActiveRecord::Migration
  def change
    remove_column :choices, :success_id
    remove_column :choices, :failure_id
  end
end
