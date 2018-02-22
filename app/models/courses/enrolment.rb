
module Courses
  class Enrolment
  	include ActiveModel::Model
  	include ActiveModel::Validations

  	attr_accessor :user, :course

    validates :user,   presence: true
  	validates :course, presence: true, open_for_enrolment: true, has_space: true
	  validates :terms,  presence: true, acceptance: true
  	
  	validate :non_member_only, :criteria_met

  	def save
  		return false if invalid?
  		course_membership.save
  	end

  	def course_membership
      if course && user
    		@course_membership ||= course.course_memberships.build( member: user )
      else
        nil
      end
  	end

  	def self.create( attrs )
  		new( attrs ).tap { |op| op.save }
  	end

  private
  	def non_member_only
      if course && user
  			self.errors[:user] << "is already enrolled on this course" if course.course_memberships.for_member( user ).exists?
      end
  	end

    def criteria_met
      if course && user
        ec = course.enrolment_criteria
        if ec
          criteria_met = ec.respond_to?(:call) ? ec.call( user, course ) : ec.check( user, course )
          self.errors[:user] << "does not meet the entry criteria for this course" unless criteria_met
        end
      end      
    end
  end
end
