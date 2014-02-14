require 'test_helper'

class UserTest < ActiveSupport::TestCase
  test "should have role" do
    assert users(:admin).admin?,   "User #{  users(:admin).email } is not admin"
    assert users(:client).client?, "User #{ users(:client).email } is not client"
  end
  
  test "should user can" do
    assert users(:admin).can?( 'users', 'destroy'), "Administrator must have permission to destroy user"
    assert users(:client).can?( 'main', 'index'  ), "Client must have permission to main page"
  end
  
  test "user email must be certain format" do
    good = User.new(email: 'good@will.com', password: 'secret', password_confirmation: 'secret')
    assert good.valid?, 'Email must be good'
    assert_not good.errors[:email].any?, 'Email must be certain format'
    
    bad = User.new(email: '@bad.com', password: 'secret', password_confirmation: 'secret')
    assert bad.invalid?, 'Bad email must be invalid'
    assert bad.errors[:email].any?, 'Bad email must be invalid format'
  end
end
