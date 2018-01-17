# empty_validator.rb

module Courses
	class EmptyValidator < ActiveModel::EachValidator
		def validate_each( record, attr, value )
			record.errors[attr] << "must be empty" unless value.empty?
		end
	end
end