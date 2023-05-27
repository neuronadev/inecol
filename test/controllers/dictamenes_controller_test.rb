require "test_helper"

class DictamenesControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get dictamenes_index_url
    assert_response :success
  end

  test "should get new" do
    get dictamenes_new_url
    assert_response :success
  end

  test "should get create" do
    get dictamenes_create_url
    assert_response :success
  end
end
