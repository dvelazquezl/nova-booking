require 'test_helper'

class RoleTest < ActiveSupport::TestCase
  test 'Should create a role without errors' do
    role = roles(:role)
    assert role.save
  end
end