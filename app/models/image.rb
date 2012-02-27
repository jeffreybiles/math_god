class Image < ActiveRecord::Base
  has_many :users
  #has_many :gods
  #has_many :choices
  #has_many :quests
  #has_many :locations
  #has_many :factions
  #has_many :items
  mount_uploader :picture, PictureUploader
  mount_uploader :small_picture, PictureUploader
  belongs_to :creator, class_name: 'User'

  has_many :storylet_previews, foreign_key: 'preview_image_id', class_name: 'Storylet'
  has_many :storylet_successes, foreign_key: 'success_image_id', class_name: 'Storylet'
  has_many :storylet_failures, foreign_key: 'failure_image_id', class_name: 'Storylet'
  has_many :storylet_actions, foreign_key: 'action_image_id', class_name: 'Storylet'
  has_many :qualities
  validates_presence_of :name, :creator
end
