require 'test_helper'

module Courses
  class Admin::HomeControllerTest < ActionDispatch::IntegrationTest
    include Engine.routes.url_helpers

    test "should get index" do
      get admin_home_index_url
      assert_response :success
    end

  end
end
