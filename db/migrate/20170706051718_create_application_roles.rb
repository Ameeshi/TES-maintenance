class CreateApplicationRoles < ActiveRecord::Migration[5.0]
  def up
    ['admin', 'specialist', 'manager', 'principal', 'teacher', 'default'].each do |role_name|
      Role.create! name: role_name
    end
  end
  def down
    Role.where(name: ['admin', 'specialist', 'manager', 'principal', 'teacher', 'default']).destroy_all
  end
end
