require_dependency "courses/application_controller"

module Courses
  class Admin::HomeController < ApplicationController

    prepend_before_action :authenticate_admin!
    skip_before_action :authenticate_user!  

    def index
    end
  end
end
