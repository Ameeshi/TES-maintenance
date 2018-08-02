class AddStrengthsAndWeaknessesAndRecommendationsToObservationsAssessment < ActiveRecord::Migration[5.0]
  def change
    add_column :observations_assessments, :strengths, :text
    add_column :observations_assessments, :weaknesses, :text
    add_column :observations_assessments, :recommendations, :text
  end
end
