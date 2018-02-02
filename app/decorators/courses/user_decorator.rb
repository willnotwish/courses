module Courses

	# Note. Don't put policy scopes in here. This is a decorator. Put them in the policy instead.

	class UserDecorator < ApplicationDecorator

  	alias_method :user, :object

  	delegate :name, to: :user

  	def courses
  		Courses::Course.with_membership_for( user )
  	end

  	def confirmed_courses
  		Courses::Course.with_confirmed_membership_for( user )
  	end

  	def confirmed_on?( course )
  		Courses::CourseMembership.confirmed.for_member( user ).for_course( course ).exists?
  	end

  	def enrolled_provisionally_on?( course )
  		Courses::CourseMembership.provisional.for_member( user ).for_course( course ).exists?
  	end
  end
end
