# == Schema Information
#
# Table name: permissions
#
#  id          :integer          not null, primary key
#  name        :string(255)
#  description :text(65535)
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#
# Indexes
#
#  index_permissions_on_name  (name)
#

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
