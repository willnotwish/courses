module Courses
  class CoursePolicy < ApplicationPolicy

    alias_method :course, :record

  	def show?
      course.published? || user.confirmed_on?( course )
  	end

    class Scope < Scope
      # user & scope readers are defined

      # Resolves to those courses which are published, 
      # or for which the user has a course membership (either provisional or confirmed)
      # or which the user owns
      def resolve
        ids = Courses::Course.published.ids + user.courses.ids   # an array
        scope.merge Courses::Course.where( id: ids.uniq )
      end
    end
  end
end
  