# course_decorator.rb

module Courses
	module Admin	
		class CourseDecorator < ApplicationDecorator
			
			delegate :starts_at, 
			         :name, 
			         :duration, 
			         :guest_period_expires_at, 
			         :enrolment_opens_at, 
			         :capacity, 
			         :course_memberships,
			         :confirmed_memberships,
			         :provisional_memberships,
			         :members,
			         :confirmed_members,
			         :provisional_members,
			         :product, 
			         :description, 
				to: :object

			include Decoration::Course::Timing
			include Decoration::Course::GuestStatus
			include Decoration::Course::Enrolment
			include Decoration::Course::Pricing
			include Decoration::Course::Description
		end
	end
end