require "test_helper"

class FuentesControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get fuentes_index_url
    assert_response :success
  end

  test "should get show" do
    get fuentes_show_url
    assert_response :success
  end

  test "should get new" do
    get fuentes_new_url
    assert_response :success
  end

  test "should get edit" do
    get fuentes_edit_url
    assert_response :success
  end

  test "should get update" do
    get fuentes_update_url
    assert_response :success
  end

  test "should get create" do
    get fuentes_create_url
    assert_response :success
  end
end
