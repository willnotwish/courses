# == Schema Information
#
# Table name: payments
#
#  id         :integer          not null, primary key
#  amount     :integer
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class Payment < ApplicationRecord
end
