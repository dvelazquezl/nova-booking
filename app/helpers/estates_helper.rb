module EstatesHelper
  def date_start(room)
    @room = room
    Booking.find(BookingDetail.find_by_room_id(@room.id).booking_id).date_start
  end

  def date_end(room)
    @room = room
    Booking.find(BookingDetail.find_by_room_id(@room.id).booking_id).date_end
  end
end