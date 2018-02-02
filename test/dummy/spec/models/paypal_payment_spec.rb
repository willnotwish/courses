# == Schema Information
#
# Table name: paypal_payments
#
#  id             :integer          not null, primary key
#  token          :string(255)
#  payer_id       :string(255)
#  amount         :integer
#  currency       :string(255)
#  description    :text(65535)
#  ip_address     :string(255)
#  transaction_id :string(255)
#  success        :boolean
#  test           :boolean
#  created_at     :datetime         not null
#  updated_at     :datetime         not null
#

require 'rails_helper'

RSpec.describe PaypalPayment, type: :model do
  pending "add some examples to (or delete) #{__FILE__}"
end
