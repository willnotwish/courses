FactoryBot.define do
  factory :paypal_payment do
    token "MyString"
    payer_id "MyString"
    amount 1
    currency "MyString"
    description "MyText"
    ip_address "MyString"
    transaction_id "MyString"
    success false
    test false
  end
end
