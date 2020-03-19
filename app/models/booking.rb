class Booking < ApplicationRecord
    has_many :booking_details
    accepts_nested_attributes_for :booking_details, :allow_destroy => true
end
