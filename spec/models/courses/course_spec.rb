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

require 'rails_helper'

module Courses
  RSpec.describe Course, type: :model do
    it{ is_expected.to be }
    it{ is_expected.to have_many(:course_memberships) }
    it{ is_expected.to have_many(:members) }
    it{ is_expected.to belong_to(:product) }
  end
end
