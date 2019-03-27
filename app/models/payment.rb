class Payment < ApplicationRecord
  enum source: { rent: 0, discount: 1 } # The goal here is to keep a separate trace of all rents and discounts, so that discounts can easily be reverted and we can access the total discount amount if necessary.

  belongs_to :stay
  belongs_to :related_rent_payment, optional: true, class_name: 'Payment', foreign_key: :related_payment_id
  has_many :related_discount_payments, class_name: 'Payment', foreign_key: :related_payment_id

  validates :date, presence: true
  default_scope { order('date ASC') }

  def discount_value
    related_discount_payments.sum(&:price)
  end

  def value_after_discount
    price + discount_value
  end
end
