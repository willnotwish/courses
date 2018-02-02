# permission.rb

class Permission < ApplicationRecord
	has_many :role_permissions
	has_many :roles, through: :role_permissions
	
	validates :name, uniqueness: true   # nil => all permissions (eg, super user)

	class << self	
		def to( action )
			where( name: [action, nil] )
		end
	end
end