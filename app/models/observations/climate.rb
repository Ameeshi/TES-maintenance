class Observations::Climate < ApplicationRecord
  # Relationships
  belongs_to :observation
  
  # Questions
  enum questiona: [ :not_observed, :no_relation, :shows_progress, :meets_standard, :exceeds_standard ]
  enum questionb: [ :not_observed, :no_relation, :shows_progress, :meets_standard, :exceeds_standard ]
  enum questionc: [ :not_observed, :no_relation, :shows_progress, :meets_standard, :exceeds_standard ]
end
