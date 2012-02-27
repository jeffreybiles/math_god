class RemoveFailAndSuccessTextFromQuests < ActiveRecord::Migration
  def change
    remove_column :quests, :success_text
    remove_column :quests, :failure_text
  end
end
