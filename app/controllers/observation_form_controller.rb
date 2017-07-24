class ObservationFormController < ApplicationController
  layout 'multistep-form'
  
  include Wicked::Wizard
  
  STEPS_WITH_TITLES =
    [ [:plan,            "Lesson Plan"],
      [:presentation,    "Lesson Presentation"],
      [:activity,        "Lesson Activities"],
      [:assessment,      "Assessment and Evaluation"],
      [:climate,         "Classroom Climate"],
      [:complete,        "Final Steps"] ]

  LIST_OF_STEPS = STEPS_WITH_TITLES.map {|step_with_title| step_with_title[0] }


  ########### Manually listing steps so they're easier to categorize ###########
  # Steps that are part of the Observation model
  # Because they just update Observation, the step name doesn't matter
  UPDATE_OBSERVATION = []

  # Steps that Observation has_many of. These will be nested attributes, so the observation is being updated,
  # However, step name and association name must be the same to allow us to dynamically build objects
  CREATE_OR_UPDATE_MANY_CHILDREN = []

  # Steps that Observation has_one of. These steps must match the association name to be created/updated to build dynamically
  CREATE_OR_UPDATE_ONE_CHILD = [:plan, :presentation, :activity, :assessment, :climate, :complete]

  # Not used, but keeping it to help categorize steps
  OTHER_STEPS = []
  
  ### SET LIST OF STEPS FOR WICKED HERE!
  steps *LIST_OF_STEPS
  
  
  def show
    @observation = current_observation

    case step
    when *CREATE_OR_UPDATE_MANY_CHILDREN
      build_has_many_child_if_empty @observation, step
    when *CREATE_OR_UPDATE_ONE_CHILD
      build_has_one_child_if_nil @observation, step
    end
    render_wizard
  end
  
  def update
    @observation = current_observation

    case step
    when *CREATE_OR_UPDATE_ONE_CHILD
      create_or_update_then_render_child @observation, step
    end
  end
  
  private
  
  def current_observation
    # because we're using a nested route, the params are: /fosters/:foster_id/foster_application/:step
    Observation.find(params[:observation_id])
  end
  
  def finish_wizard_path
    current_observation.mark_completed
    observation_path(current_observation)
  end

  
  ######################  Update and Show related methods  ######################

  # For a has_one relationship, build that child if it doesn't exist
  # TODO: check if child_name is a valid method, gracefully fail
  def build_has_one_child_if_nil(parent, child_name)
    child_obj = parent.send(child_name) # equivalent to calling something like @foster.home
    build_attribute_name_template = "build_#{child_name}" # e.g. "build_personal_preference"

    if child_obj.nil?
      # run the dynamic rails method to build a has_one child of the parent model instance
      # e.g. @foster.build_dog_preference
      child_obj = parent.send(build_attribute_name_template)
    end

    return child_obj
  end
  
  # include this comment elsewhere where needed
  # give warning that how this is used, child_name must be both the step and the child model attribute name
  def create_or_update_then_render_child(parent, child_name)
    child_obj = parent.send(child_name)
    attribute_name_params_template = "#{child_name}_params"
    attribute_name_params = send(attribute_name_params_template)

    child_obj = build_has_one_child_if_nil parent, child_name
    child_obj.assign_attributes(attribute_name_params)

    render_wizard child_obj
  end
  
  
  def plan_params
    params.require(:observations_plan).permit(:id, :observation_id, :questiona, :questionb, :questionc, :questiond)
  end
  
  def presentation_params
    params.require(:observations_presentation).permit(:id, :observation_id, :questiona, :questionb, :questionc)
  end
  
  def activity_params
    params.require(:observations_activity).permit(:id, :observation_id, :questiona, :questionb, :questionc, :questiond, :questione)
  end
  
  def assessment_params
    params.require(:observations_assessment).permit(:id, :observation_id, :questiona, :questionb, :questionc, :questiond)
  end
  
  def climate_params
    params.require(:observations_climate).permit(:id, :observation_id, :questiona, :questionb, :questionc)
  end
  
  def complete_params
    params.require(:observations_complete).permit(:id, :observation_id, :final_comments, :completed)
  end
  
end
