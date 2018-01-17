# description.rb

module Courses
	module Decoration
		module Course
			module Description

				def description?
					description.present?
				end
				alias_method :has_description?, :description?

			end
		end
	end
end