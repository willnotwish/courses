require 'test_helper'

module Courses
  class MembershipsControllerTest < ActionDispatch::IntegrationTest
    include Engine.routes.url_helpers

    test "should get show" do
      get memberships_show_url
      assert_response :success
    end

  end
end
