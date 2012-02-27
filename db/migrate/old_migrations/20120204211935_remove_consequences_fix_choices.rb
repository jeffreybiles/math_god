class RemoveConsequencesFixChoices < ActiveRecord::Migration
  def change
    drop_table :consequences

    remove_column :rep_gains, :consequences_id

    add_column :rep_gains, :choices_id, :integer
  end
end
