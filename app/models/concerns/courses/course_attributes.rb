# course_attributes.rb

module Courses
	module CourseAttributes extend ActiveSupport::Concern
  	include ActiveModel::Model
  	include ActiveModel::Validations
    include ActiveRecord::AttributeAssignment

		included do
			class_attribute :attr_names, instance_writer: false
			
			define_attrs %i( owner 
				name 
				duration_in_weeks 
				description 
				capacity 
				starts_at 
				enrolment_opens_at 
				enrolment_closes_at 
				product_id 
				guest_period_expires_at
				terms_and_conditions 
				include_provisional_in_capacity 
			)

	  	validates :owner, :name, presence: true
  		validates :duration_in_weeks, :capacity, numericality: { integer: true, greater_than: 0 }, allow_blank: true
		end

  	def duration=( seconds )
  		self.duration_in_weeks = seconds ? seconds/604800 : nil
  	end

  	def duration
  		duration_in_weeks.present? ? duration_in_weeks.to_i.weeks : nil
  	end

  	def attrs
  		attr_names.reduce( {} ) { |hash, name| hash[name] = self.send( name ); hash }
  	end

		module ClassMethods
			def define_attrs( names )
				self.attr_names = names
				names.each { |name| attr_accessor name }				
			end
		end		
	end
end