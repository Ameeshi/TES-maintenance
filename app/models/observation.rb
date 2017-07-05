class Observation < ApplicationRecord
  # Relationships
  belongs_to :classroom
  belongs_to :principal, class_name: "User"
  belongs_to :specialist, class_name: "User"
  
  # Scopes
#  scope :active,           -> { where(active: true) }
#  scope :inactive,         -> { where(active: false) }
  
  # Validations
  validates_presence_of :specialist_id, :classroom_id
  
  
end
