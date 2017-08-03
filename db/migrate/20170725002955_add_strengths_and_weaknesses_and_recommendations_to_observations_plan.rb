class AddStrengthsAndWeaknessesAndRecommendationsToObservationsPlan < ActiveRecord::Migration[5.0]
  def change
    add_column :observations_plans, :strengths, :text
    add_column :observations_plans, :weaknesses, :text
    add_column :observations_plans, :recommendations, :text
  end
end
