require 'test_helper'

module Courses
  class Admin::CourseMembershipsControllerTest < ActionDispatch::IntegrationTest
    include Engine.routes.url_helpers

    test "should get index" do
      get admin_course_memberships_index_url
      assert_response :success
    end

    test "should get show" do
      get admin_course_memberships_show_url
      assert_response :success
    end

  end
end
