class AddLastTimeEnergyTickedToUser < ActiveRecord::Migration
  def change
    add_column :users, :last_energy_tick, :time
  end
end
