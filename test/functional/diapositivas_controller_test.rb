require 'test_helper'

class DiapositivasControllerTest < ActionController::TestCase
  setup do
    @diapositiva = diapositivas(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:diapositivas)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create diapositiva" do
    assert_difference('Diapositiva.count') do
      post :create, diapositiva: {  }
    end

    assert_redirected_to diapositiva_path(assigns(:diapositiva))
  end

  test "should show diapositiva" do
    get :show, id: @diapositiva
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @diapositiva
    assert_response :success
  end

  test "should update diapositiva" do
    put :update, id: @diapositiva, diapositiva: {  }
    assert_redirected_to diapositiva_path(assigns(:diapositiva))
  end

  test "should destroy diapositiva" do
    assert_difference('Diapositiva.count', -1) do
      delete :destroy, id: @diapositiva
    end

    assert_redirected_to diapositivas_path
  end
end
