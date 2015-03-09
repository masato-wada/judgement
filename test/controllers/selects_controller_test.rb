require 'test_helper'

class SelectsControllerTest < ActionController::TestCase
  setup do
    @select = selects(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:selects)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create select" do
    assert_difference('Select.count') do
      post :create, select: { active_flg: @select.active_flg, delete_flg: @select.delete_flg, desc: @select.desc, question_id: @select.question_id }
    end

    assert_redirected_to select_path(assigns(:select))
  end

  test "should show select" do
    get :show, id: @select
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @select
    assert_response :success
  end

  test "should update select" do
    patch :update, id: @select, select: { active_flg: @select.active_flg, delete_flg: @select.delete_flg, desc: @select.desc, question_id: @select.question_id }
    assert_redirected_to select_path(assigns(:select))
  end

  test "should destroy select" do
    assert_difference('Select.count', -1) do
      delete :destroy, id: @select
    end

    assert_redirected_to selects_path
  end
end
