class SwitchToDeviseFromAuthlogic < ActiveRecord::Migration
  def self.up
    add_column :users, :reset_password_token, :string
    add_column :users, :remember_token, :string
    add_column :users, :remember_created_at, :datetime
    add_column :users, :authentication_token, :string

    rename_column :users, :crypted_password, :encrypted_password

    remove_column :users, :persistence_token
    remove_column :users, :single_access_token
    remove_column :users, :perishable_token

    change_table(:users) do |t|
      t.datetime :reset_password_sent_at

      t.integer  :sign_in_count, :default => 0
      t.datetime :current_sign_in_at
      t.datetime :last_sign_in_at
      t.string   :current_sign_in_ip
      t.string   :last_sign_in_ip

    end
  end

  def self.down
    raise ActiveRecord::IrreversibleMigration
  end
end
