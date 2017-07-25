class ClassroomsController < ApplicationController
  before_action :set_classroom, only: [:show, :edit, :update, :destroy]
  load_and_authorize_resource

  # GET /classrooms
  # GET /classrooms.json
  def index
    @classrooms = Classroom.all
  end

  # GET /classrooms/1
  # GET /classrooms/1.json
  def show
    @teacher = @classroom.teacher
    if can? :manage, Observation
      @observations = @classroom.observations.most_recent.paginate(:page => params[:page], :per_page => 5)
    else
      @observations = @classroom.observations.complete.most_recent.paginate(:page => params[:page], :per_page => 5)
    end
  end

  # GET /classrooms/new
  def new
    @classroom = Classroom.new
    if !params[:teacher].nil?
      @teacher =  User.find(params[:teacher])
      @schools = School.alphabetical
    else
      flash[:error] = "You must access this page from a teacher's page."
      redirect_to root_url
    end
  end

  # GET /classrooms/1/edit
  def edit
    @teacher =  @classroom.teacher
    @schools = School.alphabetical
  end

  # POST /classrooms
  # POST /classrooms.json
  def create
    @classroom = Classroom.new(classroom_params)
    @teacher =  @classroom.teacher
    @schools = School.alphabetical

    respond_to do |format|
      if @classroom.save
        format.html { redirect_to @classroom, notice: 'Classroom was successfully created.' }
        format.json { render :show, status: :created, location: @classroom }
      else
        format.html { render :new }
        format.json { render json: @classroom.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /classrooms/1
  # PATCH/PUT /classrooms/1.json
  def update
    respond_to do |format|
      if @classroom.update(classroom_params)
        format.html { redirect_to @classroom, notice: 'Classroom was successfully updated.' }
        format.json { render :show, status: :ok, location: @classroom }
      else
        format.html { render :edit }
        format.json { render json: @classroom.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /classrooms/1
  # DELETE /classrooms/1.json
  def destroy
    @classroom.destroy
    respond_to do |format|
      format.html { redirect_to classrooms_url, notice: 'Classroom was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_classroom
      @classroom = Classroom.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def classroom_params
      params.require(:classroom).permit(:teacher_id, :school_id, :grade, :content_area, :active)
    end
end
