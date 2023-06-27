require "test_helper"

class MtoconcurrentesControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get mtoconcurrentes_index_url
    assert_response :success
  end

  test "should get show" do
    get mtoconcurrentes_show_url
    assert_response :success
  end

  test "should get new" do
    get mtoconcurrentes_new_url
    assert_response :success
  end

  test "should get create" do
    get mtoconcurrentes_create_url
    assert_response :success
  end

  test "should get edit" do
    get mtoconcurrentes_edit_url
    assert_response :success
  end

  test "should get update" do
    get mtoconcurrentes_update_url
    assert_response :success
  end
end
