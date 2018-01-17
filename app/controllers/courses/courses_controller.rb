require_dependency "courses/application_controller"

module Courses
  class CoursesController < ApplicationController

    def index
      @courses = Course.all
      respond_with @courses
    end

    def show
      @course = Course.find(params[:id])
      respond_with @course
    end
  end
end
