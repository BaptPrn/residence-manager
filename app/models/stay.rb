class Stay < ApplicationRecord
  belongs_to :studio
  belongs_to :tenant

  validates :start_date, presence: true
  validates :end_date, presence: true
end
