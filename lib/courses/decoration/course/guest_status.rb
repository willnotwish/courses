# guest_status.rb

module Courses
	module Decoration
		module Course
			module GuestStatus

				def affects_guest_period?
					guest_period_expires_at.present?
				end

				def guest_period_expires_on
					guest_period_expires_at.present? ? guest_period_expires_at.to_date : nil
				end

			end
		end
	end
end