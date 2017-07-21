class Classroom < ApplicationRecord
  # Get an array of the grades and subjects
  # I'm not 100% on what '.freeze' does, but it was at the end of the list which I based this on
  # So if you know, edit as you will
  GRADES_LIST = ['1st', '2nd', '3rd', '4th', '5th', '6th', '7th', '8th', '9th', '10th', '11th', '12th', 'N/A'].freeze
  
  CONTENT_AREAS_LIST = ['English', 'Math', 'Palauan', 'Science', 'Social Studies', 'Physical Education', 'Health', 'N/A'].freeze
  
  # Relationships
  belongs_to :school
  belongs_to :teacher, class_name: "User"
  has_many :observations
  
  # Scopes
  scope :active,           -> { where(active: true) }
  scope :inactive,         -> { where(active: false) }
  scope :for_content_area, ->(content_area) { where(content_area: content_area) }
  scope :for_grade,        ->(grade) { where(grade: grade) }
  scope :for_teacher,      ->(teacher_id) { where(teacher_id: teacher_id) }
  scope :for_school,       ->(school_id) { where(school_id: school_id) }
  
  # Validations
  validates_presence_of :teacher_id, :school_id, :content_area, :grade
  
  validates_inclusion_of :grade, in: GRADES_LIST.map{|value| value}, message: "is not an option"
  validates_inclusion_of :content_area, in: CONTENT_AREAS_LIST.map{|value| value}, message: "is not an option"
#  validate :school_is_not_a_duplicate, on: :create
  validate :teacher_is_teacher, on: :create

#  def already_exists?
#    School.where(name: self.name, state: self.state).size == 1
#  end

  # Callbacks
  
  before_destroy :is_destroyable?
  after_rollback :make_inactive_if_trying_to_destroy

  # Other methods
  attr_reader :destroyable
  
  private
  def is_destroyable?
    @destroyable = false
  end
  
  def make_inactive_if_trying_to_destroy
    if !@destroyable.nil? && @destroyable == false
      self.update_attribute(:active, false)
    end
    @destroyable = nil
  end

  def teacher_is_teacher
    return true if self.teacher.has_role? :teacher
    errors.add(self.teacher.name, "is not a teacher.")
  end
  
#  def classroom_is_not_a_duplicate
#    return true if self.teacher_id.nil? || self.state.nil?
#    if self.already_exists?
#      errors.add(:name, "already exists for this school at this location")
#    end
#  end
  
end
