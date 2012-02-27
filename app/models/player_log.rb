class PlayerLog < ActiveRecord::Base
  belongs_to :user
  belongs_to :storylet

  delegate :name, to: :user
  delegate :title, to: :storylet

  def leads_to(storylet)
    if storylet.class == "String"
      storylet = Integer(storylet)
    end
    if storylet.class == 'Integer'
      Storylet.find(storylet)
    end
    self.storylet.next_storylets.include?(storylet)
  end
end
