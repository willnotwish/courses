require_dependency "courses/application_controller"

module Courses
  class MembershipsController < ApplicationController

    def show
    	@course = Course.find params[:course_id]
    	@course_membership = @course.course_memberships.where( member: current_user ).first
    	respond_with @course_membership
    end
  end
end
