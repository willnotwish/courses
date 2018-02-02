# == Schema Information
#
# Table name: role_permissions
#
#  id            :integer          not null, primary key
#  role_id       :integer
#  permission_id :integer
#  resource_type :string(255)
#  resource_id   :integer
#  created_at    :datetime         not null
#  updated_at    :datetime         not null
#
# Indexes
#
#  index_role_permissions_on_permission_id                  (permission_id)
#  index_role_permissions_on_resource_type_and_resource_id  (resource_type,resource_id)
#  index_role_permissions_on_role_id                        (role_id)
#
# Foreign Keys
#
#  fk_rails_...  (permission_id => permissions.id)
#  fk_rails_...  (role_id => roles.id)
#

# role_permission.rb

class RolePermission < ApplicationRecord
	belongs_to :role
	belongs_to :permission
end
