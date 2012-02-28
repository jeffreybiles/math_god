class AddDefaultsToMyQualities < ActiveRecord::Migration
  def change
    change_column :my_qualities, :exp_to_level, :decimal, {default: 40}
    change_column :my_qualities, :exp_to_delevel, :decimal, {default: 0}
    change_column :my_qualities, :level, :integer, {default: 1}
  end
end
