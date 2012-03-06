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
    3
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
    storylet.requirements.each do |requirement|
      quality = get_my_quality(requirement.quality_id)
      if quality
        if requirement.max_level == 0
          requirements << "You have the quality #{requirement.name}.\r\n"
          blocked = true if requirement.quality_type != 'cooldown'
        elsif !quality.level or (requirement.min_level && requirement.min_level > quality.level)
          requirements << "Requires #{requirement.name} #{requirement.min_level} or more.\r\n"
          blocked = true if requirement.min_level > (quality.level || 1) + 5 && requirement.quality.name != 'favor'
          blocked = true if requirement.quality_type == 'event'
        elsif requirement.max_level && requirement.max_level < quality.level
          requirements << "Requires less than #{requirement.name} #{requirement.max_level}.\r\n"
          blocked = true if requirement.max_level < quality.level - 2  or requirement.quality_type == 'event'
        end

      elsif requirement.min_level
        requirements << "Requires #{requirement.min_level} with #{requirement.quality.name}.\r\n"
        blocked = true if requirement.min_level > 3 or requirement.quality_type == 'event'
      end
    end
    requirements << check_cooloff_time(storylet) if storylet.cooloff_time
    [requirements, blocked]
  end

  def check_cooloff_time(storylet)
    last_time_played = current_user.player_logs.find_all_by_storylet_id(storylet.id).last
    if last_time_played
      time_since_played = (1.second.ago - last_time_played.created_at)/60
      if time_since_played < storylet.cooloff_time
        return "You must wait
            #{help.pluralize((storylet.cooloff_time - time_since_played).ceil, "more minute")}
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
