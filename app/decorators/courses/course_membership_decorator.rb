# course_membership_decorator.rb

module Courses
	class CourseMembershipDecorator < ApplicationDecorator

		delegate :course, :member, :payment, :aasm_state, to: :object
		delegate :product, to: :course
		delegate :price, to: :product

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
			paid? ? payment.amount : nil
		end

		def member_name
			member.name
		end

		# # Right now I can't put the state machine here as the persistence doesn't work through the delegated model.
		# # But I've left it here as a reminder of how it *would* work...

		# # include AASM
		# # aasm do	
		# # 	state :provisional, initial: true
		# # 	state :confirmed

		# # 	event :confirm do
		# # 		transitions from: :provisional, to: :confirmed, guards: [:confirmable?]
		# # 	end
		# # end

		# def provisional?
		# 	aasm_state == 'provisional'
		# end

		# def confirmed?
		# 	aasm_state == 'confirmed'
		# end

		# def payment_present?
		# 	payment.present?
		# end

		# # Payment is required if the course reates to a product which is chargeable but no payment exists
		# def payment_required?
		# 	has_cost? && !payment_present?
		# end

		# def may_confirm?
		# 	provisional? && !payment_required?
		# end
	end
end