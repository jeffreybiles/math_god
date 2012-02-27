class Link < ActiveRecord::Base
  belongs_to :next, class_name: 'Storylet'
  belongs_to :previous, class_name: 'Storylet'

  def previous_title
    previous.try(:title)
  end

  def previous_title=(title)
    self.previous = Storylet.find_or_create_by_title(title) if title.present?
  end

  def next_title
    next_thing = Storylet.find_by_id(next_id)
    next_thing.try(:title)
  end

  def next_title=(title)
    self.next = Storylet.find_or_create_by_title(title) if title.present?
  end
end
