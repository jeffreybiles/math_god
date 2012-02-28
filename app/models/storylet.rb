class Storylet < ActiveRecord::Base
  has_many :links, foreign_key: "previous_id", dependent: :destroy
  has_many :next_storylets, through: :links, source: :next
  accepts_nested_attributes_for :links, allow_destroy: true

  has_many :previous_links, foreign_key: "next_id", class_name: 'Link', dependent: :destroy
  has_many :previous_storylets, through: :previous_links, source: :previous
  accepts_nested_attributes_for :previous_links, allow_destroy: true

  has_many :qualities
  belongs_to :preview_image, class_name: 'Image'
  belongs_to :action_image, class_name: 'Image'
  belongs_to :success_image, class_name: 'Image'
  belongs_to :failure_image, class_name: 'Image'
  belongs_to :god, class_name: 'Quality'

  has_many :requirements, dependent: :destroy
  accepts_nested_attributes_for :requirements, allow_destroy: true

  has_many :rewards, dependent: :destroy
  accepts_nested_attributes_for :rewards

  has_many :player_logs

  def update_user_qualities(success, current_user)
    self.rewards.each do |reward|
      if situation_qualifies(success, reward)
        quality = current_user.my_qualities.find_or_create_by_quality_id(reward.quality_id)
        update_quality(quality, reward)
      end
    end
  end

  def self.update_quality(quality, reward)
    @storylet = Storylet.new
    @storylet.update_quality(quality, reward)
  end

  def update_quality(quality, reward)
    if reward.number_increased == 0
      quality.delete
    else
      q_type = quality.quality_type
      if q_type == 'item' || q_type == 'currency' || q_type == 'status' || q_type == 'cooldown'
        quality.level= (quality.level || 0) + reward.number_increased
        quality.level = 0 if quality.level < 0
      elsif q_type == 'event'
        quality.level = reward.number_increased
      elsif q_type == 'god' || q_type == 'faction'
        quality.add_experience(quality.experience_earned(reward.number_increased))
      end
      quality.expiration_time= quality.time_limit.minutes.from_now if quality.time_limit

      quality.save!
    end
  end

  def situation_qualifies(success, reward)
    (success and reward.on_success) or (!success and reward.on_fail)
  end


  def preview_image_name 
    preview_image.try(:name)
  end

  def preview_image_name=(name)
    self.preview_image = Image.find_or_create_by_name(name) if name.present?
  end


  def action_image_name
    action_image.try(:name)
  end

  def action_image_name=(name)
    self.action_image = Image.find_or_create_by_name(name) if name.present?
  end


  def success_image_name
    success_image.try(:name)
  end

  def success_image_name=(name)
    self.success_image = Image.find_or_create_by_name(name) if name.present?
  end


  def failure_image_name
    failure_image.try(:name)
  end

  def failure_image_name=(name)
    self.failure_image = Image.find_or_create_by_name(name) if name.present?
  end
end
