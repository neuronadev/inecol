require "test_helper"

class ImpuestosControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get impuestos_index_url
    assert_response :success
  end

  test "should get show" do
    get impuestos_show_url
    assert_response :success
  end

  test "should get new" do
    get impuestos_new_url
    assert_response :success
  end

  test "should get create" do
    get impuestos_create_url
    assert_response :success
  end

  test "should get update" do
    get impuestos_update_url
    assert_response :success
  end
end
