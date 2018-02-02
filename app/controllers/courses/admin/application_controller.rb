
require_dependency 'courses/application_controller'

module Courses
	module Admin
  	class ApplicationController < ApplicationController

  		# decorate_user_with 'Courses::Admin::UserDecorator'

	  #   before_action :authenticate_user!

  	# 	include Pundit
			# rescue_from Pundit::NotAuthorizedError, with: :user_not_authorized

	  # 	include DecoratorHelpers

	  #   respond_to :html, :json
	  
	  # private

	  # 	def user_not_authorized
	  # 		flash[:alert] = "You are not authorized to perform this action."
		 #    redirect_to(request.referrer || main_app.root_path)	  		
	  # 	end
	  protected

	  	def decorate_current_user( user )
	  		decorate user, class_name: 'Courses::Admin::UserDecorator'
	  	end
	  end
  end
end
