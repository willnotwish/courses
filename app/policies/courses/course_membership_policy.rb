module Courses
  class CourseMembershipPolicy < ApplicationPolicy
    include CourseUser

    alias_method :course_membership, :record
    
    delegate :course, to: :course_membership

    LIST   = 'course.list_memberships'
    UPDATE = 'course.update_memberships'

	  def show?
      user.present? && (user_is_member_of_course? || user_has_permission?( LIST ) )
	  end

    def update?
      user.present? && (user_is_member_of_course? || user_has_permission?( UPDATE ) )
    end

    def create?
      false # creating courses directly is not allowed; enrolment is used instead
    end

    class Scope < Scope
      def resolve
        return scope.none unless user

        user_roles = Courses::UserRole.where( user: user ).with_named_permission( LIST )
        if user_roles.where( course: nil ).exists?
          scope.all
        else
          via_course_permissions = scope.joins( course: :user_roles ).merge( user_roles )
          via_course_ownership = scope.joins( :course ).merge( Courses::Course.owned_by( user ) )
          via_membership = scope.for_member( user )
          scope_ids = via_membership.ids + via_course_ownership.ids + via_course_permissions.ids 
          scope.where( id: scope_ids )
        end
      end
    end
  end
end
