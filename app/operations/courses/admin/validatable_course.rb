# create_course_operation2.rb

# THis is an example of an operation which extends the AR record with validations.
# Extra attributes that improve the UX are added as plain old Ruby attributes. The
# changes they make to the record's attributes are copied in place to the record just before it is saved.

module Courses
	module Admin
		class ValidatableCourse < Course

			attr_accessor :duration_in_weeks
			before_save :set_database_attributes

			validates :name, :starts_at, presence: true
			validates :duration_in_weeks, numericality: { only_integer: true, greater_than: 0 }, allow_blank: true

		private

			def set_database_attributes
				self.duration = duration_in_weeks.to_i.weeks if duration_in_weeks.present?
			end
		end
	end
end