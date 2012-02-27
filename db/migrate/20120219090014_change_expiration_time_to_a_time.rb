class ChangeExpirationTimeToATime < ActiveRecord::Migration
  def change
    remove_column :my_qualities, :expiration_time

    add_column :my_qualities, :expiration_time, :time
  end
end
