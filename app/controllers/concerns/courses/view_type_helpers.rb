# view_type_helpers.rb

module Courses

	module ViewTypeHelpers
		extend ActiveSupport::Concern

		included do
			with_options instance_accessor: false do
		  	class_attribute :view_type_name,
					              :view_type_class_name
			end

	    helper_method :current_view_type, :view_type_selector
			before_action :build_view_type, only: [:index]
		end

		def view_type_name
			self.class.view_type_name || "#{controller_path.singularize}_view_type"
		end

		def view_type_class
			(self.class.view_type_class_name || view_type_name.classify).constantize
		end

		def build_view_type
			@_view_type = view_type_class.new( view_type_params )
		end

		def current_view_type
			@_view_type
		end

		def view_type_params
			params.fetch( :vt, default_view_type_params ).permit( :t )
		end

		def default_view_type_params
			{ t: 'list' }
		end

		def view_type_selector( options = {} )
			'View type selector coming soon'	
		end

		module ClassMethods
			def view_using( view_type_name, opts = {} )
				self.view_type_name = view_type_name.to_s	
				self.view_type_class_name = opts[:class_name]
			end
		end
	end

end