require 'test_helper'
class CommentTest < ActiveSupport::TestCase
  test "should create comment with correct data" do
    comment = comments(:correct_data)
    assert comment.save
  end

  test "should not create comment with empty data" do
    comment = comments(:empty_data)
    assert_not comment.save
  end

  test "should not create comment without rating" do
    comment = comments(:empty_rating)
    assert_not comment.save
  end

  test "should not create comment without client email" do
    comment = comments(:empty_client_email)
    assert_not comment.save
  end

  test "should not create comment without client name" do
    comment = comments(:empty_client_name)
    assert_not comment.save
  end

  test "should not create comment without description" do
    comment = comments(:empty_description)
    assert_not comment.save
  end
end