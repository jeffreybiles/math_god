class AddTitleToChoices < ActiveRecord::Migration
  def change
    add_column :choices, :title, :string
  end
end
