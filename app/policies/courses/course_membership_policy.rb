module Courses
  class CourseMembershipPolicy < ApplicationPolicy

	  def show?
	    user.has_permission_to? :show, record
	  end

    class Scope < Scope
      def resolve
        scope
      end
    end
  end
end
