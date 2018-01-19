# decorator_helpers.rb

module Courses
	module DecoratorHelpers extend ActiveSupport::Concern

		included do
	  	class_attribute :decorator_class_name, instance_accessor: false
		  helper_method :decorate   # can call this in views
		end

		def decorate( model, opts={} )
			class_name = opts[:class_name].present? ? opts[:class_name] : decorator_class_name_for( model )
			class_name.constantize.new( object: model, view_context: view_context ).tap do |decorator|
		    yield decorator if block_given?
	    end
		end

		def decorator_class_name_for( model )
			self.class.decorator_class_name || "#{controller_path.singularize}_decorator".classify
		end

		module ClassMethods
			def set_decorator_class_name( name, opts = {} )
				self.decorator_class_name = name
			end
		end
	end
end

