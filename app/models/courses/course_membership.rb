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

module Courses
  class CourseMembership < ApplicationRecord
    belongs_to :course
    belongs_to :member, class_name: Courses.member_class
    belongs_to :payment, required: false, class_name: Courses.payment_class   # an optional payment
  end
end
