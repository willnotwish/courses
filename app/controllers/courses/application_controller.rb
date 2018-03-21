
module Courses

	# NEW. Inherits from main app's ApplicationController. This allows shared functionality such as authentication, etc
  class ApplicationController < ::ApplicationController
    before_action :authenticate_user!

		include Pundit
		rescue_from Pundit::NotAuthorizedError, with: :user_not_authorized

  	# include DecoratorHelpers

    helper_method :page_title, :page_subtitle

    respond_to :html, :json

  	def user_not_authorized
  		flash[:alert] = "You are not authorized to perform this action."
	    redirect_to(request.referrer || main_app.root_path)	  		
  	end

    def page_subtitle( text )
      @subtitle = text
    end

    def page_title
      if @subtitle.present?
        "Courses - #{@subtitle}"
      else
        "Courses"
      end
    end
  end
end
