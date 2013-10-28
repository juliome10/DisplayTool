require 'test_helper'

class CamposControllerTest < ActionController::TestCase
  setup do
    @campo = campos(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:campos)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create campo" do
    assert_difference('Campo.count') do
      post :create, campo: {  }
    end

    assert_redirected_to campo_path(assigns(:campo))
  end

  test "should show campo" do
    get :show, id: @campo
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @campo
    assert_response :success
  end

  test "should update campo" do
    put :update, id: @campo, campo: {  }
    assert_redirected_to campo_path(assigns(:campo))
  end

  test "should destroy campo" do
    assert_difference('Campo.count', -1) do
      delete :destroy, id: @campo
    end

    assert_redirected_to campos_path
  end
end
