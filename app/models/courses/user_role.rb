module Courses
  class UserRole < ApplicationRecord
    belongs_to :role, optional: true   # if the role is nil it implies "all roles"
    belongs_to :user
    belongs_to :course, optional: true # if the course is nil it implies "all courses"

    # delegate :role_permissions, :permissions, to: :role, allow_nil: true

    class << self
    	def for_user( user )
    		where( user: user )
    	end
    	alias_method :of_user, :for_user

    	def with_permission_to( action )
    		where( role: [nil, Role.with_permission_to( action ).ids] )
    	end
      alias_method :with_named_permission, :with_permission_to

    	def for_course( course )
    		if course.nil?
    			where( course: nil )
    		else
	    		where( course: [course, nil] )
	    	end
    	end
    end
  end
end
