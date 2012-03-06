class StoryletsController < ApplicationController
  load_and_authorize_resource

  make_resourceful do
    actions :all
  end

  def travel
    @storylet = Storylet.find(params[:id])
    change_energy_tick
    per_turn_actions
    if last_log && last_log.storylet.travelable_from && get_my_quality('can travel in teragon')
       PlayerLog.create!(user_id: current_user.id, storylet_id: @storylet.id, success: true)
       render 'storylets/success'
    else
      current_user.save
      @storylet = Storylet.find(last_log.storylet_id)
      render "storylets/#{last_log_status}"
    end
  end

  def change_energy_tick
    unless current_user.last_energy_tick
      current_user.last_energy_tick = 1.second.ago
      current_user.energy = max_energy
      current_user.favor = 0
    end

    if minutes_since_last_tick > time_between_ticks
      current_user.energy += owed_energy
      current_user.last_energy_tick = minutes_since_last_tick.remainder(time_between_ticks).abs.round(0).minutes.ago
    end
    current_user.energy = max_energy if current_user.energy > max_energy
    current_user.save
  end

  def per_turn_actions
    current_user.energy = (current_user.energy || max_energy) - 1
    amount_added = if @storylet.has_challenge? then @storylet.challenge_level else 1 end
    new_amount = favor.level + amount_added
    favor.update_attribute(:level, new_amount)
    favor.save
    current_user.save
  end

  def action
    @storylet = Storylet.find(params[:id])

    MyQuality.check_triggers(current_user)

    change_energy_tick

    if !last_log or last_log.leads_to(@storylet)

      if @storylet.has_challenge
        render 'storylets/action'
      else
        redirect_to "/storylets/#{params[:id]}/success/#{log_code}"
      end
    else
      current_user.save
      @storylet = Storylet.find(last_log.storylet_id)
      render "storylets/#{last_log_status}"
    end
  end

  def success
    @storylet = Storylet.find(params[:id])
    if last_log and last_log.leads_to(@storylet)  and log_code == params[:created_at]
      per_turn_actions
      PlayerLog.create!(user_id: current_user.id, storylet_id: @storylet.id, success: true)
      @storylet.update_user_qualities(true, current_user)
    else
      MyQuality.check_triggers(current_user)
      @storylet = Storylet.find(last_log.storylet_id)
      render "storylets/#{last_log_status}"
    end
  end

  def failure
    @storylet = Storylet.find(params[:id])
    if last_log.leads_to(@storylet)  and log_code == params[:created_at]
      per_turn_actions
      PlayerLog.create!(user_id: current_user.id, storylet_id: @storylet.id, success: false)
      @storylet.update_user_qualities(false, current_user)
      render 'storylets/failure'
    else
      MyQuality.check_triggers(current_user)
      @storylet = Storylet.find(last_log.storylet_id)
      render "storylets/#{last_log_status}"
    end
  end
end
