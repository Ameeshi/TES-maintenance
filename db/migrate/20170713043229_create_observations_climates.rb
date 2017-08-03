class CreateObservationsClimates < ActiveRecord::Migration[5.0]
  def change
    create_table :observations_climates do |t|
      t.integer :questiona
      t.integer :questionb
      t.integer :questionc
      t.integer :observation_id

      t.timestamps
    end
  end
end
