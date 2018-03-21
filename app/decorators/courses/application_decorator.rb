# application_decorator.rb

module Courses

	# NEW Now inherits from main app's corresponding class
	class ApplicationDecorator < ::ApplicationDecorator
		# include ActiveModel::Model

		# attr_accessor :object, :view_context

		# delegate :id, to: :object, allow_nil: true

		# delegate :to_model, to: :object   # allows url generation to work as expected

		# # Delegate common view helpers to the view context
		# delegate :render, :content_tag, :link_to, :markdown, :image_tag, :current_user, :decorate, :number_to_currency, :l, :policy, to: :view_context

		# def format_currency( pence, unit = '£' )
		# 	number_to_currency( pence/100, unit: unit )
		# end

		# def status_label
		# 	render partial: 'status_label', object: object.aasm, as: :aasm
		# end

		# # include PunditPolicies
		# def may_update?
		# 	policy( object ).update?
		# end
		# alias_method :may_be_updated?, :may_update?

		# def may_show?
		# 	policy( object ).show?
		# end
		# alias_method :may_view?, :may_show?
		# alias_method :may_be_shown?, :may_show?

		# def may_delete?
		# 	policy( object ).delete?
		# end
		# alias_method :may_be_deleted?, :may_delete?

		# cattr_accessor( :logger ) { Rails.logger }
	end
end
