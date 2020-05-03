class CancellationMotive < ApplicationRecord
  has_many :bookings
  self.per_page = 5
  resourcify
end
