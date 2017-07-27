class SchoolsController < ApplicationController
  before_action :set_school, only: [:show, :edit, :update, :destroy]
  load_and_authorize_resource

  # GET /schools
  # GET /schools.json
  def index
    @active_schools = School.active.alphabetical.all
    @inactive_schools = School.inactive.alphabetical.all
  end

  # GET /schools/1
  # GET /schools/1.json
  def show
    @teachers = @school.teachers.paginate(:page => params[:page], :per_page => 5)
    
    if params[:for_school_year].nil?
      @observations = @school.observations.this_school_year
    else
      @observations = @school.observations.filter(params.slice(:for_school_year))
    end
    
#     If too much for server, comment out from here...
    if !@observations.empty?
      @result_array = @school.school_results(@observations)
      @total_result_array = @school.total_school_results(@result_array)
    else
      @result_array = [[0,0,0,0,0],[0,0,0,0,0],[0,0,0,0,0],[0,0,0,0,0],[0,0,0,0,0]]
      @total_result_array = [0,0,0,0,0]
    end
#     ...to here
    
    
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
      
    
  end

  # GET /schools/new
  def new
    @school = School.new
    @principals = User.with_role(:principal)
  end

  # GET /schools/1/edit
  def edit
    @principals = User.with_role(:principal)
  end

  # POST /schools
  # POST /schools.json
  def create
    @school = School.new(school_params)
    @principals = User.with_role(:principal)

    respond_to do |format|
      if @school.save
        format.html { redirect_to @school, notice: 'School was successfully created.' }
        format.json { render :show, status: :created, location: @school }
      else
        format.html { render :new }
        format.json { render json: @school.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /schools/1
  # PATCH/PUT /schools/1.json
  def update
    @principals = User.with_role(:principal)
    respond_to do |format|
      if @school.update(school_params)
        format.html { redirect_to @school, notice: 'School was successfully updated.' }
        format.json { render :show, status: :ok, location: @school }
      else
        format.html { render :edit }
        format.json { render json: @school.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /schools/1
  # DELETE /schools/1.json
  def destroy
    @school.destroy
    respond_to do |format|
      format.html { redirect_to schools_url, notice: 'School was successfully deactivated/destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_school
      @school = School.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def school_params
      params.require(:school).permit(:principal_id, :name, :state, :active)
    end
end
