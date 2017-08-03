class AddCompletedAndObservationDateToObservation < ActiveRecord::Migration[5.0]
  def change
    add_column :observations, :completed, :boolean, default: false
    add_column :observations, :observation_date, :date
  end
end
