require "test_helper"

class ValidacionesControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get validaciones_index_url
    assert_response :success
  end

  test "should get new" do
    get validaciones_new_url
    assert_response :success
  end

  test "should get show" do
    get validaciones_show_url
    assert_response :success
  end

  test "should get create" do
    get validaciones_create_url
    assert_response :success
  end
end
