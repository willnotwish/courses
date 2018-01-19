require 'test_helper'

module Courses
  class Admin::ApplicationControllerTest < ActionDispatch::IntegrationTest
    include Engine.routes.url_helpers

    test "should get index" do
      get admin_application_index_url
      assert_response :success
    end

  end
end
