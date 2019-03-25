class Stay < ApplicationRecord
  belongs_to :studio
  belongs_to :tenant

  validates :start_date, presence: true
  validates :end_date, presence: true

  validate :check_studio_availability

  private

  def check_studio_availability
    conflictual_stays = Stay.where(studio_id: studio_id).where('start_date < ? AND end_date > ? OR start_date < ? AND end_date > ?', start_date, start_date, end_date, end_date )
    errors.add(:base, 'Sorry, the studio you are trying to book is not available on those dates') if conflictual_stays.present?
  end
end
