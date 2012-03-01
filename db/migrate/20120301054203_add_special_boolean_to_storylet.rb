class AddSpecialBooleanToStorylet < ActiveRecord::Migration
  def change
    add_column :storylets, :special, :boolean

  end
end
