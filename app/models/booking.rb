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
                                           subtotal: value["subtotal"],
                                           offer_discounts: JSON.parse(value["offer_discounts"].to_s.gsub("=>", ":").gsub(":nil,", ":null,")))
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
    filterrific :default_filter_params => {:sorted_by => 'name_asc'},
                :available_filters => %w[
                bookings_by_owner
                sorted_by
                search_query
                bookings_by_state
                bookings_by_owner_between_dates
              ]
    scope :request_assess, -> {where(cancelled_at: nil, booking_state: false, notified: false).where.not(confirmed_at: nil)}
    scope :finished, -> {
        where("date_end <= ?  AND booking_state = true", DateTime.now.to_date)
    }
    scope :bookings_by_client, -> (current_client_email) { where(client_email: current_client_email) }
    scope :bookings_by_owner, -> {
      joins(:estate).where('estates.owner_id = ?',helpers.current_owner.id)
    }
    scope :bookings_by_owner_between_dates, ->(data_attributes) {
      return nil if(data_attributes[:date_from].blank? || data_attributes[:date_to].blank?)
      where('(date_start BETWEEN ? AND ?)',
            data_attributes[:date_from], data_attributes[:date_to])
    }

    scope :sorted_by, ->(sort_option) {
      # extract the sort direction from the param value.
      direction = /desc$/.match?(sort_option) ? "desc" : "asc"
      case sort_option.to_s
      when /^client_name_/
        order("LOWER(bookings.client_name) #{direction}")
      when /^estate_name_/
        order("LOWER(estates.name) #{direction}")
          .includes(:estate).references(:estates)
      when /^created_at_/
        order("bookings.created_at #{direction}")
      when /^date_start_/
        order("bookings.date_start #{direction}")
      when /^date_end_/
        order("bookings.date_end #{direction}")
      when /^all/
        nil
      else
        nil
      end
    }

    scope :search_query, lambda { |query|
      return nil if query.blank?

      # condition query, parse into individual keywords
      terms = query.to_s.downcase.split(/\s+/)
      # replace "*" with "%" for wildcard searches,
      # append '%', remove duplicate '%'s
      terms = terms.map { |e| ('%' + e.gsub('*', '%') + '%').gsub(/%+/, '%') }
      # configure number of OR conditions for provision
      # of interpolation arguments. Adjust this if you
      # change the number of OR conditions.
      num_or_conditions = 2
      where(
          terms.map do
            or_clauses = [
                'LOWER(estates.name) LIKE ?',
                'LOWER(bookings.client_name) LIKE ?'
            ].join(' OR ')
            "(#{or_clauses})"
          end.join(' AND '),
          *terms.map { |e| [e] * num_or_conditions }.flatten
      ).joins(:estate).references(:estates)
    }

    scope :bookings_by_state, lambda { |option|
      return nil if option.blank?
      if option == 1
        Booking.finished
      else
        where("date_end >= ?  AND booking_state = true", DateTime.now.to_date)
      end
    }

    def self.options_for_sorted_by
      [
          ["Ordenar por...", "all"],
          ["Nombre de cliente (a-z)", "client_name_asc"],
          ["Nombre de cliente (z-a)", "client_name_desc"],
          ["Nombre de propiedad (a-z)", "estate_name_asc"],
          ["Nombre de propiedad (z-a)", "estate_name_desc"],
          ["Fecha de creacion (mas nuevos primero)", "created_at_desc"],
          ["Fecha de creacion (mas viejos primero)", "created_at_asc"],
          ["Fecha de entrada (mayor a menor)", "date_start_desc"],
          ["Fecha de entrada (menor a mayor)", "date_start_asc"],
          ["Fecha de salida (mayor a menor)", "date_end_desc"],
          ["Fecha de salida (menor a mayor)", "date_end_asc"],
      ]
    end

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
