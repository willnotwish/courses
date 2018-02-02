class CreatePaypalPayments < ActiveRecord::Migration[5.0]
  def change
    create_table :paypal_payments do |t|
      t.string :token
      t.string :payer_id
      t.integer :amount
      t.string :currency
      t.text :description
      t.string :ip_address
      t.string :transaction_id
      t.boolean :success
      t.boolean :test

      t.timestamps
    end
  end
end
