class CreateSchools < ActiveRecord::Migration[5.0]
  def change
    create_table :schools do |t|
      t.integer :principal_id
      t.string :name
      t.string :state
      t.boolean :active

      t.timestamps
    end
  end
end
