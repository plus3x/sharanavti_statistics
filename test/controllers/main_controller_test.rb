require 'test_helper'

class MainControllerTest < ActionController::TestCase
  test "should get index" do
    login_as :client
    get :index
    assert_response :success
  end

end