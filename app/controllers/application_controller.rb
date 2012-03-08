class ApplicationController < ActionController::Base
  protect_from_forgery

  def help
    Helper.instance
  end

  class Helper
    include Singleton
    include ActionView::Helpers::TextHelper
  end

  helper_method :link_fu, :requirements, :get_my_quality,
                :get_or_create_my_quality, :log_code, :percent_complete,
                :experience_earned, :percent_completed_and_gained,
                :minutes_since_last_tick, :max_energy, :time_between_ticks,
                :status_progress_and_gained, :owed_energy, :favor, :last_log,
                :last_log_status, :last_few_logs, :item_added_as_percentage,
                :currency, :my_gods, :all_my_gods #:current_user_session, :current_user

  def my_gods(user = current_user)
    all_my_gods = all_my_gods(user)
    all_my_gods.last
  end

  def all_my_gods(user = current_user)
    my_qualities = user.my_qualities
    my_qualities_array = []
    my_qualities.map{|quality| my_qualities_array << quality if quality.quality_type == 'god'}
    my_qualities_array
  end


  def item_added_as_percentage(reward)
    items_added = reward.number_increased
    total = get_my_quality(reward.quality_id).level
    if total
      if total > 0
        if items_added > 0
          [(total - items_added.abs)*100/total, items_added*100/total]
        else
          old_total = items_added.abs + total
          [total*100/old_total, 0, (items_added.abs)*100/old_total]
        end
      else
        [0, 0, items_added*100, 0]
      end
    else
      [0, 100]
    end
  end

  def percent_complete(quality_id)
    my_quality = get_my_quality(quality_id)
    100 * (my_quality.exp_to_delevel / (my_quality.exp_to_delevel + my_quality.exp_to_level))
  end

  def time_between_ticks
    2
  end

  def last_few_logs
    current_user.player_logs.order('created_at DESC').limit(7)
  end

  def owed_energy
    energy = ((minutes_since_last_tick / time_between_ticks + 1)).floor
    energy = max_energy - current_user.energy if energy > max_energy - current_user.energy
    energy
  end

  def max_energy
    20
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

  def status_progress(my_quality)
    max_level = 50
    current_amount = my_quality.level
    current_amount/max_level
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
    my_quality = get_or_create_my_quality(reward.quality_id)
    my_quality.experience_earned(reward.number_increased, reward).round(1)
  end

  def minutes_since_last_tick
    now = 1.second.ago
    last_tick = current_user.last_energy_tick
    ((now - last_tick)/60).round(1)
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
    storylet = Storylet.find(id)
    quality_requirements(storylet)
  end

  def get_my_quality(id)
    if id.class == 'String'
      quality = Quality.find_by_name(id)
    end
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

  def quality_requirements(storylet)
    requirements = ""
    blocked = false
    number_of_god_requirements = 0
    chances = 0
    storylet.requirements.each do |requirement|
      quality = get_my_quality(requirement.quality_id)
      if requirement.max_level == 0 && quality
        blocked = true
      end
      case requirement.quality.quality_type
        when 'event'
          blocked = true unless within_range?(requirement, quality)
        when 'faction', 'god'
          if storylet.has_challenge && requirement.min_level
            number_of_god_requirements += 1
            chances += calculate_chances((quality.level || 0) - requirement.min_level)
          else
            unless within_range?(requirement, quality)
              requirements << requirements_statement(requirement)
            end
          end
        when 'status'
          unless within_range?(requirement, quality)
            requirements << requirements_statement(requirement)
          end
        when 'currency', 'item'
          unless within_range?(requirement, quality)
            requirements << requirements_statement(requirement)
          end
      end

    end
    requirements << check_cooloff_time(storylet) if storylet.cooloff_time
    chances = chances/number_of_god_requirements if number_of_god_requirements > 0
    [requirements, blocked, chances]
  end

  def calculate_chances(diff = nil)
    if diff
      (1 + Math.erf((diff + 1)/7.071))/2
    else
      0
    end
  end

  def requirements_statement(requirement)
    more_than = "#{requirement.min_level} or more" if requirement.min_level
    less_than = "#{requirement.max_level} or less" if requirement.max_level
    have_and = "and" if requirement.min_level and requirement.max_level
    "Requires #{more_than} #{have_and} #{less_than} of #{requirement.quality.name}.\r\n"
  end

  def within_range?(requirement, my_quality)
    status = true
    if requirement.min_level && (!my_quality || my_quality.level < requirement.min_level)
      status = false
    end
    if requirement.max_level && my_quality && my_quality.level > requirement.max_level
      status = false
    end
    status
  end

  def check_cooloff_time(storylet)
    last_time_played = current_user.player_logs.find_all_by_storylet_id(storylet.id).last
    if last_time_played
      time_since_played = (1.second.ago - last_time_played.created_at)/60
      if time_since_played < storylet.cooloff_time
        return "You must wait
            #{help.pluralize((storylet.cooloff_time - time_since_played).round(1), "more minute")}
            to play this storylet again.\r\n"
      end
    end
    ""
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

  def favor
    this_quality = Quality.find_by_name('favor')
    this_quality.my_qualities.find_or_create_by_user_id(current_user.id)
  end

  def currency
    this_quality = Quality.find_by_name('teragon currency')
    this_quality.my_qualities.find_or_create_by_user_id(current_user.id)
  end

  #def current_user
  #  @current_user ||= current_user_session && current_user_session.user
  #end
  #
  #protected
  #
  #  def current_user_session
  #    @current_user_session ||= UserSession.find
  #  end

end
