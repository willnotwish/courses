require_dependency "courses/application_controller"

module Courses
  class EnrolmentsController < ApplicationController

    before_action :build_enrolment # nested under a course -- courses/courses/17/enrolments/new

    def new
    	respond_with @enrolment
    end

    def create
      @enrolment.save
    	respond_with @enrolment, location: @enrolment.respond_to?( :course_membership ) ? @enrolment.course_membership : @course
    end

  private

    # In the POST payload for the #create action will be the remaining parameters: user_id (for an admin enrolling someone else), 
    # user_ids (for an admin enrolling members in bulk), or neither (for a regular user enrolling themselves).

    # 1. { user_id: 2, terms: '1' }
    # 2. { user_ids: [2,3], terms: '1' }
    # 3. { terms: '1' }

    def build_enrolment
      permitted = params.fetch( :enrolment, {} ).permit( :user_id, :terms, user_ids: [] )

      if permitted[:user_ids].present?
        @enrolment = BulkEnrolment.new( users: User.find( permitted[:user_ids] ) )
      elsif permitted[:user_id].present?
        @enrolment = Enrolment.new( user: User.find( permitted[:user_id] ) )
      else
        @enrolment = Enrolment.new( user: current_user )
      end

      @course = Course.find params[:course_id]  # nested under course
      @enrolment.course = @course

      @enrolment.terms = permitted[:terms]
      authorize @enrolment
    end
  end
end
