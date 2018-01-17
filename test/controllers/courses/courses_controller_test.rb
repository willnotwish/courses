require 'test_helper'

module Courses
  class CoursesControllerTest < ActionDispatch::IntegrationTest
    include Engine.routes.url_helpers

    test "should get index" do
      get courses_index_url
      assert_response :success
    end

    test "should get show" do
      get courses_show_url
      assert_response :success
    end

  end
end
