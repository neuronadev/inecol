require "test_helper"

class RecursosControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get recursos_index_url
    assert_response :success
  end

  test "should get show" do
    get recursos_show_url
    assert_response :success
  end

  test "should get new" do
    get recursos_new_url
    assert_response :success
  end

  test "should get edit" do
    get recursos_edit_url
    assert_response :success
  end

  test "should get update" do
    get recursos_update_url
    assert_response :success
  end

  test "should get create" do
    get recursos_create_url
    assert_response :success
  end
end
