require_dependency "courses/application_controller"

module Courses
  class DashboardController < ApplicationController

  	layout 'courses/dashboard'

    def show
    	@dashboard = Dashboard.new user: current_user, courses: policy_scope( Course )
    	authorize @dashboard, :show?
    	respond_with @dashboard
    end
  end
end
