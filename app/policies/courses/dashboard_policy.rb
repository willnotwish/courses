module Courses
  class DashboardPolicy < ApplicationPolicy
  	def show?
  		user.present?	
  	end
  end
end
