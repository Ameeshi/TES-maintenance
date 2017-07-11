class User < ApplicationRecord
  rolify
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable
  
  # Scopes
#  scope :for_school, joins(:schools).where(company_types: { name: 'customer' })
#    ->(school_id) { where(school_id: school_id) }
  
  
  def name
    return first_name + ' ' + last_name
  end
  
  ############ Role methods ############
  # Shouldn't be necessary because no one should have more than
  # one role, but it's a safeguard
  def highestRole
    if self.has_role? :admin
      return 'admin'
    elsif self.has_role? :specialist
      return 'specialist'
    elsif self.has_role? :manager
      return 'manager'
    elsif self.has_role? :principal
      return 'principal'
    elsif self.has_role? :teacher
      return 'teacher'
    else
      # Should never be default when used
      return 'default'
    end
  end
  
  
end
