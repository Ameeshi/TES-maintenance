class Observation < ApplicationRecord
  include Filterable
  
  # Relationships
  belongs_to :classroom
  has_one :school, through: :classroom
  belongs_to :principal, class_name: "User", optional: true
  belongs_to :specialist, class_name: "User"
  has_one :teacher, through: :classroom, class_name: "User"
  
  # Category Relationships
  has_one :plan, class_name: 'Observations::Plan'
  has_one :presentation, class_name: 'Observations::Presentation'
  has_one :activity, class_name: 'Observations::Activity'
  has_one :assessment, class_name: 'Observations::Assessment'
  has_one :climate, class_name: 'Observations::Climate'
  has_one :complete, class_name: 'Observations::Complete'
  
  # Scopes
  scope :most_recent,      -> { order(observation_date: :desc) }
  scope :active,           -> { includes(:classroom).where(:classrooms => { :active => true }) }
  scope :inactive,         -> { includes(:classroom).where(:classrooms => { :active => false }) }
  scope :complete,         -> { where(completed: true) }
  scope :incomplete,       -> { where(completed: false) }
  
  # Variable Scopes
  scope :for_school,       ->(school) { includes(:classroom).where(:classrooms => { school: school }) }
  scope :for_content_area, ->(content_area) { includes(:classroom).where(:classrooms => { :content_area => content_area}) }
  scope :for_grade,        ->(grade) { includes(:classroom).where(:classrooms => {:grade => grade}) }
  scope :for_teacher,      ->(teacher) { includes(:classroom).where(:classrooms => { teacher: teacher }) }
  scope :for_specialist,   ->(specialist) { where(specialist: specialist) }
  
  # Validations
  validates_presence_of :specialist_id, :classroom_id, :observation_date
  validate :principal_is_principal, on: :create
  validate :specialist_is_specialist, on: :create
  
  
  # Funtions to sum data in single observation
  # It uses the sum functions for the individual pieces and adds to a result
  def results
#   not_observed, no_relation, shows_progress, meets_standard, exceeds_standard
#         For Plan,        Presentation, Activity, Assessment, Climate
    results = [[0,0,0,0,0],[0,0,0,0,0],[0,0,0,0,0],[0,0,0,0,0],[0,0,0,0,0]]
    
    # If application Complete (no section is nil)
    if (completed)
      (0..4).each do |i|
        results[0][i] += plan.planResults[i] 
        results[1][i] += presentation.presentationResults[i] 
        results[2][i] += activity.activityResults[i] 
        results[3][i] += assessment.assessmentResults[i] 
        results[4][i] += climate.climateResults[i]
      end
    end
  
    return results
  end
  
  def mark_completed
    update completed: true
  end
  
  def self.valid_date(date)
    years = date.split(/-/)
    year1 = years[0]
    year2 = years[1]
    
    
    return false if (year1.nil? || year2.nil? || year1.length != 4 || year2.length != 4)
    
    year1 = year1.to_i
    year2 = year2.to_i
    current_year = Date.current.year
    
    return false if ((year2 - year1 != 1) || (year1 < 2009) || (year2 > current_year+1)) else return true
  end
  
  def self.this_school_year
    current_year = Date.current.year
    if Date.current < Date.new(current_year,7,1)
      return self.for_school_year ("#{current_year-1}-#{current_year}")
    else
      return self.for_school_year ("#{current_year}-#{current_year+1}")
    end
  end
  
  def self.for_school_year(date)
    
    if !valid_date(date)
      return Observation.this_school_year
    end
    
    years = date.split(/-/)
    year1 = years[0].to_i
    year2 = years[1].to_i
    
    return Observation.where("? <= observation_date AND observation_date < ?", Date.new(year1,7,1), Date.new(year2,7,1))
    
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
