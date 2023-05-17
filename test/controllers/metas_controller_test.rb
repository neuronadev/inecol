require "test_helper"

class MetasControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get metas_index_url
    assert_response :success
  end

  test "should get show" do
    get metas_show_url
    assert_response :success
  end

  test "should get new" do
    get metas_new_url
    assert_response :success
  end

  test "should get edit" do
    get metas_edit_url
    assert_response :success
  end

  test "should get update" do
    get metas_update_url
    assert_response :success
  end

  test "should get create" do
    get metas_create_url
    assert_response :success
  end
end
