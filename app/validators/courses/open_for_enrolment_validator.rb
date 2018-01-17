# open_for_enrolment.rb

module Courses
	class OpenForEnrolmentValidator < ActiveModel::EachValidator

		def validate_each( record, attr, value )
			value.extend Decoration::Course::Timing
			record[attr] << "must be open for enrolment" unless value.open_for_enrolment?
		end
	end
end
