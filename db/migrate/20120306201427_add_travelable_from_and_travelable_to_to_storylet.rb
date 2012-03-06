class AddTravelableFromAndTravelableToToStorylet < ActiveRecord::Migration
  def change
    add_column :storylets, :travelable_from, :boolean, default: true
  end
end
