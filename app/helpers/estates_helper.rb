module EstatesHelper
  def date_start(room)
    @room = room
    Booking.find(BookingDetail.find_by_room_id(@room.id).booking_id).date_start
  end

  def date_end(room)
    @room = room
    Booking.find(BookingDetail.find_by_room_id(@room.id).booking_id).date_end
  end

  def has_breakfast?(estate)
    @estate = estate
    facilities = @estate.facilities_estates
    facilities.each do |f|
      if Facility.find_by(id: f.facility_id).description == "Desayuno"
        return true
      end
    end
    return false
  end
end