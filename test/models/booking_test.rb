require 'test_helper'

class BookingTest < ActiveSupport::TestCase
  test 'should save booking with correct data' do
    booking = bookings(:correct_data)
    assert booking.save
  end

  test 'should bring bookings by client email' do
    booking = bookings(:correct_data)
    booking.save
    searched_booking = Booking.bookings_by_client(booking.client_email).first
    assert_equal searched_booking, booking
  end

  test 'should bring correct booking for request access' do
    booking = bookings(:correct_data)
    booking.save
    searched_booking = Booking.request_assess.first
    assert_equal searched_booking, booking
  end

  test 'should not save booking without state' do
    booking = bookings(:without_state)
    assert_not booking.save
  end

end
