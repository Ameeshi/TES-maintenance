class AddStrengthsAndWeaknessesAndRecommendationsToObservationsActivity < ActiveRecord::Migration[5.0]
  def change
    add_column :observations_activities, :strengths, :text
    add_column :observations_activities, :weaknesses, :text
    add_column :observations_activities, :recommendations, :text
  end
end
