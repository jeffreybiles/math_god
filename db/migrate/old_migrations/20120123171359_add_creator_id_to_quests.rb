class AddCreatorIdToQuests < ActiveRecord::Migration
  def change
    add_column :quests, :creator_id, :integer
  end
end
