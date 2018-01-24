require_dependency "courses/admin/application_controller"

module Courses
	module Admin
	  class DashboardController < Admin::ApplicationController
	    def show
	    	@dashboard = Dashboard.new
	    	authorize @dashboard, :show?
	    end
	  end
	end
end
