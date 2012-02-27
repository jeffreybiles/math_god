class ChangeDescriptionsFromStringsIntoTexts < ActiveRecord::Migration
  def change
    remove_column :choices, :success_text
    remove_column :choices, :fail_text
    remove_column :events, :description
    remove_column :factions, :description
    remove_column :gods, :description
    remove_column :items, :description
    remove_column :locations, :description
    remove_column :quests, :choices_text
    remove_column :universes, :description

    add_column :choices, :success_text, :text
    add_column :choices, :fail_text, :text
    add_column :events, :description, :text
    add_column :factions, :description, :text
    add_column :gods, :description, :text
    add_column :items, :description, :text
    add_column :locations, :description, :text
    add_column :quests, :choices_text, :text
    add_column :universes, :description, :text
  end
end
