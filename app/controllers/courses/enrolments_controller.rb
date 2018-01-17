require_dependency "courses/application_controller"

module Courses
  class EnrolmentsController < ApplicationController

  	helper_method :current_course
  	before_action :set_course

    def new
    	@enrolment = EnrolmentOperation.new enrolment_params
    	respond_with @enrolment
    end

    def create
    	@enrolment = EnrolmentOperation.create enrolment_params
    	respond_with @enrolment, location: @enrolment.course_membership
    end

  private

  	def current_course
  		@course
  	end

  	def set_course
    	@course = Course.find params[:course_id]
  	end

  	def enrolment_params
  		params.fetch( :enrolment_operation, {} ).permit( :terms ).merge( course: @course, user: current_user )
  	end
  end
end
