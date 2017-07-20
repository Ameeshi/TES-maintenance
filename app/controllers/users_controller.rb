class UsersController < ApplicationController
  
  def teachers
    if current_user.has_role?(:principal)
      if !current_user.p_school.nil?
        @teachers = current_user.p_school.teachers
      else
        flash[:error] = "You are not currently assigned to a school"
        redirect_to root_url
      end
    else
      @teachers = User.with_role :teacher
    end
    authorize! :teachers, current_user
  end
  
  def principals
    @principals = User.with_role :principal
    authorize! :principals, current_user
  end
  
  def specialists
    @specialists = User.with_role :specialist
    authorize! :specialists, current_user
  end
  
  def index
    @users = User.all
    authorize! :index, current_user
  end
  
  def show
    @user = User.find_by_username(params[:id])
    
    if !@user.t_observations.empty?
      @result_array = @user.teacher_results
    else
      @result_array = [0,0,0,0,0]
    end
    
    authorize! :show, @user
  end
end
