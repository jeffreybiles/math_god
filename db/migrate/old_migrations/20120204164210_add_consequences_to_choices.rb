class AddConsequencesToChoices < ActiveRecord::Migration
  def change
    add_column :choices, :exp_gained, :decimal
    add_column :choices, :currency_gained, :decimal
  end
end
