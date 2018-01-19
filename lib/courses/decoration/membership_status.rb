# membership_status.rb

# To use this in a decorator or an operation, make sure attributes or methods aasm_state and payment exist

# Right now I can't put the state machine here as AASM persistence doesn't work through a delegated model.		
# But I've left it here as a reminder of how it *would* work...
# include AASM
# aasm do	
# 	state :provisional, initial: true
# 	state :confirmed

# 	event :confirm do
# 		transitions from: :provisional, to: :confirmed, guards: [:confirmable?]
# 	end
# end

module Courses
	module Decoration
		module MembershipStatus

			def provisional?
				aasm_state == 'provisional'
			end

			def confirmed?
				aasm_state == 'confirmed'
			end			
	
			def payment_present?
				payment.present?
			end
			alias_method :payment_made?, :payment_present?

			# Payment is required if the course relates to a product which is chargeable but no payment exists
			def payment_required?
				has_cost? && !payment_present?
			end

			def may_confirm?
				provisional? && !payment_required?
			end
		end
	end
end
