require 'test_helper'

module Courses
  class EnrolmentsControllerTest < ActionDispatch::IntegrationTest
    include Engine.routes.url_helpers

    test "should get new" do
      get enrolments_new_url
      assert_response :success
    end

  end
end
