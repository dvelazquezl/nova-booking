class Booking < ApplicationRecord
    has_many :booking_details
    accepts_nested_attributes_for :booking_details, :allow_destroy => true

    def self.booking_new(booking,params)
        booking.client_name = params[:client_name]
        booking.date_start = params[:date_start]
        booking.date_end = params[:date_start]
        booking.total_amount = params[:total_amount]
        booking.booking_state = true
        booking_details = JSON.parse(CGI.unescape(params[:booking_details]))
        booking_details.each {|value|
            booking.booking_details.build(room_id: value["room_id"],
                                           quantity: value["quantity"],
                                           subtotal: value["subtotal"])
        }
        booking
    end
end
