class School < ApplicationRecord
  # Get an array of the states in Palau
  # I'm not 100% on what '.freeze' does, but it was at the end of the list which I based this on
  # So if you know, edit as you will
  STATES_LIST = ['Aimeliik', 'Airai', 'Angaur', 'Hatohobei', 'Kayangel', 'Koror', 'Melekeok', 'Ngaraard', 'Ngarchelong', 'Ngardmau', 'Ngeremlengui', 'Ngatpang', 'Ngchesar', 'Ngiwal', 'Peleliu', 'Sonsorol'].freeze

  # Relationships
  has_many :classrooms
  has_many :observations, through: :classrooms
  has_many :teachers, -> { distinct }, through: :classrooms, class_name: "User"
  # Optional because a school won't always have an active principal
  belongs_to :principal, class_name: "User", optional: true

  # Scopes
  scope :alphabetical,  -> { order(:name) }
  scope :active,        -> { where(active: true) }
  scope :inactive,      -> { where(active: false) }
  
  # Validations
  validates_presence_of :name, :state
  validates_inclusion_of :state, in: STATES_LIST.map{|value| value}, message: "is not an option"
#  validates_inclusion_of :state, in: STATES_LIST.to_h.values, message: "is not an option"
  validate :school_is_not_a_duplicate, on: :create
  validate :principal_is_principal, on: [:create, :update]

  def already_exists?
    School.where(name: self.name, state: self.state).size == 1
  end

  # Callbacks
  before_destroy :is_destroyable?
  after_rollback :make_inactive_if_trying_to_destroy

  # Other methods
  attr_reader :destroyable
  
  # Teacher Functions
  
  # Returns the individual sections
  def school_results(observation_list=nil)
#   not_observed, no_relation, shows_progress, meets_standard, exceeds_standard
#         For Plan,        Presentation, Activity, Assessment, Climate
    results = [[0,0,0,0,0],[0,0,0,0,0],[0,0,0,0,0],[0,0,0,0,0],[0,0,0,0,0]]
    
    if !observation_list.nil?
      observations = observation_list
    else
      # Safe Guard, I don't think this will ever happen
      observations = School.observations.this_school_year
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
  def total_school_results(result_array)
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
  
  private
  
  def is_destroyable?
    @destroyable = self.classrooms.empty?
    if !@destroyable
      throw :abort
    end
  end
  
  def make_inactive_if_trying_to_destroy
    if !@destroyable.nil? && @destroyable == false
      deactivate_all_active_classrooms
      self.update_attribute(:active, false)
    end
    @destroyable = nil
  end

  def school_is_not_a_duplicate
    return true if self.name.nil? || self.state.nil?
    if self.already_exists?
      errors.add(:name, "already exists for this school at this location")
    end
  end
  
  def deactivate_all_active_classrooms
    self.classrooms.each do |classroom|
      classroom.update_attribute(:active, false)
    end
  end
  
  # Weird thing here where error only works with 'self.name' (something with text), but anything from principal crashes on case.
  def principal_is_principal
    return true if ((self.principal.nil?) || (self.principal.has_role? :principal))
    errors.add(self.name, "Error : User is not a principal.")
  end
end
