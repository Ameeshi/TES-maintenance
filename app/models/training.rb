class Training < ApplicationRecord
  # Relationships
  has_many :training_sessions
  
  # Scopes
  scope :alphabetical,  -> { order(:title) }
  scope :chronological, -> { order(start_date: :desc) }
  
  # Validations
  validates_presence_of :title, :location, :start_date, :description

end
