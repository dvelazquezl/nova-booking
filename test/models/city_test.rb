require 'test_helper'

class CityTest < ActiveSupport::TestCase

  test "should create city with correct name" do
    city = cities(:correct_data)
    assert city.save!
  end

  test "should not create city with incorrect name" do
    city = cities(:incorrect_city_name)
    assert_not city.save
  end

  test "should not create city with empty name" do
    city = cities(:empty_name)
    assert_not city.save
  end

end