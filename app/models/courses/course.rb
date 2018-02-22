require_dependency 'courses/course_membership'

require 'aasm'

module Courses
  class Course < ApplicationRecord
  	has_many :course_memberships
  	has_many :members, through: :course_memberships

  	has_many :confirmed_memberships, ->{ confirmed }, class_name: 'CourseMembership'
  	has_many :confirmed_members, through: :confirmed_memberships, source: :member

  	has_many :provisional_memberships, ->{ provisional }, class_name: 'CourseMembership'
  	has_many :provisional_members, through: :provisional_memberships, source: :member

    has_many :cancelled_memberships, ->{ cancelled }, class_name: 'CourseMembership'
    has_many :cancelled_members, through: :cancelled_memberships, source: :member

  	belongs_to :product, required: false
    belongs_to :owner, class_name: Courses.course_owner_class # eg, User

    has_many :user_roles

    # No user roles are checked here; that's a policy concern
    include AASM
    aasm do 
      state :draft, initial: true
      state :restricted, enter: ->(record) { record.published_at = nil }
      state :published,  enter: ->(record) { record.published_at = Time.now }

      event :publish do
        transitions from: [:draft, :restricted], to: :published
      end

      event :restrict do
        transitions from: [:draft, :published], to: :restricted
      end
    end

    attr_accessor :enrolment_criteria

    class << self
      def with_membership_for( member )
        joins( :course_memberships ).merge( CourseMembership.for_member( member ) )
      end

      def with_confirmed_membership_for( member )
        joins( :confirmed_memberships ).merge( CourseMembership.for_member( member ) )
      end

      def owned_by( owner )
        where( owner: owner )
      end
    end
  end
end
