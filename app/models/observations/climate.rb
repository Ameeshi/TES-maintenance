class Observations::Climate < ApplicationRecord
  # Relationships
  belongs_to :observation
  
  # Questions
  enum questiona: [ :not_observed, :no_relation, :shows_progress, :meets_standard, :exceeds_standard ], _prefix: "a-"
  enum questionb: [ :not_observed, :no_relation, :shows_progress, :meets_standard, :exceeds_standard ], _prefix: "b-"
  enum questionc: [ :not_observed, :no_relation, :shows_progress, :meets_standard, :exceeds_standard ], _prefix: "c-"
  
  def climateResults
    
#   not_observed, no_relation, shows_progress, meets_standard, exceeds_standard
    results = [0,0,0,0,0]
    
    a = Observations::Climate.questionas[self.questiona]
    b = Observations::Climate.questionbs[self.questionb]
    c = Observations::Climate.questioncs[self.questionc]
    
    results[a] += 1
    results[b] += 1
    results[c] += 1
  
    return results
  end
end
