class AddExpToDelevelToMyQualities < ActiveRecord::Migration
  def change
    add_column :my_qualities, :exp_to_delevel, :decimal
    add_column :my_qualities, :exp_to_level, :decimal

    remove_column :my_qualities, :exp
  end
end
