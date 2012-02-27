class CreateStorylets < ActiveRecord::Migration
  def change
    create_table :storylets do |t|
      t.string :title
      t.string :subtitle
      t.text :main_text
      t.text :success_text
      t.text :failure_text
      t.boolean :has_challenge

      t.timestamps
    end
  end
end
