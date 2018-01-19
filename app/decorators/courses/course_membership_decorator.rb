# course_membership_decorator.rb

module Courses
	class CourseMembershipDecorator < ApplicationDecorator

		delegate :course, :member, :payment, :aasm_state, to: :object
		delegate :product, to: :course
		delegate :price, to: :product

		# In the future maybe I could do something like this:
		# decorate_with :pricing, :membership_status
		# but for now:

		include Decoration::Pricing
		include Decoration::MembershipStatus

		def course_name
			course.name
		end

		def state
			aasm_state.humanize
		end

		def paid?
			payment.present?
		end

		def amount_paid
			paid? ? payment.amount : nil
		end

		def member_name
			member.name
		end
	end
end