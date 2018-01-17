# == Schema Information
#
# Table name: courses_courses
#
#  id                      :integer          not null, primary key
#  name                    :string(255)
#  starts_at               :datetime
#  duration                :integer
#  guest_period_expires_at :datetime
#  enrolment_opens_at      :datetime
#  capacity                :integer
#  created_at              :datetime         not null
#  updated_at              :datetime         not null
#  product_id              :integer
#

require 'test_helper'

module Courses
  class CourseTest < ActiveSupport::TestCase
    # test "the truth" do
    #   assert true
    # end
  end
end
