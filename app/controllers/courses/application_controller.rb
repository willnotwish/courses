# require 'courses/decorator_helpers'

module Courses

	# NEW. Inherits from main app's ApplicationController. This allows shared functionality such as authentication, etc
  class ApplicationController < ::ApplicationController # ActionController::Base
    include DecoratorHelpers

    before_action :authenticate_user!

    respond_to :html, :json

  end
end
