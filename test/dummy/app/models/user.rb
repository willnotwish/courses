# == Schema Information
#
# Table name: users
#
#  id            :integer          not null, primary key
#  name          :string(255)
#  auth0_user_id :string(255)
#  created_at    :datetime         not null
#  updated_at    :datetime         not null
#

class User < ApplicationRecord
end
