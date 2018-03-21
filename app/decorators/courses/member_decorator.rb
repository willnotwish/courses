# user_decorator.rb
require_dependency "courses/application_decorator"   # needed sometimes (I'm not sure when). Best to include it always.

module Courses

	class MemberDecorator < ApplicationDecorator
		
		delegate :name, to: :object

	end
end
