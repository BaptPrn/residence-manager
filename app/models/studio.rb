class Studio < ApplicationRecord
  has_many :stays
  has_many :tenants, through: :stays

  validates :name, presence: true
end
