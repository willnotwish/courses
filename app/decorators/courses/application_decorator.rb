# application_decorator.rb

module Courses
	class ApplicationDecorator
		include ActiveModel::Model

		attr_accessor :object, :view_context

		delegate :id, to: :object, allow_nil: true

		delegate :to_model, to: :object   # allows url generation to work as expected

		# Delegate common view helpers to the view context
		delegate :content_tag, :link_to, :markdown, :image_tag, :current_user, :decorate, to: :view_context

		cattr_accessor( :logger ) { Rails.logger }
	end
end
