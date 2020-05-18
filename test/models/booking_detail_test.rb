require 'test_helper'

class BookingDetailTest < ActiveSupport::TestCase

  test "should not create booking detail with quantity 0" do
    booking_detail_with_quantity_0 = booking_details(:bd_quantity_0)
    assert_not booking_detail_with_quantity_0.save
  end

  test "should not create booking detail with subtotal 0" do
    booking_detail_with_subtotal_0 = booking_details(:bd_subtotal_0)
    assert_not booking_detail_with_subtotal_0.save
  end

  test "should create booking detail with correct data" do
    booking_detail = booking_details(:bd_correct_data)
    assert booking_detail.save, "booking detail not saved"
  end

end
