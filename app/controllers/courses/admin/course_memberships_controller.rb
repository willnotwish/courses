require_dependency "courses/admin/application_controller"

module Courses
  class Admin::CourseMembershipsController < Admin::ApplicationController
  
  	before_action :set_course_membership, only: :show

    def index
    	@course_memberships = CourseMembership.all
    	if params[:course_id].present?
	    	@course_memberships = @course_memberships.where( course: course )
	    end
	    respond_with :admin, @course_memberships
    end

    def show
    	respond_with :admin, @course_membership
    end

	private

		def set_course_membership
			@course_membership = CourseMembership.find params[:id]
		end

  end
end
