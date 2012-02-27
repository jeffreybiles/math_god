require 'test_helper'

class GodsControllerTest < ActionController::TestCase
  setup do
    @god = gods(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:gods)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create god" do
    assert_difference('God.count') do
      post :create, god: @god.attributes
    end

    assert_redirected_to god_path(assigns(:god))
  end

  test "should show god" do
    get :show, id: @god.to_param
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @god.to_param
    assert_response :success
  end

  test "should update god" do
    put :update, id: @god.to_param, god: @god.attributes
    assert_redirected_to god_path(assigns(:god))
  end

  test "should destroy god" do
    assert_difference('God.count', -1) do
      delete :destroy, id: @god.to_param
    end

    assert_redirected_to gods_path
  end
end
