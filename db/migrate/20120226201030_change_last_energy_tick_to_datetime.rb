class ChangeLastEnergyTickToDatetime < ActiveRecord::Migration
  def up
    remove_column :users, :last_energy_tick
    add_column :users, :last_energy_tick, :datetime
  end

  def down
    remove_column :users, :last_energy_tick
    add_column :users, :last_energy_tick, :time
  end
end
