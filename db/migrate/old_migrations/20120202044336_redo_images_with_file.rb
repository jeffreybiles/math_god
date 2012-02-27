class RedoImagesWithFile < ActiveRecord::Migration
  def change
    add_column :images, :picture, :string

    remove_column :images, :url
  end
end
