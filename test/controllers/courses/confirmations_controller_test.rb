require 'test_helper'

module Courses
  class ConfirmationsControllerTest < ActionDispatch::IntegrationTest
    include Engine.routes.url_helpers

    test "should get new" do
      get confirmations_new_url
      assert_response :success
    end

  end
end
