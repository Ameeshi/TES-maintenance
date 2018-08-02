class HomeController < ApplicationController
  def index
    if current_user.has_any_role?(:admin, :specialist, :manager)
      
      @school_count = School.count
      @teacher_count = User.with_role(:teacher).count
      
      if current_user.has_role?(:specialist)
        @observation_count = current_user.s_observations.count
      elsif current_user.has_role?(:admin)
        @observation_count = Observation.count
        @user_count = User.count
      else
        @observation_count = Observation.count
      end
      
      
    end
  end
end
