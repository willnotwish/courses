require_dependency 'courses/application_policy'

# This is an admin policy

module Courses
  module Admin
    class CoursePolicy < ApplicationPolicy

      def show?
        # user.has_permission_to? :show, record
        permission_to( :show ).exists?
      end

      def update?
        # user.has_permission_to? :update, record
        permission_to( :update ).exists?
      end

      # user_roles -> roles -> role_permission -> permission

      def user_roles
        Courses::UserRole.where( user: user ).where( course: [nil, record] )
      end

      def roles
        t1, t2 = Role.arel_table, Courses::UserRole.arel_table
        j = t1.join( t2, Arel::Nodes::InnerJoin ).on t1[:id].eq(t2[:role_id])
        
        Role.joins( j.join_sources )
          .merge user_roles
      end

      def permission_to( action )
        Permission.joins( role_permissions: :role )
          .merge( roles )
          .to( action )
      end

      def scope
        Scope.new( user, record.class ).resolve
      end

      class Scope < Scope
        def resolve
          user_roles = Courses::UserRole.where( user: user ).with_permission_to( :show )
          if user_roles.where( course: nil ).exists?
            scope.all
          else
            scope.joins( :user_roles ).merge user_roles  # inner join
          end
        end
      end
    end
  end
end
