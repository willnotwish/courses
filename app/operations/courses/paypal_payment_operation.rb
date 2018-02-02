# payment_operation.rb

module Courses
	class PaypalPaymentOperation < ApplicationOperation

		attr_accessor :course_membership, :user
		attr_accessor :paypal_token, :paypal_payer_id, :ip_address

		delegate :course, to: :course_membership
		delegate :product, to: :course
		delegate :price, to: :product

		alias_method :amount, :price

		def currency
			'GBP'
		end

		validates :course_membership, :user, :paypal_token, :paypal_payer_id, :ip_address, presence: true

		def save
			return false if invalid?
			course_membership.confirm! payment

			# PaypalPayment.transaction do
			# 	paypal_payment.save && course_membership.update( payment: paypal_payment, aasm_state: 'confirmed' )	
			# end
		end

	private

		def payment
			PaypalPayment.new( token: paypal_token, payer_id: paypal_payer_id, ip_address: ip_address, amount: amount, currency: currency )
		end
	end
end