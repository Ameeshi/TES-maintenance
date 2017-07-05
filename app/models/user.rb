class User < ApplicationRecord
  rolify
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable
  
  # Scopes
  
  ############ Role methods ############
  # Shouldn't be necessary because no one should have more than
  # one role, but it's a safeguard
  def highestRole
    if self.has_role? :admin
      return 'Admin'
    elsif self.has_role? :specialist
      return 'Specialist'
    elsif self.has_role? :manager
      return 'Manager'
    elsif self.has_role? :principal
      return 'Principal'
    elsif self.has_role? :teacher
      return 'Teacher'
    else
      # Should never be none when used
      return 'None'
    end
  end
  
  
end
