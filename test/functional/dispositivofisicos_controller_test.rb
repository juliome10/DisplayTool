require 'test_helper'

class DispositivofisicosControllerTest < ActionController::TestCase
  setup do
    @dispositivofisico = dispositivofisicos(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:dispositivofisicos)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create dispositivofisico" do
    assert_difference('Dispositivofisico.count') do
      post :create, dispositivofisico: {  }
    end

    assert_redirected_to dispositivofisico_path(assigns(:dispositivofisico))
  end

  test "should show dispositivofisico" do
    get :show, id: @dispositivofisico
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @dispositivofisico
    assert_response :success
  end

  test "should update dispositivofisico" do
    put :update, id: @dispositivofisico, dispositivofisico: {  }
    assert_redirected_to dispositivofisico_path(assigns(:dispositivofisico))
  end

  test "should destroy dispositivofisico" do
    assert_difference('Dispositivofisico.count', -1) do
      delete :destroy, id: @dispositivofisico
    end

    assert_redirected_to dispositivofisicos_path
  end
end
