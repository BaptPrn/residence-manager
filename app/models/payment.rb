class Payment < ApplicationRecord
  belongs_to :stay

  validates :date, presence: true
end
