# member_decorator.rb

module Courses
	module Admin
		class MemberDecorator < ApplicationDecorator
			
			def memberships
				CourseMembership.where( member: object )
			end

			def confirmed_memberships
				memberships.where( aasm_state: 'confirmed' )
			end

			def courses
				Course.joins( :course_memberships ).merge confirmed_memberships
			end

			def payments
				# This doesn't return an AR Relation, but an array. It is easy to understand though
				# confirmed_memberships.map( &:payment )

				# There is currently no link between paypal payment and its source. Maybe there should be a polymorphic belongs_to.

				# For now (if a bit crap):
				payment_ids = confirmed_memberships.pluck( :payment_id )

				scope = Courses.payment_class.classify.constantize
				scope.where( id: payment_ids.compact )
			end
		end
	end
end


# class Payment
# 	belongs_to :source, polymorphic: true
# 	scope.joins :source
# end