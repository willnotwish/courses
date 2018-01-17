# delete_course_operation.rb

module Courses
	module Admin
		class DeleteCourseOperation
			include Operation

			set_record_name :course

			delegate :course_memberships, to: :record

			validates :course_memberships, empty: true

			def save
				return false if invalid?
				record.destroy
			end
		end
	end
end