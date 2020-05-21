require 'test_helper'

class OfferTest < ActiveSupport::TestCase

  test "should not create offer without a description" do
    offer = offers(:empty_description)
    assert_not offer.save
  end

  test "should not create offer without a start date" do
    offer = offers(:empty_start_date)
    assert_not offer.save
  end

  test "should not create offer without a end date" do
    offer = offers(:empty_end_date)
    assert_not offer.save
  end

  test "should not create offer without a creation date" do
    offer = offers(:empty_creation_date)
    assert_not offer.save
  end

  test "should not create offer with a start date in the past" do
    offer = offers(:start_date_in_past)
    assert_not offer.save
  end

  test "should not create offer with a end date less than start date" do
    offer = offers(:end_date_less_than_start)
    assert_not offer.save
  end

  test "should create offer with a correct data" do
    offer = offers(:correct_data)
    assert offer.save!
  end

end