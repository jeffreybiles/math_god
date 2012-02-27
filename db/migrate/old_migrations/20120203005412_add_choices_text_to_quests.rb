class AddChoicesTextToQuests < ActiveRecord::Migration
  def change
    add_column :quests, :choices_text, :string
  end
end
