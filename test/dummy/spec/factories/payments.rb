# == Schema Information
#
# Table name: payments
#
#  id         :integer          not null, primary key
#  amount     :integer
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

FactoryBot.define do
  factory :payment do
    amount 100
  end

  factory :paypal_payment do
    amount 100
    token 'foo'
    payer_id 'dummy_payer_id'
    ip_address '127.0.0.1'
    currency 'GBP'
  end
end
