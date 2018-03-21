module Courses
  class CoursePolicy < ApplicationPolicy
    include CourseUser

    alias_method :course, :record

  	def show?
      course.published? || user_is_member_of_course? || user_owns_course? || user_has_permission?( 'course.show' )
  	end

    def create?
      user.present?   # any authenticated user can create a (draft) course
    end

    def update?
      ( course.draft? && user_owns_course? ) || user_has_permission?( 'course.update' )
    end

    def delete?
      return false unless course.course_memberships.empty?  # can't delete a course with any memberships

      if course.draft? && user_owns_course?
        true
      else
        !course.published? && user_has_permission?( 'course.delete' )  # can't delete a published course: restrict it first
      end
    end
    alias_method :destroy?, :delete?

    def publish?
      course.may_publish? && user_has_permission?( 'course.publish' )
    end

    def restrict?
      course.may_restrict? && user_has_permission?( 'course.restrict' )
    end

    def list_memberships?
      user_has_permission?( 'course.list_memberships' )
    end

  public

    class Scope < Scope
      def resolve
        # Resolves to those courses
        #   which are published
        #     and 
        #   for which the user has a course membership (either provisional or confirmed)
        #     and
        #   which the user owns
        #     and
        #   for which the user has show permission
        user_roles = UserRole.for_user( user ).with_named_permission( 'course.show' )
        if user_roles.where( course: nil ).exists?
          scope.all
        else
          permitted = scope.joins( :user_roles ).merge user_roles
          ids = scope.owned_by( user ).ids + scope.published.ids + scope.with_membership_for( user ).ids + permitted.ids  # an array
          scope.where( id: ids.uniq )
        end
      end
    end
  end
end
  