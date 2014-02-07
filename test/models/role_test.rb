require 'test_helper'

class RoleTest < ActiveSupport::TestCase
  test "role admin must have permissions to add user" do
    assert roles(:admin).permit?('users', 'new'), 'Role admin must have permissions to create new user'
    assert roles(:admin).permit?('users', 'create'), 'Role admin must have permissions to create create user'
  end

  test "role client must have permissions to online and on date" do
    assert roles(:client).permit?('main', 'index'), 'Role client must have permissions to online'
    assert roles(:client).permit?('charts', 'on_date'), 'Role client must have permissions to on date'
  end
end
