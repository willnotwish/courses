# role.rb

class Role < ApplicationRecord
	has_many :role_permissions
	has_many :permissions, through: :role_permissions

	def has_permission_to?( action_name )
		permissions.merge( Permission.to(action_name) ).present?
	end

	class << self
		def with_permission_to( action )
			joins( :permissions ).merge( Permission.to( action ) )
		end	
	end
end