module Courses
  module Admin
    class DashboardPolicy < ApplicationPolicy

      def show?
        user.has_permission_to? :dashboard, 'courses/course'
      end

      class Scope < Scope
        def resolve
          scope
        end
      end
    end
  end
end
