require 'test_helper'

class PartyrolesControllerTest < ActionController::TestCase
  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:partyroles)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create partyrole" do
    assert_difference('Partyrole.count') do
      post :create, :partyrole => { }
    end

    assert_redirected_to partyrole_path(assigns(:partyrole))
  end

  test "should show partyrole" do
    get :show, :id => partyroles(:one).to_param
    assert_response :success
  end

  test "should get edit" do
    get :edit, :id => partyroles(:one).to_param
    assert_response :success
  end

  test "should update partyrole" do
    put :update, :id => partyroles(:one).to_param, :partyrole => { }
    assert_redirected_to partyrole_path(assigns(:partyrole))
  end

  test "should destroy partyrole" do
    assert_difference('Partyrole.count', -1) do
      delete :destroy, :id => partyroles(:one).to_param
    end

    assert_redirected_to partyroles_path
  end
end
