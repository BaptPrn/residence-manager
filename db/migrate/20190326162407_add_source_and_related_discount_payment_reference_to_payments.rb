class AddSourceAndRelatedDiscountPaymentReferenceToPayments < ActiveRecord::Migration[5.2]
  def change
    add_column :payments, :source, :integer, index: true, default: 0
    add_reference :payments, :related_payment, references: :payments
  end
end
