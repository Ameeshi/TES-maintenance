class TrainingSessionsController < ApplicationController
  before_action :set_training_session, only: [:show, :edit, :update, :destroy]
  load_and_authorize_resource

  # GET /training_sessions
  # GET /training_sessions.json
  def index
    @training_sessions = TrainingSession.all
  end

  # GET /training_sessions/1
  # GET /training_sessions/1.json
  def show
  end

  # GET /training_sessions/new
  def new
    @training_session = TrainingSession.new
  end

  # GET /training_sessions/1/edit
  def edit
  end

  # POST /training_sessions
  # POST /training_sessions.json
  def create
    @training_session = TrainingSession.new(training_session_params)

    respond_to do |format|
      if @training_session.save
        format.html { redirect_to @training_session, notice: 'Training session was successfully created.' }
        format.json { render :show, status: :created, location: @training_session }
      else
        format.html { render :new }
        format.json { render json: @training_session.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /training_sessions/1
  # PATCH/PUT /training_sessions/1.json
  def update
    respond_to do |format|
      if @training_session.update(training_session_params)
        format.html { redirect_to @training_session, notice: 'Training session was successfully updated.' }
        format.json { render :show, status: :ok, location: @training_session }
      else
        format.html { render :edit }
        format.json { render json: @training_session.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /training_sessions/1
  # DELETE /training_sessions/1.json
  def destroy
    @training_session.destroy
    respond_to do |format|
      format.html { redirect_to training_sessions_url, notice: 'Training session was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_training_session
      @training_session = TrainingSession.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def training_session_params
      params.require(:training_session).permit(:user_id, :training_id, :is_leader)
    end

  protected 
  
  rescue_from CanCan::AccessDenied do |exception|
    if user_signed_in?
      flash[:error] = "Trainings coming soon."
      redirect_to root_path
    else
      flash[:error] = "Please Sign in"
      redirect_to new_user_session_path
    end
  end
end
