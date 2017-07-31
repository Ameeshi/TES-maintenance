class ObservationsController < ApplicationController
  before_action :set_observation, only: [:show, :edit, :update, :destroy]
  authorize_resource

  # GET /observations
  # GET /observations.json
  def index
#    authorize! :index, Observation
    if current_user.has_role? :teacher
      @observations = Observation.for_teacher(current_user).complete.most_recent.filter(params.slice(:active, :for_school, :for_content_area, :for_grade, :for_school_year, :teacher_search)).paginate(:page => params[:page], :per_page => 10)
    elsif current_user.has_role? :principal
      if !current_user.p_school.nil?
        @observations = Observation.for_school(current_user.p_school).most_recent.filter(params.slice(:active, :for_school, :for_content_area, :for_grade, :for_school_year, :teacher_search)).paginate(:page => params[:page], :per_page => 10)
      else
        flash[:error] = "You are not currently assigned to a school"
        redirect_to root_url
      end
    elsif current_user.has_role? :specialist
      @observations = Observation.for_specialist(current_user).most_recent.filter(params.slice(:active, :for_school, :for_content_area, :for_grade, :for_school_year, :teacher_search)).paginate(:page => params[:page], :per_page => 10)
    else
      @observations = Observation.most_recent.filter(params.slice(:active, :for_school, :for_content_area, :for_grade, :for_school_year, :teacher_search)).paginate(:page => params[:page], :per_page => 10)
    end
    
    # School Year Dropdown list
    current_year = Date.current.year
    if Date.current < Date.new(current_year,7,1)
      latest_year = current_year-1
    else
      latest_year = current_year
    end
    
    @year_list = []
    while latest_year >= 2009
      @year_list.push("#{latest_year}-#{latest_year+1}")
      latest_year-=1
    end
    
    @schools = School.active
  end

  # GET /observations/1
  # GET /observations/1.json
  def show
    @classroom = @observation.classroom
    @teacher = @classroom.teacher
#    authorize! :show, @observation
  end

  # GET /observations/new
  def new
#    authorize! :new, Observation
    @observation = Observation.new
    if !params[:classroom].nil?
      @classroom =  Classroom.find(params[:classroom])
      @principals = User.with_role(:principal)
    else
      flash[:error] = "You must access this page from a teacher's classroom."
      redirect_to root_url
    end
  end

  # GET /observations/1/edit
  def edit
    @classroom =  @observation.classroom
    @principals = User.with_role(:principal)
#    authorize! :edit, @observation
  end

  # POST /observations
  # POST /observations.json
  def create
#    authorize! :create, Observation
    @observation = Observation.new(observation_params)
    @classroom =  @observation.classroom
    @principals = User.with_role(:principal)
    @observation.specialist_id = current_user.id
    
    respond_to do |format|
      if @observation.save
        format.html { redirect_to observation_observation_form_index_url(@observation), notice: 'Observation was started.' }
        format.json { render :show, status: :created, location: @observation }
      else
        format.html { render :new }
        format.json { render json: @observation.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /observations/1
  # PATCH/PUT /observations/1.json
  def update
#    authorize! :update, current_user
    @classroom =  @observation.classroom
    @principals = User.with_role(:principal)
    respond_to do |format|
      if @observation.update(observation_params)
        format.html { redirect_to @observation, notice: 'Observation was successfully updated.' }
        format.json { render :show, status: :ok, location: @observation }
      else
        format.html { render :edit }
        format.json { render json: @observation.errors, status: :unprocessable_entity }
      end
    end
  end
  

  # DELETE /observations/1
  # DELETE /observations/1.json
  def destroy
    @classroom = @observation.classroom
    @observation.destroy
    respond_to do |format|
      format.html { redirect_to classroom_path(@classroom), notice: 'Observation was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_observation
      @observation = Observation.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def observation_params
      params.require(:observation).permit(:classroom_id, :specialist_id, :principal_id, :comments, :observation_date, :complete, :principal_comments)
    end
end
