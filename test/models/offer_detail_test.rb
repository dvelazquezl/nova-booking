require 'test_helper'

class OfferDetailTest < ActiveSupport::TestCase

  test "should not create offer_details with a discount < 1" do
    offer_detail = offer_details(:discount_less_than_1)
    assert_not offer_detail.save
  end

  test "should not create offer_details with a discount > 99" do
    offer_detail = offer_details(:discount_greater_than_99)
    assert_not offer_detail.save
  end

  test "should create offer_detail with a correct data" do
    offer_detail = offer_details(:correct_data)
    assert offer_detail.save!
  end

end
