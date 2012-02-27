class AddNotesToStorylet < ActiveRecord::Migration
  def change
    add_column :storylets, :notes, :text
  end
end
