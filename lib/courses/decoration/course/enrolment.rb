# enrolment.rb

module Courses
	module Decoration
		module Course
			module Enrolment

				def has_space?( count = 1 )
					return true unless capacity.present?  # there is always space if the capacity is not specified
					
					n = include_provisional_in_capacity? ? (confirmed_members.count + provisional_members.count) : confirmed_members.count
					capacity >= count + n
				end

				def full?
					!has_space?
				end

				# def total_member_count
				# 	confirmed_member_count + provisional_members.count
				# end

				def confirmed_member_count
					confirmed_members.count	
				end

				def provisional_member_count
					provisional_members.count
				end

				def cancelled_member_count
					cancelled_members.count
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
					n = include_provisional_in_capacity? ? (confirmed_members.count + provisional_members.count) : confirmed_members.count
					capacity - n
				end
			end
		end
	end
end