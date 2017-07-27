class UsersController < ApplicationController
  
  def teachers
    if current_user.has_role?(:principal)
      if !current_user.p_school.nil?
        @teachers = current_user.p_school.teachers.alphabetical.paginate(:page => params[:page], :per_page => 5)
      else
        flash[:error] = "You are not currently assigned to a school"
        redirect_to root_url
      end
    else
      @teachers = User.with_role(:teacher).alphabetical.paginate(:page => params[:page], :per_page => 5)
    end
    authorize! :teachers, current_user
  end
  
  def principals
    @principals = User.with_role(:principal).alphabetical.paginate(:page => params[:page], :per_page => 5)
    authorize! :principals, current_user
  end
  
  def specialists
    @specialists = User.with_role(:specialist).alphabetical.paginate(:page => params[:page], :per_page => 5)
    authorize! :specialists, current_user
  end
  
  def index
    @users = User.all.alphabetical.paginate(:page => params[:page], :per_page => 5)
    authorize! :index, current_user
  end
  
  def show
    @user = User.find_by_username(params[:id])
    
    if @user.has_role?(:teacher)
      # Most recent observation. Called Observation for partials
      @observation = @user.t_observations.complete.most_recent.first
      @active_classrooms = @user.classrooms.active.paginate(:page => params[:active], :per_page => 5)
      @inactive_classrooms = @user.classrooms.inactive.paginate(:page => params[:inactive], :per_page => 5)
      

#     If too much for server, comment out from here...
      if !@user.t_observations.empty?
        @result_array = @user.teacher_results(@user.t_observations.active)
        @total_result_array = @user.total_teacher_results(@result_array)
      else
        @result_array = [[0,0,0,0,0],[0,0,0,0,0],[0,0,0,0,0],[0,0,0,0,0],[0,0,0,0,0]]
        @total_result_array = [0,0,0,0,0]
      end
#     ...to here
    end
    
    if @user.has_role?(:specialist)
      @observations = @user.s_observations
    end
    
    authorize! :show, @user
  end
end
