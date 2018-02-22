module Courses
  class Creation
    include CourseAttributes

  	def save
  		return false if invalid?
  		course.save
  	end

  	def self.create( attrs={} )
  		new( attrs ).tap { |c| c.save }
  	end

  private

    def course
      Course.new attrs.except( :duration_in_weeks ).merge( duration: duration )
    end
  end
end
