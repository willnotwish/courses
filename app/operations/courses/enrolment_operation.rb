module Courses
  class EnrolmentOperation < ApplicationOperation

  	attr_accessor :course, :user

  	validates :course, open_for_enrolment: true, has_space: true
	  validates :terms, presence: true, acceptance: true
  	
  	validate :validate_no_confirmed_membership

  	def course_membership
  		@course_membership ||= begin
  			course.course_memberships.build( member: user, aasm_state: 'provisional' )
  		end 
  	end

  	def save
  		return false if invalid?
  		course_membership.save
  	end

  	def self.create( attrs )
  		new( attrs ).tap { |op| op.save }
  	end

  private

  	def validate_no_confirmed_membership
			self.errors[:course] << "you are already enrolled on this course" if course.course_memberships.exists?( aasm_state: 'confirmed', member: user )
  	end
  end
end
