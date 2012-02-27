class AddLocationIdToQuests < ActiveRecord::Migration
  def change
    add_column :quests, :location_id, :integer
  end
end
