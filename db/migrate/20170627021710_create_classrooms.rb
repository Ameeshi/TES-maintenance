class CreateClassrooms < ActiveRecord::Migration[5.0]
  def change
    create_table :classrooms do |t|
      t.integer :teacher_id
      t.integer :school_id
      t.string :grade
      t.string :content_area
      t.boolean :active

      t.timestamps
    end
  end
end
