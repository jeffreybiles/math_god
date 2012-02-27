class ApplicationController < ActionController::Base
  protect_from_forgery

  helper_method :current_user_session, :current_user, :link_fu,
                :requirements, :get_my_quality, :get_or_create_my_quality,
                :log_code, :percent_complete, :experience_earned,
                :percent_completed_and_gained, :minutes_since_last_tick,
                :max_energy, :time_between_ticks, :status_progress_and_gained,
                :owed_energy

  def percent_complete(quality_id)
    my_quality = get_my_quality(quality_id)
    100 * (my_quality.exp_to_delevel / (my_quality.exp_to_delevel + my_quality.exp_to_level))
  end

  def time_between_ticks
    3
  end

  def owed_energy
    energy = ((minutes_since_last_tick / time_between_ticks + 1)).floor
    energy = max_energy - current_user.energy if energy > max_energy - current_user.energy
    energy
  end

  def max_energy
    30
  end

  def status_progress_and_gained(reward)
    max_level = 50
    my_quality = get_my_quality(reward.quality_id)
    current_amount = my_quality.level
    previous_amount = current_amount - reward.number_increased
    if current_amount > previous_amount
      [previous_amount*100/max_level, reward.number_increased*100/max_level]
    else
      [current_amount*100/max_level, 0, reward.number_increased.abs*100/max_level]
    end
  end

  def percent_completed_and_gained(reward)
    my_quality = get_my_quality(reward.quality_id)
    exp_for_level = my_quality.exp_to_delevel + my_quality.exp_to_level
    current_experience = my_quality.exp_to_delevel / exp_for_level
    previous_experience = (my_quality.exp_to_delevel - experience_earned(reward))/exp_for_level
    if current_experience > previous_experience
      [previous_experience * 100, (current_experience - previous_experience) * 100]
    else
      [current_experience*100, 0, (current_experience - previous_experience).abs * 100]
    end

  end

  def experience_earned(reward)
    my_quality = get_my_quality(reward.quality_id)
    my_quality.experience_earned(reward.number_increased, reward).round(1)
  end

  def minutes_since_last_tick
    now = 1.second.ago
    last_tick = current_user.last_energy_tick
    ((now - last_tick)/60).round(0)
    #minutes = now.strftime("%M").to_i - last_tick.strftime("%M").to_i
    #hours = now.strftime("%H").to_i - last_tick.strftime("%H").to_i
    #
    #
    #minutes += hours*60
    #if minutes < -60
    #  minutes = 60*24 - minutes
    #end
    #minutes
  end

  def log_code
    (last_log.created_at.strftime("%H%M%S").to_i(21) + last_log.created_at.strftime("%S%D").to_i(31)).to_s
  end

  def last_log
    current_user.player_logs.last if current_user && current_user.player_logs
  end

  def last_log_status
    if last_log.success then "success" else "failure" end
  end

  def requirements(id, type='storylet')
    option = Storylet.find(id)
    quality_requirements(option)
  end

  def get_my_quality(id)
    if id.class == 'Quality'
      id = id.id
    end
    current_user.my_qualities.find_by_quality_id(id)
  end

  def get_or_create_my_quality(id)
    if id.class == 'Quality'
      id = id.id
    end
    current_user.my_qualities.find_or_create_by_quality_id(id)
  end

  #
  #def quality_requirements(option)
  #  requirements = ""
  #  option.requirements.each do |requirement|
  #    if requirement.max_level == 0
  #      if get_my_quality(requirement.quality_id)
  #        return requirements << "You already have the quality #{requirement.quality.name}"
  #      end
  #    elsif get_my_quality(requirement.quality_id).nil? ||
  #        requirement.min_level > (get_my_quality(requirement.quality_id).level || 0)
  #      requirements << "You must be level #{requirement.min_level} with the quality #{requirement.quality.name}"
  #    elsif requirement.max_level &&
  #        requirement.max_level < get_my_quality(requirement.quality).level
  #      requirements << "You have too much of the quality #{requirement.qaulity.name}."
  #    end
  #  end
  #  requirements
  #end

  def quality_requirements(option)
    requirements = ""
    blocked = false
    option.requirements.each do |requirement|
      quality = get_my_quality(requirement.quality_id)
      if quality
        if requirement.max_level == 0
          requirements << "You have the quality #{requirement.name}"
          blocked = true if requirement.quality_type != 'cooldown'
        elsif requirement.min_level && requirement.min_level > quality.level
          requirements << "You must have #{requirement.name} #{requirement.min_level} or more."
          blocked = true if requirement.min_level > quality.level + 5
        elsif requirement.max_level && requirement.max_level < quality.level
          requirements << "You are must have less than #{requirement.name} #{requirement.max_level}."
          blocked = true if requirement.max_level < quality.level - 1
        end

      elsif requirement.min_level
        requirements << "You must be level #{requirement.min_level} with #{requirement.quality.name}"
        blocked = true if requirement.min_level > 3
      end
    end
    [requirements, blocked]
  end

  def link_fu(link, size ='medium')
    default = 'http://mathgod.s3.amazonaws.com/uploads/image/picture/7/Mystery.jpg'
    if link
      unless link.class == 'Image'
        link = Image.find(link)
      end
      if size == 'medium'  && link.picture?
        link.picture
      elsif size == 'small' && link.small_picture?
        link.small_picture
      else
        default
      end
    else
      default
    end
  end


  def current_user
    @current_user ||= current_user_session && current_user_session.user
  end

  #def my_item(id)
  #  item = current_user.owned_items.find_by_item_id(id)
  #  if item.nil?
  #    item = OwnedItem.new(user_id: current_user.id, item_id: id, number_owned: 0)
  #    item.save
  #  end
  #  item
  #end
  #
  #def my_blessing(id, id_of_what = 'god')
  #  blessing = current_user.blessings.find_by_god_id(id)
  #  #why does this cause an error but the others don't?'
  #  #if blessing.nil?
  #  #  blessing = Blessing.new(user_id: current_user.id, god_id: id, level: 1, exp_to_level: 40)
  #  #  blessing.save
  #  #end
  #  blessing
  #end
  #
  #def my_reputation(id)
  #  reputation = current_user.reputations.find_by_faction_id(id)
  #  if reputation.nil?
  #    reputation = Reputation.new(user_id: current_user.id, faction_id: id, level: 1,
  #                                exp_to_level: 40, exp_to_delevel: 0)
  #    reputation.save
  #  end
  #  reputation
  #end
  #
  #def my_event(id)
  #  event = current_user.happenings.find_by_event_id(id)
  #  unless event
  #    event = Happening.new(user_id: current_user.id, event_id: id, stage: 1)
  #    event.save
  #  end
  #  event
  #end


  protected

    def current_user_session
      @current_user_session ||= UserSession.find
    end


    #def money_requirements(option)
    #  requirements = ""
    #  if option.currency_required && option.currency_required > current_user.currency
    #    requirements << "#{option.currency_required} favor required."
    #  end
    #  requirements
    #end
    #
    #def reputation_requirements(option)
    #  requirements = ""
    #  option.reputation_requirements.each do |requirement|
    #    if requirement.max_reputation == 0
    #      if my_reputation(requirement.faction_id)
    #        return requirements << "You are too close to #{requirement.faction.name}"
    #      end
    #    elsif my_reputation(requirement.faction_id).nil? ||
    #        requirement.level_required > my_reputation(requirement.faction_id).level
    #      requirements << "You must be level #{requirement.level_required} with #{requirement.faction.name}"
    #    elsif requirement.max_reputation &&
    #        requirement.max_reputation < my_reputation(requirement.faction_id).level
    #      requirements << "You are too favored by #{requirement.faction.name}.  This will do you no good."
    #    end
    #  end
    #  requirements
    #end
    #
    #def blessing_requirements(option)
    #  requirements = ""
    #  option.blessing_requirements.each do |requirement|
    #    if requirement.max_blessing == 0
    #      if my_blessing(requirement.god_id)
    #        return requirements << "You are too favored by #{requirement.god.name}"
    #      end
    #    elsif my_blessing(requirement.god_id).nil? ||
    #        requirement.level_required > my_blessing(requirement.god_id).level
    #      requirements << "You must be level #{requirement.level_required} with #{requirement.god.name}"
    #    elsif requirement.max_blessing &&
    #        requirement.max_blessing < my_blessing(requirement.god_id).level
    #      requirements << "You are too favored by #{requirement.god.name}.  This will do you no good."
    #    end
    #  end
    #  if my_blessing(option.god_id).nil? || option.level > my_blessing(option.god_id).level + 2
    #    requirements << "You must be level #{option.level} with #{option.god.name}"
    #  end
    #  requirements
    #end
    #
    #def item_requirements(option)
    #  requirements = ""
    #  option.item_requirements.each do |requirement|
    #    if requirement.max_items == 0
    #      if my_item(requirement.item_id)
    #        return requirements << "You own too many #{requirement.item.name}"
    #      end
    #    elsif my_item(requirement.item_id).nil? ||
    #        requirement.number_required > my_item(requirement.item_id).number_owned
    #      requirements << "You must own #{ActionController::Base.helpers.pluralize(requirement.number_required, requirement.item.name)}"
    #    elsif requirement.max_items &&
    #        requirement.max_items < my_item(requirement.item_id).number_owned
    #      requirements << "You own too many #{requirement.item.name}."
    #    end
    #  end
    #  requirements
    #end
    #
    #def event_requirements(option)
    #  requirements = ""
    #  option.event_requirements.each do |requirement|
    #    if requirement.max_stage == 0
    #      if my_event(requirement.event_id)
    #        return requirements << "You are too far in #{requirement.event.name}"
    #      end
    #    elsif my_event(requirement.event_id).nil? ||
    #        requirement.stage_required > my_event(requirement.event_id).stage
    #      requirements << "You must progress farther in #{requirement.event.name}."
    #    elsif requirement.max_stage &&
    #        requirement.max_stage < my_event(requirement.event_id).stage
    #      requirements << "You are too far in #{requirement.event.name}.  The time for this has passed."
    #    end
    #  end
    #  requirements
    #end
end
