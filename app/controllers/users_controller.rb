class UsersController < ApplicationController
  
  def teachers
    
    if current_user.has_role?(:principal)
      if !current_user.p_school.nil?
        @teachers = current_user.p_school.teachers.active.alphabetical.filter(params.slice(:name_search, :for_grade, :for_content_area)).paginate(:page => params[:page], :per_page => 10)
      else
        flash[:error] = "You are not currently assigned to a school"
        redirect_to root_url
      end
    else
      @schools = School.active
      
      @teachers = User.with_role(:teacher).active.alphabetical.filter(params.slice(:name_search, :for_school, :for_grade, :for_content_area)).paginate(:page => params[:page], :per_page => 10)
    end
    authorize! :teachers, current_user
  end
  
  def principals
    @principals = User.with_role(:principal).active.alphabetical.paginate(:page => params[:page], :per_page => 10)
    authorize! :principals, current_user
  end
  
  def specialists
    @specialists = User.with_role(:specialist).active.alphabetical.paginate(:page => params[:page], :per_page => 10)
    authorize! :specialists, current_user
  end
  
  def inactive
    @users = User.inactive.alphabetical.filter(params.slice(:name_search)).paginate(:page => params[:page], :per_page => 10)
    authorize! :inactive, current_user
  end
  
  def index
    @users = User.active.alphabetical.filter(params.slice(:name_search)).paginate(:page => params[:page], :per_page => 10)
    authorize! :index, current_user
  end
  
  def show
    @user = User.find_by_username(params[:id])
    
    if @user.nil?
      redirect_to root_path, alert: "User doesn't exist."
    else
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
      
      if @user.has_role?(:principal)
        @observations = @user.p_observations
      end
    end
    
    authorize! :show, @user
  end
  
  # ADMIN COMMANDS
  
  def edit
    @user = User.find_by_username(params[:id])
    authorize! :manage, @user
  end
  
  def update
    @user = User.find_by_username(params[:id])
    authorize! :manage, @user
    
    if !current_user.has_role?(:admin)
      redirect_to root_url, alert: "Only admins allowed."
    else
      if @user.update(user_params)
        # Change Role
        if !params[:role].blank?
          if !User::ROLES_LIST.include?(params[:role])
            redirect_to root_path, alert: 'Please Stop.'
          else
            if @user.highestRole != params[:role]
              # If principal, take away from school
              if @user.highestRole == 'principal'
                @user.p_school = nil
              end
              # Ensures only one role
              @user.roles=[]
              @user.grant(params[:role])
            end
          end
        end
        respond_to do |format|
          format.html { redirect_to user_path(@user.username), notice: "User updated." }  
        end
          
      else
        render 'edit'
      end
    end
  end

  
  ### Should actually make this only deactivate...
  def destroy
    @user = User.find_by_username(params[:id])
    authorize! :manage, @user
    
    if !current_user.has_role?(:admin)
      redirect_to root_url, alert: "Only admins allowed."
    else
      

      respond_to do |format|
        if @user.destroy
          format.html { redirect_to root_url, notice: "User deleted." }   
        else
          format.html { redirect_to user_path(@user.username), notice: "User deactivated." }   
        end
      end
    end
  end
  
  def reactivate_user
    @user = User.find_by_username(params[:id])
    @user.update_attributes(active: true)
    redirect_to user_path(@user.username), notice: "User reactivated."
  end
  
  # Never trust parameters from the scary internet, only allow the white list through.
  def user_params
    params.require(:user).permit(:first_name, :last_name, :username, :email)
  end
end
