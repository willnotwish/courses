require 'courses/decorator_helpers'

module Courses

	# NEW. Inherits from main app's ApplicationController. This allows shared functionality such as authentication, etc (I think)
  class ApplicationController < ::ApplicationController # ActionController::Base
    include Courses::DecoratorHelpers

    before_action :authenticate_user!

    respond_to :html, :json

  end
end
