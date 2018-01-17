# membership.rb

module Courses
	module Scopes
		module Membership

			def for_course( course )
				where( course: course )
			end
			
			def for_user( user )
				where( member: user )
			end

			def confirmed
				where( aasm_state: 'confirmed' )
			end

			def provisional
				where( aasm_state: 'provisional' )
			end
		end
	end
end