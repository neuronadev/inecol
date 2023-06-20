require "test_helper"

class MtoautorizadosControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get mtoautorizados_index_url
    assert_response :success
  end

  test "should get show" do
    get mtoautorizados_show_url
    assert_response :success
  end

  test "should get new" do
    get mtoautorizados_new_url
    assert_response :success
  end

  test "should get edit" do
    get mtoautorizados_edit_url
    assert_response :success
  end

  test "should get update" do
    get mtoautorizados_update_url
    assert_response :success
  end

  test "should get create" do
    get mtoautorizados_create_url
    assert_response :success
  end
end
