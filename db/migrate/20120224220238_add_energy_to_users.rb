class AddEnergyToUsers < ActiveRecord::Migration
  def change
    add_column :users, :energy, :integer
    add_column :users, :favor, :integer

    remove_column :users, :currency
  end
end
