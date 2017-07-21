class Observation < ApplicationRecord
  # Relationships
  belongs_to :classroom
  belongs_to :principal, class_name: "User", optional: true
  belongs_to :specialist, class_name: "User"
  has_one :teacher, through: :classroom, class_name: "User"
  
  # Category Relationships
  has_one :plan, class_name: 'Observations::Plan'
  has_one :presentation, class_name: 'Observations::Presentation'
  has_one :activity, class_name: 'Observations::Activity'
  has_one :assessment, class_name: 'Observations::Assessment'
  has_one :climate, class_name: 'Observations::Climate'
  
  # Scopes
#  scope :active,           -> { where(active: true) }
#  scope :inactive,         -> { where(active: false) }
  scope :for_content_area, ->(content_area) { joins(:classroom).where(classrooms: {content_area: content_area}) }
  scope :for_grade,        ->(grade) { includes(:classrooms).where(classrooms: {grade: grade}) }
  scope :for_teacher,      ->(teacher_id) { where(teacher_id: teacher_id) }
  
  # Validations
  validates_presence_of :specialist_id, :classroom_id
  validate :principal_is_principal, on: :create
  validate :specialist_is_specialist, on: :create
  
  
  # Funtions to sum data in single observation
  # It uses the sum functions for the individual pieces and adds to a result
  def results
#   not_observed, no_relation, shows_progress, meets_standard, exceeds_standard
    results = [0,0,0,0,0]
    
    (0..4).each do |i|
      results[i] += plan.planResults[i] 
      results[i] += presentation.presentationResults[i] 
      results[i] += activity.activityResults[i] 
      results[i] += assessment.assessmentResults[i] 
      results[i] += climate.climateResults[i]
    end
  
    return results
  end
  
  
  
  private
  
  def principal_is_principal
    return true if ((self.principal.nil?) || (self.principal.has_role? :principal))
    errors.add(self.principal.name, "is not a principal.")
  end
  
  def specialist_is_specialist
    return true if ((self.specialist.nil?) || (self.specialist.has_role? :specialist))
    errors.add(self.specialist.name, "is not a specialist.")
  end
  
end
