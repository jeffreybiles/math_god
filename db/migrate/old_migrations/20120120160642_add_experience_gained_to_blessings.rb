class AddExperienceGainedToBlessings < ActiveRecord::Migration
  def change
    add_column :blessings, :experience_gained, :decimal
  end
end
