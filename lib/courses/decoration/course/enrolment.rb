# enrolment.rb

module Courses
	module Decoration
		module Course
			module Enrolment

				# There is always space if the capacity is not specified
				def has_space?
					return true unless capacity.present?
					member_count < capacity
				end

				def full?
					!has_space?
				end

				def confirmed_member_count
					confirmed_members.count	
				end
				alias_method :member_count, :confirmed_member_count

				def provisional_member_count
					provisional_members.count
				end

				def empty?
					confirmed_members.empty?
				end

				def attendees
					confirmed_members
				end

				def space_limited?
					capacity.present? && capacity > 0
				end

				# It does not make sense to call this unless capacity is set. Callers should check beforehand
				def places_available
					capacity - member_count
				end
			end
		end
	end
end