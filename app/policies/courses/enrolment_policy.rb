module Courses
  class EnrolmentPolicy < ApplicationPolicy
  	include CourseUser

  	alias_method :enrolment, :record
  	delegate :course, to: :enrolment

  	def create?
  		( enrolment.user == user ) || user_has_permission?( 'course.create_memberships' )
  	end

  	def show?
  		false
  	end

    class Scope < Scope
      def resolve
        raise 'Not implemented'
      end
    end
  end
end
