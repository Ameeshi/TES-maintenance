class CreateObservationsActivities < ActiveRecord::Migration[5.0]
  def change
    create_table :observations_activities do |t|
      t.integer :questiona
      t.integer :questionb
      t.integer :questionc
      t.integer :questiond
      t.integer :questione
      t.integer :observation_id

      t.timestamps
    end
  end
end
