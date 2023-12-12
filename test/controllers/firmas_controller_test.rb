require "test_helper"

class FirmasControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get firmas_index_url
    assert_response :success
  end

  test "should get show" do
    get firmas_show_url
    assert_response :success
  end

  test "should get new" do
    get firmas_new_url
    assert_response :success
  end

  test "should get create" do
    get firmas_create_url
    assert_response :success
  end
end
