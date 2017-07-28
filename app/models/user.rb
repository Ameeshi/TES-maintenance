class User < ApplicationRecord
  rolify
  include Filterable
  
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable
  
  # Relationships
  has_many :classrooms, :foreign_key => :teacher_id
  
  has_many :t_schools, through: :classrooms, source: :school, class_name: "School"
  has_one :p_school, :foreign_key => :principal_id, class_name: "School"
  
  has_many :t_observations, through: :classrooms, source: :observations, class_name: "Observation"
  has_many :p_observations, :foreign_key => :principal_id, class_name: "Observation"
  has_many :s_observations, :foreign_key => :specialist_id, class_name: "Observation"
  
  has_many :training_sessions
  has_many :trainings, through: :training_sessions
  
  # Validations
  validates :username, presence: true, :uniqueness => { :case_sensitive => false }
  validates_format_of :username, with: /^[a-zA-Z0-9_\.]*$/, :multiline => true
  validate :validate_username


  # Scopes
  scope :alphabetical,  -> { order(:last_name, :first_name ) }
  scope :name_search,   -> (name) { where("CONCAT_WS(' ', first_name, last_name) LIKE ?", "%#{name}%") }
  
  
  
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
  
  def list_name
    return last_name + ', ' + first_name
  end
  
  # Teacher Functions
  
  # Returns the individual sections
  def teacher_results(observation_list=nil)
#   not_observed, no_relation, shows_progress, meets_standard, exceeds_standard
#         For Plan,        Presentation, Activity, Assessment, Climate
    results = [[0,0,0,0,0],[0,0,0,0,0],[0,0,0,0,0],[0,0,0,0,0],[0,0,0,0,0]]
    
    if !observation_list.nil?
      observations = observation_list
    else
      observations = t_observations
    end
    
    observations.each do |observation|
      observationResults = observation.results
      
      (0..4).each do |i|
        (0..4).each do |j|
          results[i][j] += observationResults[i][j]
        end
      end
    end
    return results
  end

  # Returns the totals for the polar chart
  def total_teacher_results(result_array)
#   not_observed, no_relation, shows_progress, meets_standard, exceeds_standard
    results = [0,0,0,0,0]
    
    if !result_array.nil?
      (0..4).each do |i|
        (0..4).each do |j|
          results[j] += result_array[i][j]
        end
      end
    end
    
    return results
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
