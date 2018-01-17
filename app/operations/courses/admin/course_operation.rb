# course_operation.rb

module Courses
	module Admin
		class CourseOperation
			include Operation

			delegate :name, 
			         :name=,
			         :starts_at,
			         :starts_at=,
			         :duration,
			         :duration=,
			         :enrolment_opens_at,
			         :enrolment_opens_at=,
			         :capacity,
			         :capacity=,
			         :guest_period_expires_at,
			         :guest_period_expires_at=,
			         :description,
			         :description=,
			         :product_id,
			         :product_id=,
				to: :record

			def duration_in_weeks
				self.duration.present? ? (duration/604800) : nil
			end

			def duration_in_weeks=( count )
				self.duration = count.present? ? count.to_i.weeks : nil
			end

			validates :name, :starts_at, presence: true
			validates :duration_in_weeks, numericality: { only_integer: true, greater_than: 0 }, allow_blank: true
			validates :capacity, numericality: { only_integer: true, greater_than: 0 }, allow_blank: true

		end
	end
end
