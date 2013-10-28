require 'test_helper'

class DispositivoloxicosControllerTest < ActionController::TestCase
  setup do
    @dispositivoloxico = dispositivoloxicos(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:dispositivoloxicos)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create dispositivoloxico" do
    assert_difference('Dispositivoloxico.count') do
      post :create, dispositivoloxico: {  }
    end

    assert_redirected_to dispositivoloxico_path(assigns(:dispositivoloxico))
  end

  test "should show dispositivoloxico" do
    get :show, id: @dispositivoloxico
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @dispositivoloxico
    assert_response :success
  end

  test "should update dispositivoloxico" do
    put :update, id: @dispositivoloxico, dispositivoloxico: {  }
    assert_redirected_to dispositivoloxico_path(assigns(:dispositivoloxico))
  end

  test "should destroy dispositivoloxico" do
    assert_difference('Dispositivoloxico.count', -1) do
      delete :destroy, id: @dispositivoloxico
    end

    assert_redirected_to dispositivoloxicos_path
  end
end
