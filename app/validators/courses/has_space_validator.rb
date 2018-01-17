# has_space_validator.rb

module Courses
	class HasSpaceValidator < ActiveModel::EachValidator
		def validate_each( record, attr, value )
			value.extend Decoration::Course::Enrolment
			record[attr] << "must have space" unless value.has_space?
		end
	end
end