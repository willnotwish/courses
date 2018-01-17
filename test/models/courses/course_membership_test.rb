# == Schema Information
#
# Table name: courses_course_memberships
#
#  id         :integer          not null, primary key
#  aasm_state :string(255)
#  course_id  :integer
#  member_id  :integer
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  payment_id :integer
#

require 'test_helper'

module Courses
  class CourseMembershipTest < ActiveSupport::TestCase
    # test "the truth" do
    #   assert true
    # end
  end
end
