# payment_decorator.rb

module Courses
	module Admin
		class PaymentDecorator < ApplicationDecorator

			def date
				view_context.l object.created_at.to_date
			end

			def amount
				view_context.number_to_currency( object.amount/100, unit: '£' )
			end
		end
	end
end