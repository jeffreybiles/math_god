class Reward < ActiveRecord::Base
  belongs_to :storylet
  belongs_to :quality

  delegate :name, to: :quality
  delegate :quality_type, to: :quality
  delegate :image, to: :quality

  def quality_name
    quality.try(:name)
  end

  def quality_name=(name)
    self.quality = Quality.find_or_create_by_name(name) if name.present?
  end

  def storylet_title
    storylet.try(:title)
  end

  def storylet_title=(title)
    self.storylet = Storylet.find_or_create_by_title(title) if title.present?
  end
end
