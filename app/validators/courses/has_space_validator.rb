# has_space_validator.rb

module Courses
	class HasSpaceValidator < ActiveModel::EachValidator
		def validate_each( record, attr, course )
			if course
				course.extend Decoration::Course::Enrolment
				if options[:count]
					if options[:count].respond_to?( :call )
						count = options[:count].call( record )
					else
						count = options[:count]
					end
				else
					count = 1  # default
				end
				record.errors[attr] << "must have space" unless course.has_space?( count )
			end
		end
	end
end