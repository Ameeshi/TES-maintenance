class Ability
  include CanCan::Ability

  def initialize(user)
    # Define abilities for the passed in user here. For example:
    #
    user ||= User.new # guest user (not logged in)
    if user.has_role? :admin
      can :manage, :all
    elsif user.has_role? :specialist
      # User Permissions
      can [:teachers, :principals], User
#      can :read, User, :with_role => (:teacher)
    elsif user.has_role? :manager
      # User Permissions
      can [:teachers, :principals, :specialists], User
      can :read, :all
    elsif user.has_role? :principal
      # User Permissions
      can [:show], User, :id => user.id
      ### Principals can access teacher accounts from their school
      can [:show], User do |u|
        user.p_school.teachers.include?(u)
      end
      ### Principal's teachers page loads specific teachers in controller
      can [:teachers], User
      
      # School Permissions
      can [:show], School, :id => user.p_school.id
      
    elsif user.has_role? :teacher
      # User Permissions
      can [:show], User, :id => user.id
      
      can [:show], Observation, :teacher => user
    else # Default Case
      can [:show], User, :id => user.id
    end
    #
    # The first argument to `can` is the action you are giving the user
    # permission to do.
    # If you pass :manage it will apply to every action. Other common actions
    # here are :read, :create, :update and :destroy.
    #
    # The second argument is the resource the user can perform the action on.
    # If you pass :all it will apply to every resource. Otherwise pass a Ruby
    # class of the resource.
    #
    # The third argument is an optional hash of conditions to further filter the
    # objects.
    # For example, here the user can only update published articles.
    #
    #   can :update, Article, :published => true
    #
    # See the wiki for details:
    # https://github.com/CanCanCommunity/cancancan/wiki/Defining-Abilities
  end
end
