require 'test_helper'

class OccupationclassificationsControllerTest < ActionController::TestCase
  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:occupationclassifications)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create occupationclassification" do
    assert_difference('Occupationclassification.count') do
      post :create, :occupationclassification => { }
    end

    assert_redirected_to occupationclassification_path(assigns(:occupationclassification))
  end

  test "should show occupationclassification" do
    get :show, :id => occupationclassifications(:one).to_param
    assert_response :success
  end

  test "should get edit" do
    get :edit, :id => occupationclassifications(:one).to_param
    assert_response :success
  end

  test "should update occupationclassification" do
    put :update, :id => occupationclassifications(:one).to_param, :occupationclassification => { }
    assert_redirected_to occupationclassification_path(assigns(:occupationclassification))
  end

  test "should destroy occupationclassification" do
    assert_difference('Occupationclassification.count', -1) do
      delete :destroy, :id => occupationclassifications(:one).to_param
    end

    assert_redirected_to occupationclassifications_path
  end
end
