module Courses
  class CoursePolicy < ApplicationPolicy

  	def update?
	    user.has_permission_to? :update, record
  	end

	  def show?
      user_roles.with_permission_to( :show ).exists?
	    # user.has_permission_to? :show, record
	  end

    class Scope < Scope
      def resolve
        scope.accessible_to( user )
      end
    end

  private

    def user_roles
      UserRole.for_user( user ).for_course( record )
    end

  end
end
