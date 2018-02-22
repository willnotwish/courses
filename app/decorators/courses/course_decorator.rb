# course_decorator.rb

module Courses
	class CourseDecorator < ApplicationDecorator
		
		delegate :starts_at, 
		         :name, 
		         :duration, 
		         :guest_period_expires_at, 
		         :enrolment_opens_at, 
		         :enrolment_closes_at,
		         :capacity, 
		         :course_memberships,
		         :members,
		         :confirmed_members,
		         :provisional_members,
		         :product, 
		         :description,
		         :owner,
		         :draft?,
		         :published?,
		         :restricted?,
		         :include_provisional_in_capacity?,
			to: :object

		include Decoration::Course::Timing
		include Decoration::Course::GuestStatus
		include Decoration::Course::Enrolment
		include Decoration::Course::Pricing
		include Decoration::Course::Description

		def membership_scope
			CourseMembership.extend( Courses::Scopes::Membership ).for_course( object )			
		end

		def before_enrolment_opens?
			enrolment_opens_at.present? && Time.now < enrolment_opens_at
		end

		def after_enrolment_closed?
			enrolment_closes_at.present? && Time.now > enrolment_closes_at
		end

		def human_state
			object.aasm.human_state
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

		def may_delete?
			policy( object ).delete?
		end
	end
end
