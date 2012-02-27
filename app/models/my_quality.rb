class MyQuality < ActiveRecord::Base
  belongs_to :user
  belongs_to :quality

  delegate :quality_type, to: :quality
  delegate :time_limit, to: :quality

  def self.check_triggers(user)
    #perfect candidate for scoping, whenever I get around to figuring that out
    #figure out how to only run through things with an expiration date...
    #otherwise this will overburden servers
    user.my_qualities.each do |quality|
      if quality.check_trigger
        quality.delete
      end
    end
  end

  def check_trigger
    if self.is_expired?
      self.trigger_effects
      return true
    end
  end

  def is_expired?
    2.seconds.ago > (self.expiration_time || 8.years.from_now)
  end

  def trigger_effects
    self.quality.effects.each do |effect|
      Storylet.update_quality(self, effect)
    end
  end

  def add_experience(experience_to_add)
    unless self.exp_to_level
      self.exp_to_level = 40
      self.level = 1
      self.exp_to_delevel = 0
    end

    self.exp_to_level = self.exp_to_level - experience_to_add
    self.exp_to_delevel = self.exp_to_delevel + experience_to_add
    self.delevel if self.exp_to_delevel <= 0
    self.level_up if self.exp_to_level <= 0
    self.save!
  end

  def delevel
    if level > 1
      self.level -= 1
      self.exp_to_delevel = experience_required + self.exp_to_delevel
      self.exp_to_level = experience_required - self.exp_to_delevel
    end
  end

  def level_up
    self.level += 1
    self.exp_to_level = experience_required + self.exp_to_level
    self.exp_to_delevel = experience_required - self.exp_to_level
  end

  def experience_required
    40 * (1.2 ** (self.level - 1))
  end

  def experience_earned(challenge_level, reward = nil)
    challenge_level ||= reward.storylet.challenge_level
    amount = 10 * (1.15 ** (challenge_level.abs)) / (1.05 ** ((self.level || 1) + 2 - challenge_level.abs))
    if challenge_level > 0 then amount else -1*amount end
  end
end
