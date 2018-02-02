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

# permissions.rb

FactoryBot.define do
	factory :permission do
		name "bar"
	end
end
