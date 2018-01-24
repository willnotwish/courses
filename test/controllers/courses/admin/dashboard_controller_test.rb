require 'test_helper'

module Courses
  class Admin::DashboardControllerTest < ActionDispatch::IntegrationTest
    include Engine.routes.url_helpers

    test "should get show" do
      get admin_dashboard_show_url
      assert_response :success
    end

  end
end
