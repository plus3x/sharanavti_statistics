require 'test_helper'

class ChartsControllerTest < ActionController::TestCase
  setup do
    login_as :client
  end

  test "should route to root" do
    assert_routing '/', { action: 'game_online', controller: 'charts' }
  end
  
  test "should get game online" do
    get :game_online
    assert_response :success
  end
  
  test "should get game online via ajax" do
    xhr :get, :game_online
    assert_response :success
    assert_not_nil assigns(:data)
  end

  test "should route to on date" do
    assert_routing '/charts/on_date', { action: 'on_date', controller: 'charts' }
  end
  
  test "should get on date" do
    get :on_date
    assert_response :success
  end
  
  test "should get on date via ajax" do
    xhr :get, :on_date
    assert_response :success
    assert_not_nil assigns(:data)
  end
  
  test "should get on date via ajax with params" do
    xhr :get, :on_date, date: { year: 2014, month: 2, day: 7}
    assert_response :success
    assert_not_nil assigns(:data)
  end
  
  test "should post new point via ajax" do
    xhr :post, :new_point
    assert_response :success
    assert_not_nil assigns(:point)
  end
end