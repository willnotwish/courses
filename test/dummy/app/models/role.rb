# == Schema Information
#
# Table name: roles
#
#  id          :integer          not null, primary key
#  name        :string(255)
#  description :text(65535)
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#
# Indexes
#
#  index_roles_on_name  (name)
#

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
