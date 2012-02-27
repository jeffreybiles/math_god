class AddTimeLimitsAndCooloffTimesToStorylets < ActiveRecord::Migration
  def change
    add_column :storylets, :cooloff_time, :integer

    add_column :qualities, :time_limit, :integer

    add_column :my_qualities, :expiration_time, :integer
  end
end
