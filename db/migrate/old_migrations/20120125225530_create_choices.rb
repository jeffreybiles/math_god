class CreateChoices < ActiveRecord::Migration
  def change
    create_table :choices do |t|
      t.integer :quest_id
      t.integer :creator_id
      t.integer :level
      t.integer :god_id
      t.string :choice_text
      t.string :success_text
      t.string :fail_text

      t.timestamps
    end
  end
end
