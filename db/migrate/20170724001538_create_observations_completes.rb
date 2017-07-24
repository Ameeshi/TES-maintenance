class CreateObservationsCompletes < ActiveRecord::Migration[5.0]
  def change
    create_table :observations_completes do |t|
      t.text :final_comments
      t.boolean :completed
      t.integer :observation_id

      t.timestamps
    end
  end
end
