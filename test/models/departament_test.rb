require 'test_helper'

class DepartamentTest < ActiveSupport::TestCase

  test "should create department with correct name" do
    departament = departament(:correct_name)
    assert departament.save!
  end

  test "should not create department with incorrect name" do
    departament = departament(:incorrect_name)
    assert_not departament.save
  end
end
