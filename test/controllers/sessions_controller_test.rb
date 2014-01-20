require 'test_helper'

class SessionsControllerTest < ActionController::TestCase
  test "should get new" do
    get :new
    assert_response :success
  end
  
  test "should login" do
    dave = users(:client)
    post :create, email: dave.email, password: 'client'
    assert_redirected_to main_url
    assert_equal dave.id, session[:user_id]
  end
  
  test "should fail login" do
    dave = users(:client)
    post :create, email: dave.email, password: 'wrong'
    assert_redirected_to login_url
  end
  
  test "should logout" do
    login_as :client
    delete :destroy
    assert_redirected_to main_url
  end
end
