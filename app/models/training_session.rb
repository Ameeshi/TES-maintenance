class TrainingSession < ApplicationRecord
  # Relationships
  belongs_to :training
  belongs_to :user
  
  # Scopes
  
  
  # Validations
  validates_presence_of :user_id, :training_id, :is_leader
  
end
