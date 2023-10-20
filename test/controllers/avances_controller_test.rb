require "test_helper"

class AvancesControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get avances_index_url
    assert_response :success
  end

  test "should get show" do
    get avances_show_url
    assert_response :success
  end

  test "should get new" do
    get avances_new_url
    assert_response :success
  end

  test "should get create" do
    get avances_create_url
    assert_response :success
  end

  test "should get edit" do
    get avances_edit_url
    assert_response :success
  end

  test "should get update" do
    get avances_update_url
    assert_response :success
  end
end
