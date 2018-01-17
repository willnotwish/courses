# timing.rb

# To include this module, be sure to have the following variables defined:

# starts_at
# duration

module Courses
	module Decoration
		module Course
			module Timing

				# starts_at related

				def starts_on
					starts_at.to_date		
				end	
				alias_method :started_on, :starts_on

				def enrolment_opens_on
					enrolment_opens_at.to_date		
				end
				alias_method :enrolment_opened_on, :enrolment_opens_on

				def open_for_enrolment?
					return true if enrolment_opens_at.blank?
					enrolment_opens_at < Time.now
				end

				def started?
					starts_at < Time.now
				end

				def starts_on_dotiw
					view_context.time_ago_in_words( starts_at )
				end	
				alias_method :started_on_dotiw, :starts_on_dotiw

				# duration related

				def has_duration?
					duration.present?
				end

				def duration_in_weeks
					if has_duration?
						duration / (24*7*60*60)
					end
				end
			end
		end
	end
end