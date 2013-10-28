require 'test_helper'

class DispositivoLoxicosControllerTest < ActionController::TestCase
  setup do
    @dispositivo_loxico = dispositivo_loxicos(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:dispositivo_loxicos)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create dispositivo_loxico" do
    assert_difference('DispositivoLoxico.count') do
      post :create, dispositivo_loxico: {  }
    end

    assert_redirected_to dispositivo_loxico_path(assigns(:dispositivo_loxico))
  end

  test "should show dispositivo_loxico" do
    get :show, id: @dispositivo_loxico
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @dispositivo_loxico
    assert_response :success
  end

  test "should update dispositivo_loxico" do
    put :update, id: @dispositivo_loxico, dispositivo_loxico: {  }
    assert_redirected_to dispositivo_loxico_path(assigns(:dispositivo_loxico))
  end

  test "should destroy dispositivo_loxico" do
    assert_difference('DispositivoLoxico.count', -1) do
      delete :destroy, id: @dispositivo_loxico
    end

    assert_redirected_to dispositivo_loxicos_path
  end
end
