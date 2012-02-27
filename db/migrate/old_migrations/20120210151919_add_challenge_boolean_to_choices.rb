class AddChallengeBooleanToChoices < ActiveRecord::Migration
  def change
    add_column :choices, :has_challenge, :boolean
  end
end
