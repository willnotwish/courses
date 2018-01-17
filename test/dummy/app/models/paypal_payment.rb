class PaypalPayment < ApplicationRecord
	attr_accessor :return_url, :cancel_return_url # transient attributes required to setup the purchase
	attr_reader :items

	validates :token, :payer_id, :ip_address, presence: true
	validates :amount, numericality: {only_integer: true, greater_than: 0}
	validates :currency, inclusion: {in: %w(GBP)}

	before_create :do_purchase!

	def token
		self[:token] ||= setup_purchase
	end

	def express_checkout_url
		EXPRESS_GATEWAY.redirect_url_for( token )
	end

	def details
		EXPRESS_GATEWAY.details_for( token )
	end

	def items= (new_items)
		@items = new_items.collect do |item| 
			{
				name:        item[:name],
				description: item[:description],
				quantity:    item[:quantity].to_i,
				amount:      item[:amount].to_i
			}
		end
	end

	def amount= (new_amount)
		self[:amount] = new_amount.to_i
	end

private

	def setup_purchase
    # items: [{name: course.name, description: "Spa Striders course membership", quantity: "1", amount: course.cost}] )
    response = EXPRESS_GATEWAY.setup_purchase( amount,
      ip:                ip_address,
      return_url:        return_url,
      cancel_return_url: cancel_return_url,
      currency:          currency,
      items:             items 
    )
		response.token
	end

	def do_purchase!
		response = EXPRESS_GATEWAY.purchase( amount, 
			ip:       ip_address, 
			token:    token, 
			payer_id: payer_id, 
			currency: currency 
		)
		self.success = response.success?
		self.test = response.test?

		self.transaction_id = response.authorization if response.success?
		
		response.success? ? true : false # must return exactly false to cancel the save operation (database write)
	end
end
