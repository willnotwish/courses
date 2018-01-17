# decorator_helpers.rb

module Courses
	module DecoratorHelpers 
		extend ActiveSupport::Concern

		included do
			with_options instance_accessor: false do
		  	class_attribute :decorator_class_name
			end
		  helper_method :decorate   # can call this in views
		end

		def decorator_class_for( model )
			class_name = self.class.decorator_class_name || "#{controller_path.singularize}_decorator".classify
			class_name.constantize
		end

		def decorate( model, opts={} )
			klass = opts[:class_name] ? opts[:class_name].constantize : decorator_class_for( model )
			klass.new( object: model, view_context: view_context ).tap do |decorator|
		    yield decorator if block_given?
	    end
		end

		module ClassMethods
			def set_decorator_class_name( name, opts = {} )
				self.decorator_class_name = name
			end
		end
	end
end

