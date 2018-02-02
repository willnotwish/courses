# user_decorator.rb

module Courses

	class MemberDecorator < ApplicationDecorator
		
		delegate :name, to: :object

	end
end
