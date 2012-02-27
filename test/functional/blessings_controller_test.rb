require 'test_helper'

class BlessingsControllerTest < ActionController::TestCase
  setup do
    @blessing = blessings(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:blessings)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create blessing" do
    assert_difference('Blessing.count') do
      post :create, blessing: @blessing.attributes
    end

    assert_redirected_to blessing_path(assigns(:blessing))
  end

  test "should show blessing" do
    get :show, id: @blessing.to_param
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @blessing.to_param
    assert_response :success
  end

  test "should update blessing" do
    put :update, id: @blessing.to_param, blessing: @blessing.attributes
    assert_redirected_to blessing_path(assigns(:blessing))
  end

  test "should destroy blessing" do
    assert_difference('Blessing.count', -1) do
      delete :destroy, id: @blessing.to_param
    end

    assert_redirected_to blessings_path
  end
end
