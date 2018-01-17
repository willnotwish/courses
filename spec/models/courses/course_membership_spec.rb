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

require 'rails_helper'

module Courses
  RSpec.describe CourseMembership, type: :model do
    it{ is_expected.to be }
    it{ is_expected.to belong_to(:course) }

    it{ is_expected.to have_db_column(:member_id)}
    it{ is_expected.to have_db_index(:member_id)}
    it{ is_expected.to belong_to(:member) }

    it{ is_expected.to have_db_column(:payment_id)}
    it{ is_expected.to have_db_index(:payment_id)}
    it{ is_expected.to belong_to(:payment) }
  end
end
