require 'test_helper'

class CityTest < ActiveSupport::TestCase

  test "should create city with correct name" do
    city = city(:correct_data)
    assert city.save!
  end

  test "should create city with incorrect name" do
    city = city(:incorrect_city_name)
    assert_not city.save
  end

  test "should create city with incorrect departament" do
    city = city(:incorrect_departament_name)
    assert_not city.save
  end

end
