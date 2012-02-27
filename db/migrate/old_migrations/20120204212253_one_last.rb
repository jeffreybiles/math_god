class OneLast < ActiveRecord::Migration
  def change
    remove_column :rep_gains, :choices_id
    add_column :rep_gains, :choice_id, :integer
  end
end
