class AddAnswersToBlessing < ActiveRecord::Migration
  def change
    add_column :blessings, :given_answer, :decimal
    add_column :blessings, :correct_answer, :decimal
  end
end
