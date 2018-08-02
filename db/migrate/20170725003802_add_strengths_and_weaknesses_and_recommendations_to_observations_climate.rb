class AddStrengthsAndWeaknessesAndRecommendationsToObservationsClimate < ActiveRecord::Migration[5.0]
  def change
    add_column :observations_climates, :strengths, :text
    add_column :observations_climates, :weaknesses, :text
    add_column :observations_climates, :recommendations, :text
  end
end
