require 'test_helper'

class UserTest < ActiveSupport::TestCase
  test 'Should create a user without errors' do
    user = users(:user)
    assert user.save
  end

  test 'Should not create a user without name' do
    user = users(:user_no_name)
    assert_not user.save
  end

  test 'Should not create a user with name length less than two' do
    user = users(:user_name_length_less_than_two)
    assert_not user.save
  end

  test 'Should not create a user with name length more than 50' do
    user = users(:user_name_length_more_than_50)
    assert_not user.save
  end

  test 'Should not create a user without last name' do
    user = users(:user_no_last_name)
    assert_not user.save
  end

  test 'Should not create a user with last name length less than two' do
    user = users(:user_last_name_length_less_than_two)
    assert_not user.save
  end

  test 'Should not create a user with last name length more than 50' do
    user = users(:user_last_name_length_more_than_50)
    assert_not user.save
  end

  test 'Should not create a user without username' do
    user = users(:user_no_username)
    assert_not user.save
  end

  test 'Should not create a user with username length less than five' do
    user = users(:user_username_length_less_than_five)
    assert_not user.save
  end

  test 'Should not create a user with username length more than 20' do
    user = users(:user_username_length_more_than_20)
    assert_not user.save
  end

  test 'Should not create a user with a existing username' do
    user = users(:user)
    user2 = User.new(name: user.name, last_name: user.last_name,
                     username: user.username, email: 'fusu6780@gmail.com',
                     password: user.encrypted_password)
    assert_not user2.save
  end

  test 'Should not create a user with not valid username' do
    user = users(:user_username_not_valid)
    assert_not user.save
  end

  test 'Should not create a user without email' do
    user = users(:user)
    user = User.new(name: user.name, last_name: user.last_name,
                    username: 'fusu78904',
                    password: user.encrypted_password)
    user.skip_confirmation!
    assert_not user.save
  end

  test 'Should not create a user with not valid email' do
    user = users(:user_email_not_valid)
    user = User.new(name: user.name, last_name: user.last_name,
                    username: user.username, email: user.email,
                    password: user.encrypted_password)
    user.skip_confirmation!
    assert_not user.save
  end

  test 'Should not create a user with a existing email' do
    user = users(:user)
    user2 = User.new(name: user.name, last_name: user.last_name,
                     username: 'fusu78903', email: user.email,
                     password: user.encrypted_password)
    user2.skip_confirmation!
    assert_not user2.save
  end
  test 'Should create a user with a role' do
    user = users(:user_role)
    user = User.new(name: user.name, last_name: user.last_name,
                    username: 'username', email: 'user@email.com',
                    password: user.encrypted_password)

    user.skip_confirmation!
    user.add_role('admin')
    assert user.save
  end
end