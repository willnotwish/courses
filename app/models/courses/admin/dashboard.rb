module Courses
  class Admin::Dashboard
  	# A PORO for once
  	def courses
  		Course.all
  	end
  end
end
