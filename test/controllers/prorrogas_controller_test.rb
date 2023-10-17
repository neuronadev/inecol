require "test_helper"

class ProrrogasControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get prorrogas_index_url
    assert_response :success
  end

  test "should get show" do
    get prorrogas_show_url
    assert_response :success
  end

  test "should get new" do
    get prorrogas_new_url
    assert_response :success
  end

  test "should get create" do
    get prorrogas_create_url
    assert_response :success
  end

  test "should get edit" do
    get prorrogas_edit_url
    assert_response :success
  end

  test "should get update" do
    get prorrogas_update_url
    assert_response :success
  end
end
