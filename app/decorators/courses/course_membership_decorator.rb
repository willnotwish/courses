# course_membership_decorator.rb
require_dependency "courses/application_decorator"   # needed sometimes (I'm not sure when). Best to include it always.

module Courses
	class CourseMembershipDecorator < ApplicationDecorator

		delegate :course, :member, :payment, :aasm_state, :confirmed_at, :created_at, to: :object
		delegate :product, to: :course, allow_nil: true
		delegate :price, to: :product, allow_nil: true

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
			paid? ? format_currency(payment.amount) : nil
		end

		def payment_date
			paid? ? l( payment.created_at.to_date ) : nil
		end
		alias_method :paid_on, :payment_date

		def member_name
			member.name
		end

		def belongs_to_current_user?
			member == current_user
		end

		def created_on
			created_at.to_date
		end
	end
end