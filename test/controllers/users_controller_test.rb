require 'test_helper'

class UsersControllerTest < ActionController::TestCase
  setup do
    @user = users(:client)
  end

  test "should get index" do
    login_as :admin
    get :index
    assert_response :success
    assert_not_nil assigns(:users)
  end

  test "should get new" do
    login_as :admin
    get :new
    assert_response :success
  end

  test "should create user" do
    login_as :admin
    assert_difference('User.count') do
      post :create, user: { email: @user.email, password: 'secret', password_confirmation: 'secret' }
    end

    assert_redirected_to user_path(assigns(:user))
  end

  test "should show user" do
    login_as :admin
    get :show, id: @user
    assert_response :success
  end

  test "should get edit" do
    login_as :admin
    get :edit, id: @user
    assert_response :success
  end

  test "should update user" do
    login_as :admin
    patch :update, id: @user, user: { email: @user.email, password: 'secret', password_confirmation: 'secret' }
    assert_redirected_to user_path(assigns(:user))
  end

  test "should destroy user" do
    login_as :admin
    assert_difference('User.count', -1) do
      delete :destroy, id: @user
    end

    assert_redirected_to users_path
  end
end
