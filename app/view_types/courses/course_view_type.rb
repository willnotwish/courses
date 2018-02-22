# course_view_type.rb

module Courses
	class CourseViewType
		include ActiveModel::Model

		attr_accessor :t

		def list?
			t && t.to_s =~ /list/
		end

		def thumbs?
			t && t.to_s =~ /thumb/i
		end

		def details?
			t && t.to_s =~ /detail/i
		end

		def to_s
			t.to_s || 'list'
		end

		alias_method :layout, :to_s
	
		def to_partial_path
			to_s
		end
	end	
end
