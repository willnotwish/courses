# course_decorator.rb

module Courses
	class CourseDecorator < ApplicationDecorator
		
		delegate :starts_at, 
		         :name, 
		         :duration, 
		         :guest_period_expires_at, 
		         :enrolment_opens_at, 
		         :capacity, 
		         :product, 
		         :description, 
			to: :object

		include Decoration::Course::Timing
		include Decoration::Course::GuestStatus
		include Decoration::Course::Enrolment
		include Decoration::Course::Pricing
		include Decoration::Course::Description

		def membership_scope
			CourseMembership.extend( Courses::Scopes::Membership ).for_course( object )			
		end

		# def membership_scope( user )
		# 	CourseMembership.extend( Courses::Scopes::Membership ).for_user( user ).for_course( object )
		# end

		def membership_status( user )
			# Returns one of :enrolled, :enrolled_provisionally or :not_enrolled
			memberships = membership_scope.for_user( user )
			if memberships.confirmed.present?
				:enrolled
			elsif memberships.provisional.present?
				:enrolled_provisionally
			else
				:not_enrolled
			end
		end

		def provisional_membership( user )
			membership_scope.for_user( user ).provisional.first
		end

		def confirmed_membership( user )
			membership_scope.for_user( user ).confirmed.first
		end
	end
end
