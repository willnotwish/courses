# require_dependency "courses/application_controller"

module Courses
	module Admin
  	class ApplicationController < ::ApplicationController

	    before_action :authenticate_admin!
	  	layout 'admin'
	    respond_to :html, :json

	  	include DecoratorHelpers

	    def index
	    end
	  end
  end
end
