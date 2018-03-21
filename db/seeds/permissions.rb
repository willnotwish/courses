# permissions.rb

%w( course.show 
	  course.update 
	  course.publish 
	  course.restrict 
	  course.delete
	  course.list_memberships
	  course.update_memberships
	  course.create_memberships
	  course_memberships.list
	  course_memberships.update
	  course_memberships.cancel
	  course_memberships.delete ).each do |name|

	Permission.where( name: name ).first_or_create!

end