class Booking < ApplicationRecord
    has_many :booking_details
    belongs_to :estate
    has_secure_token :confirmation_token
    accepts_nested_attributes_for :booking_details, :allow_destroy => true

    delegate :name, :images, :to => :estate, :prefix => true

    extend Enumerize

    enumerize :cancellation_motive, in: [ :change_of_date,
                                          :personal_motive,
                                          :more_than_one_booking,
                                          :better_option,
                                          :none_of_the_above
                                        ]

    def self.booking_new(booking,params)
        booking.estate_id = params[:estate_id]
        booking.client_name = params[:client_name]
        booking.date_start = params[:date_start]
        booking.date_end = params[:date_end]
        booking.total_amount = params[:total_amount]
        booking.discount = params[:discount]
        booking.booking_state = true
        booking_details = JSON.parse(CGI.unescape(params[:booking_details]))
        booking_details.each {|value|
            booking.booking_details.build(room_id: value["room_id"],
                                           quantity: value["quantity"],
                                           subtotal: value["subtotal"])
        }
        booking
    end

    def self.set_state(booking)
        booking.confirmed_at = Time.now()
        booking.booking_state = true
        booking.save
        UserMailer.new_booking(booking).deliver_now
        UserMailer.new_booking_owner(booking).deliver_now
    end

    def self.estate(booking)
        Estate.find(Room.find(booking.booking_details[0].room_id).estate_id)
    end
    def self.diff(booking)
        return diff = (booking.date_end.to_date -  booking.date_start.to_date).to_i
    end

    scope :request_assess, -> {where(cancelled_at: nil, booking_state: false, notified: false).where.not(confirmed_at: nil)}
    scope :finished, -> {
        where("date_end <= ?  AND booking_state = true", DateTime.now.to_date)
    }
    scope :bookings_by_client, -> (current_client_email) { where(client_email: current_client_email) }
    scope :bookings_by_owner, -> (current_owner_id) {
        joins(:estate).where('estates.owner_id = ?',current_owner_id)
    }

    self.per_page = 5
    resourcify

    # for user
    def self.update_booking_attributes(booking, cancellation_motive)
      booking.cancelled_at = Time.now()
      booking.booking_state = false
      booking.cancellation_motive = cancellation_motive

      booking.save
      UserMailer.booking_cancelled_by_user_to_owner(booking).deliver_now
      UserMailer.booking_cancelled_by_user_to_user(booking).deliver_now
    end

    # for owner
    def self.update_booking_attr(booking)
      booking.cancelled_at = Time.now()
      booking.booking_state = false

      booking.save
      UserMailer.booking_cancelled_by_owner_to_owner(booking).deliver_now
      UserMailer.booking_cancelled_by_owner_to_client(booking).deliver_now
    end
end
