class AddLocationAndUniverseToUser < ActiveRecord::Migration
  def change
    add_column :users, :current_universe_id, :integer
    add_column :users, :current_location_id, :integer
  end
end
