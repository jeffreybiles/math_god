class AddSuccessFieldToRepGains < ActiveRecord::Migration
  def change
    add_column :rep_gains, :success, :boolean
  end
end
