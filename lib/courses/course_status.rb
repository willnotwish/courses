# status.rb

module Courses
	class CourseStatus
		include ActiveModel::Model

		attr_accessor :course, :membership, :user

		def elements
			@elements ||= begin
				a = []
				if membership
					a << "enrolment_#{membership.aasm.current_state}".to_sym
					if course.full?
						a << :full
					else
						a << :spaces
					end
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
						if t0 && t0 > Time.now
							a << :not_yet_open_for_enrolment
						# else
						# 	a << course.aasm.current_state
						end
					end
				end	
				a.prepend :owner if user && course.owner == user
				a
			end
		end
	end
end