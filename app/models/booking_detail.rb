class BookingDetail < ApplicationRecord
  belongs_to :booking
  has_many :room
end
