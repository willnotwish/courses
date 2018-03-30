# status.rb

module Courses
	class CourseStatus
		include ActiveModel::Model

		attr_accessor :course, :membership, :user

		def elements
			@elements ||= begin
				a = []
				if course.draft?
					a << :draft
				else
					if membership
						a << "enrolment_#{membership.aasm.current_state}".to_sym
					else
						if course.open_for_enrolment?
							if course.has_space?
								a << :open_for_enrolment
								a << :spaces
							else
								a << :full
							end
						elsif course.enrolment_closed?
							a << :enrolment_closed
						else
							t0 = course.enrolment_opens_at
							a << :not_yet_open_for_enrolment if t0 && t0 > Time.now
						end
					end	
					a.push :owner if user && course.owner == user
					a.push :free unless course.has_cost?
					a.push :restricted if course.restricted?
					a 
				end
			end
		end
	end
end