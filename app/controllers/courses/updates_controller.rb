require_dependency "courses/application_controller"

module Courses
  class UpdatesController < ApplicationController

  	before_action :set_course, :build_update    # nested under course
    
    def new
    	respond_with @update
    end

    def create
    	@update.save
    	respond_with @update, location: @course
    end

  private

    def set_course
      @course = Course.find params[:course_id]
      authorize @course, :update?
    end

    def build_update
    	@update = Update.from_course( @course, update_params )
    end

    def update_params
    	params.fetch( :update, {} ).permit( :name, :duration_in_weeks, :description, :capacity, :starts_at )
    end
  end
end
