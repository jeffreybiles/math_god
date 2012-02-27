class CreateImages < ActiveRecord::Migration
  def change
    create_table :images do |t|
      t.string :url
      t.string :name
      t.string :subject
      t.string :mood

      t.timestamps
    end

    remove_column :users, :image
  end
end
