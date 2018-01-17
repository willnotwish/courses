require 'test_helper'

module Courses
  class PaypalTokensControllerTest < ActionDispatch::IntegrationTest
    include Engine.routes.url_helpers

    test "should get new" do
      get paypal_tokens_new_url
      assert_response :success
    end

  end
end
