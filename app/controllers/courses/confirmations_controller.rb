require_dependency "courses/application_controller"

module Courses
  class ConfirmationsController < ApplicationController
  	before_action :set_course_membership # nested under CM

    def new
    	@confirmation = MembershipConfirmation.new confirmation_params
    	respond_with @confirmation
    end

    def create
    	@confirmation = MembershipConfirmation.create confirmation_params
    	respond_with @confirmation, location: @confirmation.course_membership
    end

  private

  	def current_course
  		@course
  	end

  	def set_course_membership
    	@course_membership = CourseMembership.find params[:course_membership_id]
  	end

  	def confirmation_params
  		params.fetch( :confirmation_operation, {} ).permit( :terms ).merge( course_membership: @course_membership )
  	end
  end
end
