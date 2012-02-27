class AddSmallerImageToImagesAndRemoveDescriptors < ActiveRecord::Migration
  def change
    add_column :images, :small_picture, :string

    remove_column :images, :subject
    remove_column :images, :mood
  end
end
