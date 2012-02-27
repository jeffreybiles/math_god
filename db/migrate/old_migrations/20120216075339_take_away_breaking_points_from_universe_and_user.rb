class TakeAwayBreakingPointsFromUniverseAndUser < ActiveRecord::Migration
  def change
    remove_column :users, :current_location_id

    remove_column :universes, :god_id
  end
end
