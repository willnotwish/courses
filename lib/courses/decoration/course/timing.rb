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

				def ends_on
					duration ? (starts_at + duration).to_date : nil
				end

				def ends_on_dotiw
					view_context.time_ago_in_words( ends_on )
				end

				def enrolment_opens_on
					enrolment_opens_at.to_date		
				end
				alias_method :enrolment_opened_on, :enrolment_opens_on

				def enrolment_closes_on
					enrolment_closes_at.to_date		
				end
				alias_method :enrolment_closed_on, :enrolment_closes_on

				def enrolment_closed?
					t = Time.now
					if enrolment_closes_at.present?
						t > enrolment_closes_at
					else
						false
					end
				end

				def open_for_enrolment?
					t = Time.now
					if enrolment_opens_at.present? && enrolment_closes_at.present?
						t > enrolment_opens_at && t < enrolment_closes_at
					elsif enrolment_opens_at.present? && enrolment_closes_at.blank?
						t > enrolment_opens_at
					elsif enrolment_opens_at.blank? && enrolment_closes_at.present?
						t < enrolment_closes_at
					else
						true
					end
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

				def finishes_at
					has_duration? ? starts_at + duration : nil
				end

				def finished?
					t = finishes_at
					t ? t < Time.now : false
				end
			end
		end
	end
end