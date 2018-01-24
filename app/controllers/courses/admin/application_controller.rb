
module Courses
	module Admin
  	class ApplicationController < ::ApplicationController
	    before_action :authenticate_user!

  		include Pundit
			rescue_from Pundit::NotAuthorizedError, with: :user_not_authorized

	  	include DecoratorHelpers

	    respond_to :html, :json
	  
	  private

	  	def user_not_authorized
	  		flash[:alert] = "You are not authorized to perform this action."
		    redirect_to(request.referrer || main_app.root_path)	  		
	  	end
	  end
  end
end
