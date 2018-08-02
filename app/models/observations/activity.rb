class Observations::Activity < ApplicationRecord
  # Relationships
  belongs_to :observation
  
  # Questions
  enum questiona: [ :not_observed, :no_relation, :shows_progress, :meets_standard, :exceeds_standard ], _prefix: "a-"
  enum questionb: [ :not_observed, :no_relation, :shows_progress, :meets_standard, :exceeds_standard ], _prefix: "b-"
  enum questionc: [ :not_observed, :no_relation, :shows_progress, :meets_standard, :exceeds_standard ], _prefix: "c-"
  enum questiond: [ :not_observed, :no_relation, :shows_progress, :meets_standard, :exceeds_standard ], _prefix: "d-"
  enum questione: [ :not_observed, :no_relation, :shows_progress, :meets_standard, :exceeds_standard ], _prefix: "e-"

  
  def activityResults
    
#   not_observed, no_relation, shows_progress, meets_standard, exceeds_standard
    results = [0,0,0,0,0]
    
    a = Observations::Activity.questionas[self.questiona]
    b = Observations::Activity.questionbs[self.questionb]
    c = Observations::Activity.questioncs[self.questionc]
    d = Observations::Activity.questionds[self.questiond]
    e = Observations::Activity.questiones[self.questione]
    
    results[a] += 1
    results[b] += 1
    results[c] += 1
    results[d] += 1
    results[e] += 1
  
    return results
  end
end
