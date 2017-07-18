class Observations::Plan < ApplicationRecord
  # Relationships
  belongs_to :observation
  
  # Questions
  enum questiona: [ :not_observed, :no_relation, :shows_progress, :meets_standard, :exceeds_standard ], _prefix: "a-"
  enum questionb: [ :not_observed, :no_relation, :shows_progress, :meets_standard, :exceeds_standard ], _prefix: "b-"
  enum questionc: [ :not_observed, :no_relation, :shows_progress, :meets_standard, :exceeds_standard ], _prefix: "c-"
  enum questiond: [ :not_observed, :no_relation, :shows_progress, :meets_standard, :exceeds_standard ], _prefix: "d-"
  
  def planResults
    results = [0,0,0,0,0]
    
    not_observed = 0
    no_relation = 0
    shows_progress = 0
    meets_standard = 0
    exceeds_standard = 0
    
    
    
    return [
      not_observed,
      no_relation,
      shows_progress,
      meets_standard,
      exceeds_standard
    ]
  end
end
