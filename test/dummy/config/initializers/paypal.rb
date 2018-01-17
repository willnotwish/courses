# paypal.rb

require 'activemerchant'

Rails.application.secrets.tap do |secrets|

	paypal_options = {
	  login:     secrets.paypal_login,
	  password:  secrets.paypal_password,
	  signature: secrets.paypal_signature
	}

	::EXPRESS_GATEWAY = ActiveMerchant::Billing::PaypalExpressGateway.new( paypal_options )

end
