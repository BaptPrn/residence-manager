class Stay < ApplicationRecord
  belongs_to :studio
  belongs_to :tenant

  has_many :payments, dependent: :destroy
  has_many :discounts, dependent: :destroy

  validates :start_date, presence: true
  validates :end_date, presence: true

  validate :check_studio_availability

  after_create :generate_payments # I voluntarily did not work on an updating system (in case a stay is shortened for example) as it would imply some complications that did not seem to be part of the question.

  def total_rent_price
    payments.rent.sum(&:price)
  end

  def total_discount_amount
    payments.discount.sum(&:price)
  end

  def total_price
    total_rent_price + total_discount_amount
  end

  private

  def check_studio_availability
    conflictual_stays = Stay.where(studio_id: studio_id).where('start_date < ? AND end_date > ? OR start_date < ? AND end_date > ?', start_date, start_date, end_date, end_date )
    errors.add(:base, 'Sorry, the studio you are trying to book is not available on those dates') if conflictual_stays.present?
  end

  def generate_payments
    PaymentService.new(stay: self).create_monthly_payments
  end
end
