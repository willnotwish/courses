require_dependency "courses/application_controller"

module Courses
  module Admin
	  class DashboardController < ApplicationController
	    def show
	    	@dashboard = Dashboard.new
	    	authorize @dashboard, :show?
	    	respond_with @dashboard
	    end
	  end
	end
end
