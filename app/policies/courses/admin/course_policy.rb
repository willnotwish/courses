# This is an admin policy

module Courses
  class Admin::CoursePolicy < ApplicationPolicy

  	alias_method :course, :record

  	def show?
  		user.able_to_show? course
  	end

    class Scope < Scope
      def resolve
        user.with_permission_to( :show, record )
      end
    end
  end
end
