class RemoveResourceFromRolePermissions < ActiveRecord::Migration[5.0]
  def change
  	remove_column :role_permissions, :resource_type, :string
  	remove_column :role_permissions, :resource_id, :integer
  end
end
