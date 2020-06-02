class BookingDetail < ApplicationRecord
    belongs_to :room
    belongs_to :booking
    validates :quantity, numericality: { greater_than: 0 }
    validates :subtotal, numericality: { greater_than: 0 }
end
