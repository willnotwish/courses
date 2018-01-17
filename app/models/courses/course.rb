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

module Courses
  class Course < ApplicationRecord
  	has_many :course_memberships
  	has_many :members, through: :course_memberships

  	has_many :confirmed_memberships, ->{ where( aasm_state: 'confirmed' ) }, class_name: 'CourseMembership'
  	has_many :confirmed_members, through: :confirmed_memberships, source: :member

  	has_many :provisional_memberships, ->{ where( aasm_state: 'provisional' ) }, class_name: 'CourseMembership'
  	has_many :provisional_members, through: :provisional_memberships, source: :member

  	belongs_to :product, required: false
  end
end
