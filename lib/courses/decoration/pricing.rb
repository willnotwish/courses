# pricing.rb

# To use this in a decorator or an operation, make sure the following attributes or methods are defined:
# 
# 	price - the price in pence or cents (1/100 s)
# 

module Courses
	module Decoration
		module Pricing
			def cost
				has_cost? ? number_to_currency( price/100, unit: '£' ) : nil
			end

			def has_cost?
				price && price > 0
			end
		end
	end
end