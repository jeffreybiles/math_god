class CreateQuests < ActiveRecord::Migration
  def change
    create_table :quests do |t|
      t.integer :level
      t.integer :god
      t.string :title
      t.string :intro_text
      t.string :success_text
      t.string :failure_text

      t.timestamps
    end
  end
end
