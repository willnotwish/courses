# create_course_operation.rb

# This is an example of an operation which validates all component attributes *before* building the AR model.
# If saving the AR model fails, it won't be because the model is invalid.

module Courses
	module Admin
		class CreateCourseOperation < ApplicationOperation

			include ActiveRecord::AttributeAssignment

			attr_accessor :name,
				:starts_at, 
				:duration_in_weeks
				# :product_id

			attr_reader :starts_at

			# Note that we need to be able to assign a starts_at timestamp from a parsed hash of attributes, because that is what we get from Rails' form helper
			def starts_at=( ts )
				if ts.is_a?( Hash )
					@starts_at = Time.new( *ts.values )  # year, month, day, hour, minutes = ts.values_at( 1, 2, 3, 4, 5 )
				else
					@starts_at = ts
				end
			end

			validates :name, :starts_at, presence: true
			validates :duration_in_weeks, numericality: { only_integer: true, greater_than: 0 }, allow_blank: true

			# validates that product id references a valid product

			def save
				return false if invalid?
				Course.create name: name, starts_at: starts_at do |course|
					course.duration = duration_in_weeks.to_i.weeks if duration_in_weeks.present?
				end
			end

			def self.create( attrs={} )
				new( attrs ).tap { |op| op.save }
			end
		end
	end
end