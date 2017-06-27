class CreateTrainingSessions < ActiveRecord::Migration[5.0]
  def change
    create_table :training_sessions do |t|
      t.integer :user_id
      t.integer :training_id
      t.boolean :is_leader

      t.timestamps
    end
  end
end
