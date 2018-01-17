require 'courses/decorator_helpers'

module Courses

	# NEW. Inherits from main app's ApplicationController. This allows shared functionality such as authentication, etc (I think)
  class ApplicationController < ::ApplicationController # ActionController::Base
    # protect_from_forgery with: :exception
    
    include Courses::DecoratorHelpers

    respond_to :html, :json

  end
end
