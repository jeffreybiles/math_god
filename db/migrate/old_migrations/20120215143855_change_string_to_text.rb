class ChangeStringToText < ActiveRecord::Migration
  def change
    remove_column :qualities, :description

    add_column :qualities, :description, :text
  end
end
