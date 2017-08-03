class CreateObservations < ActiveRecord::Migration[5.0]
  def change
    create_table :observations do |t|
      t.integer :classroom_id
      t.integer :specialist_id
      t.integer :principal_id
      t.string :comments

      t.timestamps
    end
  end
end
