require "test_helper"

class MtoejercidosControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get mtoejercidos_index_url
    assert_response :success
  end

  test "should get show" do
    get mtoejercidos_show_url
    assert_response :success
  end

  test "should get new" do
    get mtoejercidos_new_url
    assert_response :success
  end

  test "should get edit" do
    get mtoejercidos_edit_url
    assert_response :success
  end

  test "should get update" do
    get mtoejercidos_update_url
    assert_response :success
  end

  test "should get create" do
    get mtoejercidos_create_url
    assert_response :success
  end
end
