# frozen_string_literal: true

require 'test_helper'

class RoomTest < ActiveSupport::TestCase
  test 'should create room with correct data' do
    room = rooms(:correct_data)
    assert room.save
  end

  test 'should not create room without a description' do
    room = rooms(:empty_description)
    assert_not room.save
  end

  test 'should not create room without a status' do
    room = rooms(:empty_status)
    assert_not room.save
  end

  test 'should not create room without a room_type' do
    room = rooms(:empty_room_type)
    assert_not room.save
  end

  test 'should not create room with capacity < 1' do
    room = rooms(:capacity_less_than_1)
    assert_not room.save
  end

  test 'should not create room with price < 1' do
    room = rooms(:price_less_than_1)
    assert_not room.save
  end
end