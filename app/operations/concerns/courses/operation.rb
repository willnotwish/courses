# operation.rb

module Courses
	module Operation 
		extend ActiveSupport::Concern

		include ActiveModel::Model
		include ActiveModel::Validations
		include ActiveRecord::AttributeAssignment

		included do
			attr_accessor :record
			delegate :to_model, :persisted?, to: :record

			class_attribute :record_name, instance_writer: false
			set_record_name default_record_name
		end

		def initialize( attrs )
			self.record = attrs[record_name]
			raise "#{record_name} must be specified as an attribue. If this looks wrong, try setting the record name explicitly with set_record_name" unless record
			super attrs.except( record_name )
		end

		def save
			return false if invalid?
			record.save			
		end

		module ClassMethods
			def update( attrs )
				new( attrs ).tap { |op| op.save }
			end

			def set_record_name( name )
				self.record_name = name
			end

			def default_record_name
				name.demodulize[/(.*)Operation/,1].underscore.to_sym
			end
		end
	end
end