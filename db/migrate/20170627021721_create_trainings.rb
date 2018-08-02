class CreateTrainings < ActiveRecord::Migration[5.0]
  def change
    create_table :trainings do |t|
      t.string :title
      t.string :location
      t.date :start_date
      t.date :end_date
      t.string :description

      t.timestamps
    end
  end
end
