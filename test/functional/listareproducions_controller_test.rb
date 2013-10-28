require 'test_helper'

class ListareproducionsControllerTest < ActionController::TestCase
  setup do
    @listareproducion = listareproducions(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:listareproducions)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create listareproducion" do
    assert_difference('Listareproducion.count') do
      post :create, listareproducion: {  }
    end

    assert_redirected_to listareproducion_path(assigns(:listareproducion))
  end

  test "should show listareproducion" do
    get :show, id: @listareproducion
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @listareproducion
    assert_response :success
  end

  test "should update listareproducion" do
    put :update, id: @listareproducion, listareproducion: {  }
    assert_redirected_to listareproducion_path(assigns(:listareproducion))
  end

  test "should destroy listareproducion" do
    assert_difference('Listareproducion.count', -1) do
      delete :destroy, id: @listareproducion
    end

    assert_redirected_to listareproducions_path
  end
end
