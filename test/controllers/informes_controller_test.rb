require "test_helper"

class InformesControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get informes_index_url
    assert_response :success
  end

  test "should get show" do
    get informes_show_url
    assert_response :success
  end

  test "should get new" do
    get informes_new_url
    assert_response :success
  end

  test "should get create" do
    get informes_create_url
    assert_response :success
  end

  test "should get edit" do
    get informes_edit_url
    assert_response :success
  end

  test "should get update" do
    get informes_update_url
    assert_response :success
  end
end
