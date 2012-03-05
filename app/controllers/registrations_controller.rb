class RegistrationsController < Devise::RegistrationsController

  def create
    build_resource
    @user = resource
    @user.update_attribute(:player, true)

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
    session[:omniauth] = nil unless @user.new_record?
  end

  private

  def build_resource(*args)
    super
    if session[:omniauth]
      @user.apply_omniauth(session[:omniauth])
      @user.valid?
    end
  end
end
