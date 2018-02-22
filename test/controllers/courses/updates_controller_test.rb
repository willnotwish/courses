require 'test_helper'

module Courses
  class UpdatesControllerTest < ActionDispatch::IntegrationTest
    include Engine.routes.url_helpers

    test "should get new" do
      get updates_new_url
      assert_response :success
    end

  end
end
