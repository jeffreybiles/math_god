class RolesToUser < ActiveRecord::Migration
  def change
    add_column :users, :admin, :boolean
    add_column :users, :contributor, :boolean
    add_column :users, :player, :boolean
  end
end
