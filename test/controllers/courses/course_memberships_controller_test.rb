require 'test_helper'

module Courses
  class CourseMembershipsControllerTest < ActionDispatch::IntegrationTest
    include Engine.routes.url_helpers

    setup do
      @course_membership = courses_course_memberships(:one)
    end

    test "should get index" do
      get course_memberships_url
      assert_response :success
    end

    test "should get new" do
      get new_course_membership_url
      assert_response :success
    end

    test "should create course_membership" do
      assert_difference('CourseMembership.count') do
        post course_memberships_url, params: { course_membership: { aasm_state: @course_membership.aasm_state, course_id: @course_membership.course_id, member_id: @course_membership.member_id } }
      end

      assert_redirected_to course_membership_url(CourseMembership.last)
    end

    test "should show course_membership" do
      get course_membership_url(@course_membership)
      assert_response :success
    end

    test "should get edit" do
      get edit_course_membership_url(@course_membership)
      assert_response :success
    end

    test "should update course_membership" do
      patch course_membership_url(@course_membership), params: { course_membership: { aasm_state: @course_membership.aasm_state, course_id: @course_membership.course_id, member_id: @course_membership.member_id } }
      assert_redirected_to course_membership_url(@course_membership)
    end

    test "should destroy course_membership" do
      assert_difference('CourseMembership.count', -1) do
        delete course_membership_url(@course_membership)
      end

      assert_redirected_to course_memberships_url
    end
  end
end
