module Courses
  class UserRole < ApplicationRecord
    belongs_to :role, optional: true   # if the role is nil it implies "all roles"
    belongs_to :user
    belongs_to :course, optional: true # if the course is nil it implies "all courses"

    # delegate :role_permissions, :permissions, to: :role, allow_nil: true

    class << self
    	def for_user( user )
    		where( user: user )
    	end

    	def with_permission_to( action )
    		where( role: [nil, Role.with_permission_to( action ).ids] )
    	end

    	def for_course( course )
    		where( course: [course, nil] )
    	end
    end
  end
end



# module Permissions extend ActiveSupport::Concern

# 	included do
# 		has_many :user_roles
# 		has_many :roles, through: :user_roles
# 		has_many :role_permissions, through: :roles
# 		has_many :permissions, through: :role_permissions
# 	end

# 	# Call like this:
# 	# 	user.has_permission_to? :list, :courses
# 	# or
# 	# 	user.has_permission_to? :show, @course
	
# 	def has_permission_to?( *args )
# 		options = args.extract_options!

# 		action   = args[0] || options[:action]
# 		resource = args[1] || options[:resource]

# 		# Here are the relationships:

# 		# user -> user_roles -> roles -> role_permissions -> permissions

# 		# First, check if the user has permission to do *anything* (everything - all roles)
# 		return true if user_roles.where( role: nil ).present?

# 		# Otherwise, start with the action, defined by the permissions
# 		p = Permission.arel_table
# 		c = p[:name].eq( nil ) # a name of nil means "all" or "any" permission (that is "admin rights")
# 		c = c.or( p[:name].eq( action ) ) if action

# 		scope = permissions.where c
		
# 		# Now the user roles
# 		# This is a little awkward because of the polymorphic belongs_to. I've spelled it out...
# 		t = UserRole.arel_table
		
# 		condition = if resource.nil?
# 									t[:resource_id].eq( nil )
# 								elsif resource.respond_to?(:id)	
# 									c1 = t[:resource_id].eq( resource.id ).and t[:resource_type].eq( resource.class.name )
# 									c2 = t[:resource_id].eq( nil ).and t[:resource_type].eq( resource.class.name )
# 									c3 = t[:resource_id].eq( nil ).and t[:resource_type].eq( nil )
# 									c1.or(c2).or(c3)
# 								else
# 									# Just match on resource type - we're not interested in the resource id
# 									c1 = t[:resource_type].eq( resource.to_s.classify )
# 									c2 = t[:resource_type].eq( nil )
# 									c1.or(c2)
# 								end
								
# 		scope.where( condition ).present?
# 	end

# 	module ClassMethods
# 	end
# end