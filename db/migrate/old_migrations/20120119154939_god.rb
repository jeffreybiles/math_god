class God < ActiveRecord::Migration
  def change
    add_column :gods, :creator_id, :integer
  end
end
