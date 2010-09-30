require 'test_helper'

class IncomeclassificationsControllerTest < ActionController::TestCase
  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:incomeclassifications)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create incomeclassification" do
    assert_difference('Incomeclassification.count') do
      post :create, :incomeclassification => { }
    end

    assert_redirected_to incomeclassification_path(assigns(:incomeclassification))
  end

  test "should show incomeclassification" do
    get :show, :id => incomeclassifications(:one).to_param
    assert_response :success
  end

  test "should get edit" do
    get :edit, :id => incomeclassifications(:one).to_param
    assert_response :success
  end

  test "should update incomeclassification" do
    put :update, :id => incomeclassifications(:one).to_param, :incomeclassification => { }
    assert_redirected_to incomeclassification_path(assigns(:incomeclassification))
  end

  test "should destroy incomeclassification" do
    assert_difference('Incomeclassification.count', -1) do
      delete :destroy, :id => incomeclassifications(:one).to_param
    end

    assert_redirected_to incomeclassifications_path
  end
end
