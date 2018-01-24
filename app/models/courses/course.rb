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

  	has_many :user_roles, as: :resource

  	class << self
  		def accessible_to( user, action = 'show' )
        return all if user.user_roles.where( role: nil ).present?   # case 1 - user can do anything

        user_roles = user.user_roles.joins( role: { role_permissions: :permission } ).merge( Permission.where( name: [action, nil] ) ).distinct

        # Case 2: admin with access to *all* resources, irrespective of class or id
        if user_roles.where( resource_type: nil ).present?
          all
        
        # Case 3: with access to *all* records of this class (eg, courses), irrespective of id
        elsif user_roles.where( resource_type: self.name, resource_id: nil ).present?
          all 

        # Case 4: with access to a particular course (inner join)
        else
          joins( :user_roles ).merge user_roles
        end
  		end
  	end
  end
end
