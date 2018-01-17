# course.rb

module Courses

	module Scopes

		module Course 
			extend ActiveSupport::Concern

			included do
			end

			module ClassMethods

				def open_for_enrolment
					eoa = arel_table[:enrolment_opens_at]
					Course.where( eoa.eq( nil ).or( eoa.lt( Time.now ) ) )
				end
				alias_method :currently_open_for_enrolment, :open_for_enrolment

				def started
					t = arel_table[:starts_at]
					where( t.lt Time.now )
				end

				def not_started
					t = arel_table[:starts_at]
					where( t.gt Time.now )
				end
				alias_method :future, :not_started

				def not_finished
					ends_at = Arel::Nodes::SqlLiteral.new "TIMESTAMPADD( SECOND, `courses_courses`.`duration`, `courses_courses`.`starts_at` )"
					where( ends_at.gt( Time.now ) )
				end

				def finished
					ends_at = Arel::Nodes::SqlLiteral.new "TIMESTAMPADD( SECOND, `courses_courses`.`duration`, `courses_courses`.`starts_at` )"
					where( ends_at.lt( Time.now ) )
				end
				alias_method :past, :finished

				def current
					started.not_finished			
				end

				def not_full
					all
				end

				def not_enrolled_by( user )
					all
				end
			end
		end
	end
end