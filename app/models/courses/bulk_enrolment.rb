module Courses
  class BulkEnrolment
  	include ActiveModel::Model
  	include ActiveModel::Validations

  	attr_accessor :members, :course

    validates :members, presence: true
    validates :course, presence: true, open_for_enrolment: true, has_space: { count: ->(enrolment) { enrolment.members.count } }
	  validates :terms, presence: true, acceptance: true

	  validate :non_members_only, :criteria_met

  	def save
  		return false if invalid?
  		CourseMembership.transaction do
  			course_memberships.each { |cm| cm.save! }
  		end
  		true
  	end

  	def course_memberships
  		return [] unless members && course
  		@course_memberships ||= members.map { |member| course.course_memberships.build( member: member) }
  	end

  	def self.create( attrs )
  		new( attrs ).tap { |op| op.save }
  	end

  private

  	def non_members_only
  		if members && course
  			members.each do |member|
  				self.errors[:members] << "#{member.name} is already enrolled on this course" if course.course_memberships.for_member( member ).exists?
  			end
  		end
  	end

  	def criteria_met
  		if members && course
  			members.each do |member|
  				ec = course.enrolment_criteria
  				if ec
	  				criteria_met = ec.respond_to?(:call) ? ec.call( member, course ) : ec.check( member, course )
	  				self.errors[:members] << "#{member.name} does not meet the entry criteria for this course" unless criteria_met
	  			end
  			end
  		end
  	end
  end
end

