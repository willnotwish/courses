module Courses
  class Update
    include CourseAttributes

  	attr_reader :course

    def initialize( course, attrs={} )
      @course = course
      super attrs
    end

  	def save
  		return false if invalid?
  		course.update attrs.except( :duration_in_weeks ).merge( duration: duration )
  	end

  	def self.from_course( course, attrs={} )
      defaults = attr_names.inject( {} ) do |hash, attr_name|
        hash[attr_name] = course.send( attr_name ) unless attr_name == :duration_in_weeks
        hash
      end
      defaults[:duration] = course.duration

      new course, defaults.merge( attrs )
  	end
  end
end
