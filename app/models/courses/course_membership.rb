
require 'aasm'

module Courses
  class CourseMembership < ApplicationRecord
    belongs_to :course
    belongs_to :member, class_name: Courses.member_class
    belongs_to :payment, required: false, class_name: Courses.payment_class   # an optional payment

    include AASM
    aasm do
    	state :provisional
    	state :confirmed
    	state :cancelled

    	event :confirm do
    		transitions from: :provisional, to: :confirmed, after: ->(payment=nil) { self.payment = payment if payment }
    	end

    	event :cancel do
    		transitions from: [:provisional, :confirmed], to: :cancelled
    	end
    end

    class << self
      def for_member( member )
        where( member: member )
      end
      alias_method :for_members, :for_member

      def for_course( course )
        where( course: course )
      end
      alias_method :for_courses, :for_course
    end
  end
end
