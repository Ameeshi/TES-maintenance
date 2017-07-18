class Observation < ApplicationRecord
  # Relationships
  belongs_to :classroom
  belongs_to :principal, class_name: "User", optional: true
  belongs_to :specialist, class_name: "User"
  
  # Category Relationships
  has_one :plan, class_name: 'Observations::Plan'
  has_one :presentation, class_name: 'Observations::Presentation'
  has_one :activity, class_name: 'Observations::Activity'
  has_one :assessment, class_name: 'Observations::Assessment'
  has_one :climate, class_name: 'Observations::Climate'
  
  # Scopes
#  scope :active,           -> { where(active: true) }
#  scope :inactive,         -> { where(active: false) }
  
  # Validations
  validates_presence_of :specialist_id, :classroom_id
  validate :principal_is_principal, on: :create
  validate :specialist_is_specialist, on: :create
  
  def result_array
    
    
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
