module Courses
  class CoursePolicy < ApplicationPolicy

  	def update?
	    user.has_permission_to? :update, record
  	end

	  def show?
	    user.has_permission_to? :show, record
	  end

    class Scope < Scope
      def resolve
        scope.accessible_to( user )
      end
    end
  end
end
