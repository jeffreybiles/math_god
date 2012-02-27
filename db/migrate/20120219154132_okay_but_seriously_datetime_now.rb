class OkayButSeriouslyDatetimeNow < ActiveRecord::Migration
  def change
    remove_column :my_qualities, :expiration_time

    add_column :my_qualities, :expiration_time, :datetime
  end
end
