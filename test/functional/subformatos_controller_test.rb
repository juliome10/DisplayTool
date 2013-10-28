require 'test_helper'

class SubformatosControllerTest < ActionController::TestCase
  setup do
    @subformato = subformatos(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:subformatos)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create subformato" do
    assert_difference('Subformato.count') do
      post :create, subformato: {  }
    end

    assert_redirected_to subformato_path(assigns(:subformato))
  end

  test "should show subformato" do
    get :show, id: @subformato
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @subformato
    assert_response :success
  end

  test "should update subformato" do
    put :update, id: @subformato, subformato: {  }
    assert_redirected_to subformato_path(assigns(:subformato))
  end

  test "should destroy subformato" do
    assert_difference('Subformato.count', -1) do
      delete :destroy, id: @subformato
    end

    assert_redirected_to subformatos_path
  end
end
