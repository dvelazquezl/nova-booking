require 'test_helper'

class DepartamentTest < ActiveSupport::TestCase

  test "should create departament with correct name" do
    departament = departaments(:correct_data)
    assert departament.save!
  end

  test "should not create departament with incorrect name" do
    departament = departaments(:incorrect_name)
    assert_not departament.save
  end

  test "should not create departament with empty name" do
    departament = departaments(:empty_name)
    assert_not departament.save
  end
end