# frozen_string_literal: true

require 'test_helper'

class EstateTest < ActiveSupport::TestCase
  test 'should not create estate without a name' do
    estate = estates(:empty_name)
    assert_not estate.save
  end

  test 'should not create estate with out an address' do
    estate = estates(:empty_address)
    assert_not estate.save
  end

  test 'should not rate a estate with values > 10' do
    estate = Estate.all.first
    estate.inc_comments
    estate.update_score(32)
    assert_not estate.save
  end

  test 'should not rate a estate with values <= 0 ' do
    estate = Estate.all.first
    estate.inc_comments
    estate.update_score(-45)
    assert_not estate.save
  end

end
