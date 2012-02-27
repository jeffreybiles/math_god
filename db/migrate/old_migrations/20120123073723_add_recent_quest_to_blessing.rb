class AddRecentQuestToBlessing < ActiveRecord::Migration
  def change
    add_column :blessings, :quest_id, :integer

    rename_column :quests, :god, :god_id
  end
end
