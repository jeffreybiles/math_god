require 'test_helper'

class QuestsControllerTest < ActionController::TestCase
  setup do
    @quest = quests(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:quests)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create quest" do
    assert_difference('Quest.count') do
      post :create, quest: @quest.attributes
    end

    assert_redirected_to quest_path(assigns(:quest))
  end

  test "should show quest" do
    get :show, id: @quest.to_param
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @quest.to_param
    assert_response :success
  end

  test "should update quest" do
    put :update, id: @quest.to_param, quest: @quest.attributes
    assert_redirected_to quest_path(assigns(:quest))
  end

  test "should destroy quest" do
    assert_difference('Quest.count', -1) do
      delete :destroy, id: @quest.to_param
    end

    assert_redirected_to quests_path
  end
end
