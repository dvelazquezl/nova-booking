require 'test_helper'
class OwnerTest < ActiveSupport::TestCase
  test "Should not create owner with all fields empty" do
    owner = owners(:empty_owner)
    assert_not owner.save
  end
  #test "Should create owner with all fields" do
  # owner = owners(:correct_owner)
  # assert owner.save
  #end
  test "Should not create owner with incorrect phone" do
    owner = owners(:incorrect_phone_owner)
    assert_not owner.save
  end
  test "Should not create owner with incorrect address" do
    owner = owners(:incorrect_address_owner)
    assert_not owner.save
  end
  test "Should not create owner with incorrect about" do
    owner = owners(:incorrect_about_owner)
    assert_not owner.save
  end
end