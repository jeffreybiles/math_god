class CreatePlayerLogs < ActiveRecord::Migration
  def change
    create_table :player_logs do |t|
      t.integer :user_id
      t.integer :storylet_id
      t.boolean :success

      t.timestamps
    end
  end
end
