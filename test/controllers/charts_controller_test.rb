require 'test_helper'

class ChartsControllerTest < ActionController::TestCase
  setup do
    login_as :client
  end

  test "should route to root" do
    assert_routing '/', { action: 'game_online', controller: 'charts' }
  end
  
  test "should get game online" do
    get :geme_online
    assert_response :success
  end
  
  test "should get game online via ajax" do
    xhr :get, :geme_online
    assert_response :success
    assert_not_nil assigns(:data)
  end

  test "should route to on date" do
    assert_routing '/on_date', { action: 'on_date', controller: 'charts' }
  end
  
  test "should get on date" do
    get :on_date
    assert_response :success
  end
  
  test "should post new point via ajax" do
    xhr :post, :new_point
    assert_response :success
    assert_not_nil assigns(:point)
  end
  
  test "should get game online select via ajax" do
    xhr :post, :game_online_select, date: { year: 2014, month: 2, day: 7}
    assert_response :success
    assert_not_nil assigns(:game_online_select)
  end
end