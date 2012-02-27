class AddMinAndMaxStageLevelsToEventRequirements < ActiveRecord::Migration
  def change
    add_column :event_requirements, :max_stage, :integer
  end
end
