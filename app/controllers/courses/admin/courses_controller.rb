require_dependency "courses/application_controller"

module Courses
  module Admin
    class CoursesController < ApplicationController  
      include ViewTypeHelpers

      prepend_before_action :authenticate_admin!
      skip_before_action :authenticate_user!  
      before_action :set_course, only: [:show, :edit, :update, :destroy]

      respond_to :html, :json

      layout 'courses/admin'

      def index
        @courses = Course.all
        respond_with :admin, @courses
      end

      def show
        respond_with :admin, @course
      end

      def new
        @operation = CourseOperation.new course_params
        respond_with :admin, @operation
      end

      def create
        @operation = CourseOperation.new course_params
        @operation.save
        respond_with :admin, @operation
      end

      def edit
        @operation = CourseOperation.new course_params
        respond_with :admin, @operation
      end

      def update
        @operation = CourseOperation.update course_params
        respond_with :admin, @operation
      end

      def destroy
        @operation = DeleteCourseOperation.new course_params
        @operation.save
        respond_with :admin, @operation, location: [:admin, :courses]
      end

    private

      def set_course
        @course = Course.find params[:id]
      end

      def course_params
        params.fetch( :course, {} )
          .permit( :name, :starts_at, :duration_in_weeks, :guest_period_expires_at, :enrolment_opens_at, :capacity, :description, :product_id )
          .merge( course: @course || Course.new )
      end

    private

      def resource_name
        'course'
      end
    end
  end
end
