# pricing.rb

module Courses
	module Decoration
		module Course
			module Pricing

				def product_name
					product ? product.name : nil
				end

				def cost
					has_cost? ? view_context.number_to_currency( product.price/100, unit: '£' ) : nil
				end

				def has_cost?
					product && product.price && product.price > 0
				end
			end
		end
	end
end