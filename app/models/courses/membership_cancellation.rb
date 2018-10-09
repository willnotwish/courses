# membership_cancellation.rb

# Cancel the given course membership. Quacks like AR.

# If the membership has a payment and is not already cancelled, its cancel! event is called
# but it is not deleted; otherwise, it is destroyed.

module Courses

	class MembershipCancellation
    include ActiveModel::Model

    attr_reader :course_membership

    def initialize( cm )
      raise 'Must specify membership to cancel' unless cm
      @course_membership = cm
    end

    alias_method :membership, :course_membership

    def save
      if membership.payment? && !membership.cancelled?
        membership.cancel!
      else
        membership.destroy
      end
    end
	end
end