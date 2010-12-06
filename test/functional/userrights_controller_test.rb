require 'test_helper'

class UserrightsControllerTest < ActionController::TestCase
  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:userrights)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create userright" do
    assert_difference('Userright.count') do
      post :create, :userright => { }
    end

    assert_redirected_to userright_path(assigns(:userright))
  end

  test "should show userright" do
    get :show, :id => userrights(:one).to_param
    assert_response :success
  end

  test "should get edit" do
    get :edit, :id => userrights(:one).to_param
    assert_response :success
  end

  test "should update userright" do
    put :update, :id => userrights(:one).to_param, :userright => { }
    assert_redirected_to userright_path(assigns(:userright))
  end

  test "should destroy userright" do
    assert_difference('Userright.count', -1) do
      delete :destroy, :id => userrights(:one).to_param
    end

    assert_redirected_to userrights_path
  end
end
