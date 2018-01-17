# course_membership_decorator.rb

require 'aasm'


module Courses
	class CourseMembershipDecorator < ApplicationDecorator

		delegate :course, :member, :payment, :aasm_state, to: :object
		delegate :product, to: :course

		include Decoration::Course::Pricing

		def course_name
			course.name
		end

		# Right now I can't put the state machine here as the persistence doesn't work through the delegated model.
		# But I've left it here as a reminder of how it *would* work...

		# include AASM
		# aasm do	
		# 	state :provisional, initial: true
		# 	state :confirmed

		# 	event :confirm do
		# 		transitions from: :provisional, to: :confirmed, guards: [:confirmable?]
		# 	end
		# end

		def provisional?
			aasm_state == 'provisional'
		end

		def confirmed?
			aasm_state == 'confirmed'
		end

		def payment_present?
			payment.present?
		end

		# Payment is required if the course reates to a product which is chargeable but no payment exists
		def payment_required?
			has_cost? && !payment_present?
		end

		def may_confirm?
			provisional? && !payment_required?
		end
	end
end