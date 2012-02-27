class AddMaxBlessingToBlessingRequirements < ActiveRecord::Migration
  def change
    add_column :blessing_requirements, :max_blessing, :integer
    add_column :reputation_requirements, :max_reputation, :integer
  end
end
