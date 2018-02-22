require_dependency "courses/application_controller"

module Courses
  class CoursesController < ApplicationController
    include ViewTypeHelpers

    before_action :set_course

    def index
      @courses = policy_scope( Course )
      respond_with @courses
    end

    def show
      respond_with @course
    end

    def new
      @creation = Creation.new creation_params
      authorize @creation
      respond_with @creation
    end

    def create
      @creation = Creation.new creation_params
      authorize @creation

      @creation.save
      respond_with @creation
    end

    def destroy
      @course.destroy
      respond_with @course
    end

  private

    def set_course
      @course = Course.find( params[:id] )
      authorize @course
    end

    def creation_params
      params.fetch( :course_params, {} ).permit( Creation.attr_names ).merge( owner: current_user )
    end

    def resource_name
      'course'
    end
  end
end
