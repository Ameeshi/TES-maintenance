class AddStrengthsAndWeaknessesAndRecommendationsToObservationsPresentation < ActiveRecord::Migration[5.0]
  def change
    add_column :observations_presentations, :strengths, :text
    add_column :observations_presentations, :weaknesses, :text
    add_column :observations_presentations, :recommendations, :text
  end
end
