class Observations::Plan < ApplicationRecord
  # Relationships
  belongs_to :observation
  
  # Questions
  enum questiona: [ :not_observed, :no_relation, :shows_progress, :meets_standard, :exceeds_standard ], _prefix: "a-"
  enum questionb: [ :not_observed, :no_relation, :shows_progress, :meets_standard, :exceeds_standard ], _prefix: "b-"
  enum questionc: [ :not_observed, :no_relation, :shows_progress, :meets_standard, :exceeds_standard ], _prefix: "c-"
  enum questiond: [ :not_observed, :no_relation, :shows_progress, :meets_standard, :exceeds_standard ], _prefix: "d-"
  
  def planResults
    
#   not_observed, no_relation, shows_progress, meets_standard, exceeds_standard
    results = [0,0,0,0,0]
    
    a = Observations::Plan.questionas[self.questiona]
    b = Observations::Plan.questionbs[self.questionb]
    c = Observations::Plan.questioncs[self.questionc]
    d = Observations::Plan.questionds[self.questiond]
    
    results[a] += 1
    results[b] += 1
    results[c] += 1
    results[d] += 1

    return results
  end
end
