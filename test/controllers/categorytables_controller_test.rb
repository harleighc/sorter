require 'test_helper'

class CategorytablesControllerTest < ActionController::TestCase
  setup do
    @categorytable = categorytables(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:categorytables)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create categorytable" do
    assert_difference('Categorytable.count') do
      post :create, categorytable: { name: @categorytable.name, owner: @categorytable.owner, rank: @categorytable.rank, system: @categorytable.system, user_id: @categorytable.user_id }
    end

    assert_redirected_to categorytable_path(assigns(:categorytable))
  end

  test "should show categorytable" do
    get :show, id: @categorytable
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @categorytable
    assert_response :success
  end

  test "should update categorytable" do
    patch :update, id: @categorytable, categorytable: { name: @categorytable.name, owner: @categorytable.owner, rank: @categorytable.rank, system: @categorytable.system, user_id: @categorytable.user_id }
    assert_redirected_to categorytable_path(assigns(:categorytable))
  end

  test "should destroy categorytable" do
    assert_difference('Categorytable.count', -1) do
      delete :destroy, id: @categorytable
    end

    assert_redirected_to categorytables_path
  end
end
