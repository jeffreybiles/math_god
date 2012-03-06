class Ability
  include CanCan::Ability

  def initialize(user)
     user ||= User.new
     if user.admin?
       can :manage, :all
     elsif user.player? or user.contributor?
       can [:special_storylets, :storylet_show], PlayerLog
       can [:action, :success, :failure, :travel], Storylet
       can [:update, :show_mine, :my_gods], MyQuality do |this_quality|
         this_quality.user_id == user.id
       end
       can :manage, User do |this_user|
         this_user.id == user.id
       end
       can [:create, :second_step, :display_second_step], User
       can [:create, :intro_page], UserSession
       can :destroy, UserSession do |this_session|
         this_session == current_user_session
       end
       can [:read, :current_player_log], PlayerLog do |log|
         log.user_id == user.id
       end
       if user.contributor?
         can :manage, Storylet
         can :manage, Universe
         can :manage, Quality
         can :manage, Reward
         can :manage, Requirement
         can :manage, Link
         can :manage, PictureUploader
         can :manage, Image
         can :read, MyQuality
         can :read, PlayerLog
         can :manage, PlayerLog do |log|
           log.user_id == user.id
         end
         can :read, User
       end
     else
       can [:create, :second_step, :display_second_step], User
       can [:create, :intro_page], UserSession
     end
  end



    # The first argument to `can` is the action you are giving the user permission to do.
    # If you pass :manage it will apply to every action. Other common actions here are
    # :read, :create, :update and :destroy.
    #
    # The second argument is the resource the user can perform the action on. If you pass
    # :all it will apply to every resource. Otherwise pass a Ruby class of the resource.
    #
    # The third argument is an optional hash of conditions to further filter the objects.
    # For example, here the user can only update published articles.
    #
    #   can :update, Article, :published => true
    #
    # See the wiki for details: https://github.com/ryanb/cancan/wiki/Defining-Abilities
end
