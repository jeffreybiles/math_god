class AddRequirements < ActiveRecord::Migration
  def change
    add_column :quests, :currency_required, :integer
    add_column :choices, :currency_required, :integer
  end
end
