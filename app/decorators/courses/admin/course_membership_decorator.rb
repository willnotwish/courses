# course_membership_decorator.rb

module Courses
	module Admin	
		class CourseMembershipDecorator < ApplicationDecorator
			
			delegate :course, :member, :payment, :aasm_state, to: :object
			delegate :product, to: :course

			# decorate_with :pricing, :membership_status

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
				l payment.created_at.to_date
			end

			def member_name
				member.name
			end
		end
	end
end