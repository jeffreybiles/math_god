class AddOfferCodeToUsers < ActiveRecord::Migration
  def change
    add_column :users, :offer_code, :string
  end
end
