class RegistrationsController < Devise::RegistrationsController

  def create
    @user = build_resource

    @user.player= true

    if @user.save
      @storylet = Storylet.find_by_title('Zeroth storylet')
      PlayerLog.create(user: @user, storylet_id: @storylet.id)
      @user.update_permissions(params)
      @user.offer_code= ''
      @user.save
      sign_in(resource_name, resource)
      render 'storylets/success'
    else

      clean_up_passwords resource
      respond_with resource
    end
  end

  #
  #  if resource.save
  #    if resource.active_for_authentication?
  #      set_flash_message :notice, :signed_up if is_navigational_format?
  #      sign_in(resource_name, resource)
  #      respond_with resource, :location => after_sign_up_path_for(resource)
  #    else
  #      set_flash_message :notice, :"signed_up_but_#{resource.inactive_message}" if is_navigational_format?
  #      expire_session_data_after_sign_in!
  #      respond_with resource, :location => after_inactive_sign_up_path_for(resource)
  #    end
  #  else
  #    clean_up_passwords resource
  #    respond_with resource
  #  end
  #end




  protected

end
