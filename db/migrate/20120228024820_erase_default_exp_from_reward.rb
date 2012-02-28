class EraseDefaultExpFromReward < ActiveRecord::Migration
  def change
    remove_column :rewards, :default_exp
  end
end
