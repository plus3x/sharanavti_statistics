require 'test_helper'

class ChartsControllerTest < ActionController::TestCase
  setup do
    login_as :client
  end

  test "should route to on date" do
    assert_routing '/on_date', { action: 'on_date', controller: 'charts' }
  end
  
  test "should get on date" do
    get :on_date
    assert_response :success
  end
  
  test "should post new dot via ajax" do
    xhr :post, :new_dot
    assert_response :success
    assert_not_nil assigns(:dot)
  end
  
  test "should get game online select via ajax" do
    xhr :post, :game_online_select, date: { year: 2014, month: 2, day: 7}
    assert_response :success
    assert_not_nil assigns(:game_online_select)
  end
end