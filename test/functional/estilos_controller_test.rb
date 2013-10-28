require 'test_helper'

class EstilosControllerTest < ActionController::TestCase
  setup do
    @estilo = estilos(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:estilos)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create estilo" do
    assert_difference('Estilo.count') do
      post :create, estilo: {  }
    end

    assert_redirected_to estilo_path(assigns(:estilo))
  end

  test "should show estilo" do
    get :show, id: @estilo
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @estilo
    assert_response :success
  end

  test "should update estilo" do
    put :update, id: @estilo, estilo: {  }
    assert_redirected_to estilo_path(assigns(:estilo))
  end

  test "should destroy estilo" do
    assert_difference('Estilo.count', -1) do
      delete :destroy, id: @estilo
    end

    assert_redirected_to estilos_path
  end
end
