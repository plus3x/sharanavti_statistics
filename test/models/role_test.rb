require 'test_helper'

class RoleTest < ActiveSupport::TestCase
  test "Role admin have permission to create new user" do
    assert roles(:admin).permit?('users', 'new'), 'Role admin must have permissions to create new user'
  end
end
