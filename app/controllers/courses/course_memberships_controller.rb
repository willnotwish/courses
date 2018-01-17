require_dependency "courses/application_controller"

module Courses
  class CourseMembershipsController < ApplicationController

    def index
      @course_memberships = CourseMembership.where( member: current_user )
      respond_with @course_memberships
    end

    def show
      @course_membership = CourseMembership.find(params[:id])
      respond_with @course_membership
    end
  end
end
