class ObservationFormController < ApplicationController
  layout 'multistep-form'
  
  include Wicked::Wizard
  
  STEPS_WITH_TITLES =
    [ [:plan,            "Lesson Plan"],
      [:presentation,    "Lesson Presentation"],
      [:activities,      "Lesson Activities"],
      [:assessment,      "Assessment and Evaluation"],
      [:climate,         "Classroom Climate"] ]

  LIST_OF_STEPS = STEPS_WITH_TITLES.map {|step_with_title| step_with_title[0] }


  ### SET LIST OF STEPS FOR WICKED HERE!
  steps *LIST_OF_STEPS
  
  
  def show
    render_wizard
  end
  
  def update
  end
  
end
