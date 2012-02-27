class AutoGenerateExperienceOptionForQuests < ActiveRecord::Migration
  def change
    add_column :choices, :custom_experience, :boolean
  end
end
