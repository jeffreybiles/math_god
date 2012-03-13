class Quality < ActiveRecord::Base
  belongs_to :storylet

  has_many :my_qualities, dependent: :destroy
  has_many :users, through: :my_qualities

  has_many :requirements, dependent: :destroy
  has_many :rewards, dependent: :destroy

  has_many :effects, class_name: 'Reward'
  accepts_nested_attributes_for :effects

  belongs_to :image, counter_cache: :uses_count

  def image_name
    image.try(:name)
  end

  def image_name=(name)
    self.image = Image.find_or_create_by_name(name) if name.present?
  end

  def storylet_title
    storylet.try(:title)
  end

  def storylet_title=(title)
    self.storylet = Storylet.find_or_create_by_title(title) if title.present?
  end
end
