class AddBasePermissions < ActiveRecord::Migration[5.1]
  def change
  	require_relative '../seeds/permissions'
  end
end
