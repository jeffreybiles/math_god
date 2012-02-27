class DropUnusedTables < ActiveRecord::Migration
  def change
    drop_table :blessings
    drop_table :blessing_requirements
    drop_table :choices
    drop_table :events
    drop_table :event_requirements
    drop_table :event_changes
    drop_table :factions
    drop_table :happenings
    drop_table :gods
    drop_table :item_requirements
    drop_table :item_rewards
    drop_table :items
    drop_table :locations
    drop_table :owned_items
    drop_table :quests
    drop_table :rep_gains
    drop_table :reputation_requirements
    drop_table :reputations
  end
end
