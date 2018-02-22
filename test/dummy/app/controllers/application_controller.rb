require "application_responder"

class ApplicationController < ActionController::Base
  self.responder = ApplicationResponder
  respond_to :html

  protect_from_forgery with: :exception

  helper_method :current_user

  def current_user
  	@current_user
  end

  def authenticate_user!
  	@current_user = User.first
  end
end
