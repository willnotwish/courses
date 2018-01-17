require 'test_helper'

module Courses
  class PaymentsControllerTest < ActionDispatch::IntegrationTest
    include Engine.routes.url_helpers

    test "should get index" do
      get payments_index_url
      assert_response :success
    end

    test "should get new" do
      get payments_new_url
      assert_response :success
    end

    test "should get show" do
      get payments_show_url
      assert_response :success
    end

  end
end
