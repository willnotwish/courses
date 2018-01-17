# updateable_course.rb

# THis is an example of an operation which delegates to the AR record, but adds validations.
# Extra attributes that improve the UX are added as plain old Ruby attributes. The
# changes they make to the record's attributes are copied over to the delegated record just before it is saved.

module Courses
	module Admin
		class DelegatedCourse < SimpleDelegator
			include ActiveModel::Validations


			attr_accessor :duration_in_weeks
			# before_save :delegate_attributes

			validates :name, :starts_at, presence: true
			validates :duration_in_weeks, numericality: { only_integer: true, greater_than: 0 }, allow_blank: true

			def save
				set_duration
				super
			end

		private

			def set_duration
				self.duration = duration_in_weeks.to_i.weeks if duration_in_weeks.present?
			end
		end
	end
end