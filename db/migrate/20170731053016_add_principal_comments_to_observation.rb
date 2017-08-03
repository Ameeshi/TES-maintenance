class AddPrincipalCommentsToObservation < ActiveRecord::Migration[5.0]
  def change
    add_column :observations, :principal_comments, :text
  end
end
