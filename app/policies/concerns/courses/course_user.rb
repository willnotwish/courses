# course_user.rb

# Provides syntactic sugar to make policies and scopes more readable and DRY.
# Include this in a class which defines course and user methods.


module Courses
	module CourseUser
		extend ActiveSupport::Concern

		included do
		end

    def user_owns_course?
      user == course.owner      
    end

    def user_is_member_of_course?
      course.course_memberships.where( member: user ).exists?
    end

    def user_has_permission?( permission_name )
      user_roles.for_course( course ).with_named_permission( permission_name ).exists?
    end

    def user_roles
      UserRole.for_user( user )
    end

		module ClassMethods
			
		end		
	end
end