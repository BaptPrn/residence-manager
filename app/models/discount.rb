class Discount < ApplicationRecord
  belongs_to :stay
  has_many :payments, through: :stay

  validates :start_date, presence: true
  validates :end_date, presence: true

  after_create :create_discount_payments

  default_scope { order('start_date ASC') }

  def value_in_percentage
    discount_percentage_value / 100.0
  end
  private

  def create_discount_payments
    PaymentService.new(discount: self).create_monthly_payments
  end
end
