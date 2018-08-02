class Ability
  include CanCan::Ability

  def initialize(user)
    # Define abilities for the passed in user here. For example:
    #
    user ||= User.new # guest user (not logged in)
    
    # ADMIN PERMISSIONS
    if user.has_role? :admin
      can :manage, :all
    
    # SPECIALIST PERMISSIONS
    elsif user.has_role? :specialist
      # User Permissions
      can [:show], User
      can [:teachers, :principals], User
      
      # School Permissions
      can :read, School
      
      # Classroom Permissions
      can :manage, Classroom
      
      # Observation Permissions
      can :manage, Observation
      
#      # Training Permissions
#      can :manage, Training
#      
#      # TrainingSession Permissions
#      can :read, TrainingSession
    
    # MANAGER PERMISSIONS
    elsif user.has_role? :manager
      # User Permissions
      can [:show], User
      can [:teachers, :principals, :specialists], User
      
      # School Permissions
      can :read, School
      
      # Classroom Permissions
      can :read, Classroom
      
      # Observation Permissions
      can :read, Observation
      
#      # Training Permissions
#      can :read, Training
#      
#      # TrainingSession Permissions
#      can :read, TrainingSession
    
    # PRINCIPAL PERMISSIONS
    elsif user.has_role? :principal
      # User Permissions
      can [:show], User, :id => user.id
      
      ### Principal's teachers page loads specific teachers in controller
      can [:teachers], User
      
      # Observation Permissions
      can :index, Observation
      
      # Permissions based on if they are assigned a school
      if !user.p_school.nil?
        # User
        ### Principals can access teacher accounts from their school
        can [:show], User do |u|
          user.p_school.teachers.include?(u)
        end
        
        # Classroom
        can :manage, Classroom, :school => user.p_school
        
        # Observation
        can :manage, Observation, :school => user.p_school, :specialist => nil
        can [:show, :edit, :update], Observation, :school => user.p_school
        
        # School
        can [:show], School, :id => user.p_school.id
      end

#      # Training Permissions
#      can :read, Training
#      
#      # TrainingSession Permissions
#      can :read, TrainingSession, :user => user
      
    # TEACHER PERMISSIONS
    elsif user.has_role? :teacher
      # User Permissions
      can [:show], User, :id => user.id
      
      # Classroom Permissions
      can :read, Classroom, :teacher => user
      
      # Observation Permissions
      can :read, Observation, :teacher => user
      
#      # Training Permissions
#      can :read, Training
#      
#      # TrainingSession Permissions
#      can :read, TrainingSession, :user => user
      
    # DEFAULT PERMISSIONS
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
