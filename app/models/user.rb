class User < ApplicationRecord
  rolify
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable
  
  # Validations
  validates :username, :presence => true, :uniqueness => { :case_sensitive => false }
  validates_format_of :username, with: /^[a-zA-Z0-9_\.]*$/, :multiline => true
  validate :validate_username


  # Scopes
#  scope :for_school, joins(:schools).where(company_types: { name: 'customer' })
#    ->(school_id) { where(school_id: school_id) }
  
  
  # Login with username or email
  attr_accessor :login
  
  def self.find_for_database_authentication(warden_conditions)
    conditions = warden_conditions.dup
    if login = conditions.delete(:login)
      where(conditions.to_h).where(["lower(username) = :value OR lower(email) = :value", { :value => login.downcase }]).first
    elsif conditions.has_key?(:username) || conditions.has_key?(:email)
      conditions[:email].downcase! if conditions[:email]
      where(conditions.to_h).first
    end
  end
  
  # Functions
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
  
  private
  
  def validate_username
    if User.where(email: username).exists?
      errors.add(:username, :invalid)
    end
  end
  
  
end
