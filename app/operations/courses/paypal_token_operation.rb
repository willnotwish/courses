# paypal_token_operation.rb

module Courses
	class PaypalTokenOperation < ApplicationOperation

		attr_accessor :course_membership, :user
		attr_accessor :ip_address, :return_url, :cancel_return_url

		delegate :course, to: :course_membership
		delegate :product, to: :course
		delegate :price, to: :product

		alias_method :amount, :price

		def currency
			'GBP'
		end

		def items
			[{ name: course_membership.course.name, description: 'Membership of Spa Striders course', quantity: 1, amount: amount }]
		end

		validates :course_membership, :user, :ip_address, :return_url, :cancel_return_url, presence: true
		
		def save
			return false if invalid?
			obtain_token_using_express
		end

		def express_checkout_url
			EXPRESS_GATEWAY.redirect_url_for( @token )
		end

	private

		def obtain_token_using_express
	    # items: [{name: course.name, description: "Spa Striders course membership", quantity: "1", amount: course.cost}] )
	    response = EXPRESS_GATEWAY.setup_purchase( amount,
	      ip:                ip_address,
	      return_url:        return_url,
	      cancel_return_url: cancel_return_url,
	      currency:          currency,
	      items:             items 
	    )
			@token = response.token
			@token.present?
		end
	end
end