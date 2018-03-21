# course_decorator.rb

require_dependency "courses/application_decorator"   # needed sometimes (I'm not sure when). Best to include it always.

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

		# Returns one of :enrolled, :enrolled_provisionally or nil if not enrolled
		def membership_status( user )
			memberships = membership_scope.for_user( user )
			if memberships.confirmed.present?
				:enrolled
			elsif memberships.provisional.present?
				:enrolled_provisionally
			end
		end

		def provisional_membership( user )
			membership_scope.for_user( user ).provisional.first
		end

		def confirmed_membership( user )
			membership_scope.for_user( user ).confirmed.first
		end

		def membership_for( user )
			membership_scope.for_user( user ).first			
		end

		def provisional_memberships
			course_memberships.provisional
		end

		def confirmed_memberships
			course_memberships.confirmed
		end

		def may_delete?
			policy( object ).delete?
		end

		def may_list_memberships?
			policy( object ).list_memberships?
		end
		alias_method :may_list_members?, :may_list_memberships?

		def thumbnail
			image_tag 'http://via.placeholder.com/100x100', alt: "Thumbnail image of #{name}"
		end

		def dates_as_text
			if started?
				"Started on #{started_on} (ends on #{ends_on})"
			else
				"Starts on #{starts_on} (in about #{starts_on_dotiw})"
			end
		end

		def status_as_hash( user=nil )
			_status = status( user )
			Hash.new.tap { |hash| hash[_status] = true if _status } 
		end

		def status_as_text( user=nil )
			_status = status( user )
			if _status
				t "courses.status.#{_status}"
			else
				''
			end
		end

		def created_by?( user )
			owner == user
		end

		# def to_status( user=nil )
		# 	@status ||= Status.new( self, user )
		# end

	private

		def status( user=nil )
			s = membership_status( user ) if user
			unless s
				if open_for_enrolment?
					if has_space?
						s = :open_for_enrolment
					else
						s = :full
					end
				end
			end
			s
		end
	end
end
